import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_app/data/models/wallpaper_element_model.dart';
import 'package:flutter_wallpaper_app/data/utils/shared_pref_keys.dart';
import 'package:flutter_wallpaper_app/presentation/controllers/search_result_screen_controller.dart';
import 'package:flutter_wallpaper_app/presentation/screens/full_image_view_with_wallpaper_set_option.dart';
import 'package:flutter_wallpaper_app/presentation/utils/app_color.dart';
import 'package:flutter_wallpaper_app/presentation/widgets/create_appbar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchResultScreen extends StatefulWidget {
  final String searchKeyword;

  const SearchResultScreen({
    super.key,
    required this.searchKeyword,
  });

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  final _searchResultScreenController =
      Get.find<SearchResultScreenController>();

  @override
  void initState() {
    super.initState();
    _searchResultScreenController.fetchWallpaperList(
      searchKeyword: widget.searchKeyword,
    );
    _searchResultScreenController.clearWallpaperList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12.withOpacity(0.1),
      appBar: CreateAppbar(
        searchKeyword: widget.searchKeyword,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 12,
        ),
        child: Stack(
          children: [
            _buildScrollableImageSection(),
            _buildLoadMoreButton(),
            const SizedBox(
              height: 3,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLoadMoreButton() {
    return Positioned(
      bottom: 8,
      left: 12,
      right: 12,
      child: GetBuilder<SearchResultScreenController>(builder: (_) {
        return InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            _searchResultScreenController.increaseSearchPageNumber();
            _searchResultScreenController.fetchWallpaperList(
                searchKeyword: widget.searchKeyword);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade700.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
            ),
            height: 50,
            child: const Center(
              child: Text(
                "Load more...",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildScrollableImageSection() {
    return Positioned(
      child: GetBuilder<SearchResultScreenController>(builder: (_) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 3 / 5,
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 12,
          ),
          shrinkWrap: true,
          itemCount: _searchResultScreenController.wallpaperItemList.length,
          itemBuilder: (context, index) => _buildWallpaperImageElement(
            onTapFunction: () {
              Get.to(
                () => FullImageViewWithWallpaperSetOption(
                  imageUrl: _searchResultScreenController
                      .wallpaperItemList[index].bigImageUrl,
                ),
              );
            },
            smallImageUrl: _searchResultScreenController
                .wallpaperItemList[index].smallImageUrl,
            isFavourite: _searchResultScreenController
                .wallpaperItemList[index].isFavourite,
            index: index,
          ),
        );
      }),
    );
  }

  Widget _buildWallpaperImageElement({
    required String smallImageUrl,
    required VoidCallback onTapFunction,
    required bool isFavourite,
    required int index,
  }) {
    return GestureDetector(
      onTap: onTapFunction,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildLoadNetworkImage(smallImageUrl),
          _buildFavouriteIconButton(
            isFavourite: isFavourite,
            index: index,
          ),
        ],
      ),
    );
  }

  Widget _buildFavouriteIconButton({
    required bool isFavourite,
    required int index,
  }) {
    return Positioned(
      top: 5,
      right: 5,
      child: GetBuilder<SearchResultScreenController>(builder: (_) {
        return IconButton(
          onPressed: () async {
            if (isFavourite) {
              Get.defaultDialog(
                middleText: "",
                contentPadding: const EdgeInsets.all(12),
                title: "You sure want to remove from favourite?",
                backgroundColor: Colors.white,
                actions: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.red),
                    ),
                    onPressed: () async {
                      _searchResultScreenController.setFavouriteStatus(
                        index: index,
                        isFavourite: false,
                      );

                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();

                      List<String> favWallpaperList =
                          sharedPreferences.getStringList(
                                SharedPrefKeys.favouriteImageKey,
                              ) ??
                              [];

                      WallpaperElement wallpaperElement =
                          _searchResultScreenController.getWallpaperItem(
                              index: index);

                      String targetImageId = wallpaperElement.imageId;

                      for (int i = 0; i < favWallpaperList.length; i++) {
                        if (jsonDecode(favWallpaperList[i])["imageId"] ==
                            targetImageId) {
                          favWallpaperList.removeAt(i);
                          break;
                        }
                      }

                      await sharedPreferences.setStringList(
                        SharedPrefKeys.favouriteImageKey,
                        favWallpaperList,
                      );

                      Get.back();
                    },
                    child: const Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      "NO",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              );
            } else {
              _searchResultScreenController.setFavouriteStatus(
                index: index,
                isFavourite: true,
              );

              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();

              List<String> favWallpaperList = sharedPreferences
                      .getStringList(SharedPrefKeys.favouriteImageKey) ??
                  [];

              WallpaperElement wallpaperElement =
                  _searchResultScreenController.getWallpaperItem(index: index);

              favWallpaperList.add(
                jsonEncode(
                  wallpaperElement.toJson(),
                ),
              );

              await sharedPreferences.setStringList(
                SharedPrefKeys.favouriteImageKey,
                favWallpaperList,
              );
            }
          },
          icon: Icon(
            isFavourite ? Icons.favorite : Icons.favorite_border_outlined,
            color: Colors.red,
            size: 45,
          ),
        );
      }),
    );
  }

  Widget _buildLoadNetworkImage(String smallImageUrl) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress != null) {
              return CircularProgressIndicator(
                color: AppColor.circularProgressColor,
              );
            }
            return child;
          },
          smallImageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
