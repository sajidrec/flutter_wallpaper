import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_app/presentation/controllers/favourite_screen_controller.dart';
import 'package:flutter_wallpaper_app/presentation/screens/full_image_view_with_wallpaper_set_option.dart';
import 'package:flutter_wallpaper_app/presentation/widgets/cached_network_image_widget.dart';
import 'package:get/get.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final FavouriteScreenController _favouriteScreenController =
      Get.find<FavouriteScreenController>();

  @override
  void initState() {
    super.initState();
    _favouriteScreenController.fetchWallpaperItemList();
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
      child: _buildScrollableImageSection(),
    ));
  }

  Widget _buildScrollableImageSection() {
    return GetBuilder<FavouriteScreenController>(builder: (_) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3 / 5,
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 12,
        ),
        shrinkWrap: true,
        itemCount: _favouriteScreenController.wallpaperItemList.length,
        itemBuilder: (context, index) => _buildWallpaperImageElement(
          onTapFunction: () {
            Get.to(
              () => FullImageViewWithWallpaperSetOption(
                imageUrl: _favouriteScreenController
                    .wallpaperItemList[index].bigImageUrl,
              ),
            );
          },
          imageUrl:
              _favouriteScreenController.wallpaperItemList[index].smallImageUrl,
          imageId: _favouriteScreenController.wallpaperItemList[index].imageId,
        ),
      );
    });
  }

  Widget _buildWallpaperImageElement({
    required String imageUrl,
    required VoidCallback onTapFunction,
    required String imageId,
  }) {
    return GestureDetector(
      onTap: onTapFunction,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
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
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              onPressed: () {
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
                        await _favouriteScreenController.deleteWallpaper(
                          imageId: imageId,
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
              },
              icon: const Icon(
                Icons.delete_outline_outlined,
                color: Colors.red,
                size: 45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
