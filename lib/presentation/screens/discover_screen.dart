import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_app/presentation/controllers/discover_screen_controller.dart';
import 'package:flutter_wallpaper_app/presentation/screens/full_image_view_with_wallpaper_set_option.dart';
import 'package:flutter_wallpaper_app/presentation/widgets/cached_network_image_widget.dart';
import 'package:get/get.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final _discoverScreenController = Get.find<DiscoverScreenController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _discoverScreenController.fetchWallpaperList(
      scrollController: _scrollController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          bottom: 5,
          left: 12,
          right: 12,
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
    return GetBuilder<DiscoverScreenController>(builder: (_) {
      return Positioned(
        bottom: 8,
        left: 12,
        right: 12,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            _discoverScreenController.increaseSearchPageNumber();
            _discoverScreenController.fetchWallpaperList(
              scrollController: _scrollController,
            );
          },
          child: (_discoverScreenController.getWallpaperItemList.isNotEmpty)
              ? Container(
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
                )
              : const SizedBox(),
        ),
      );
    });
  }

  Widget _buildScrollableImageSection() {
    return Positioned(
      child: GetBuilder<DiscoverScreenController>(
        builder: (_) {
          return GridView.builder(
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3 / 5,
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 12,
            ),
            shrinkWrap: true,
            itemCount: _discoverScreenController.getWallpaperItemList.length,
            itemBuilder: (context, index) => _buildWallpaperImageElement(
              onTapFunction: () {
                Get.to(
                  () => FullImageViewWithWallpaperSetOption(
                    imageUrl: _discoverScreenController
                        .getWallpaperItemList[index].bigImageUrl,
                  ),
                );
              },
              imageUrl: _discoverScreenController
                  .getWallpaperItemList[index].smallImageUrl,
              isFavourite: _discoverScreenController
                  .getWallpaperItemList[index].isFavourite,
              index: index,
            ),
          );
        },
      ),
    );
  }

  Widget _buildWallpaperImageElement({
    required String imageUrl,
    required VoidCallback onTapFunction,
    required bool isFavourite,
    required int index,
  }) {
    return GestureDetector(
      onTap: onTapFunction,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildFetchImage(imageUrl),
          _buildFavouriteIconButton(
            isFavourite: isFavourite,
            index: index,
          ),
        ],
      ),
    );
  }

  Widget _buildFetchImage(String imageUrl) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: cachedNetworkImageFetcher(
          imageUrl: imageUrl,
          boxFit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildFavouriteIconButton(
      {required bool isFavourite, required int index}) {
    return Positioned(
      top: 5,
      right: 5,
      child: GetBuilder<DiscoverScreenController>(builder: (_) {
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
                      _discoverScreenController.setFavouriteStatus(
                        index: index,
                        isFavourite: false,
                      );

                      _discoverScreenController.deleteFromFavourite(
                        index: index,
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
              _discoverScreenController.setFavouriteStatus(
                index: index,
                isFavourite: true,
              );
              _discoverScreenController.addToFavouriteList(index: index);
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
}
