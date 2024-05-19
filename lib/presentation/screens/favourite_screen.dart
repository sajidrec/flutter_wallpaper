
import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_app/data/models/wallpaper_fav_element_model.dart';
import 'package:flutter_wallpaper_app/presentation/screens/full_image_view_with_wallpaper_set_option.dart';
import 'package:flutter_wallpaper_app/presentation/utils/app_color.dart';
import 'package:get/get.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final List<WallpaperFavElementModel> _wallpaperItemList = [
    WallpaperFavElementModel(
      imageId: "3258",
      imageUrl:
          "https://media.licdn.com/dms/image/D5603AQEG3ImJG2qDxg/profile-displayphoto-shrink_200_200/0/1699261220322?e=2147483647&v=beta&t=fcAwTYrs3rLJ4evKKW1Pr9qCzJvyvqzTtwYHL1WBA6I",
    ),
    WallpaperFavElementModel(
      imageId: "3288",
      imageUrl:
          "https://media.licdn.com/dms/image/D5603AQEG3ImJG2qDxg/profile-displayphoto-shrink_200_200/0/1699261220322?e=2147483647&v=beta&t=fcAwTYrs3rLJ4evKKW1Pr9qCzJvyvqzTtwYHL1WBA6I",
    ),
    WallpaperFavElementModel(
      imageId: "3277",
      imageUrl:
          "https://media.licdn.com/dms/image/D5603AQEG3ImJG2qDxg/profile-displayphoto-shrink_200_200/0/1699261220322?e=2147483647&v=beta&t=fcAwTYrs3rLJ4evKKW1Pr9qCzJvyvqzTtwYHL1WBA6I",
    ),
  ];

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
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 3 / 5,
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 12,
      ),
      shrinkWrap: true,
      itemCount: _wallpaperItemList.length,
      itemBuilder: (context, index) => _buildWallpaperImageElement(
        onTapFunction: () {
          Get.to(
            FullImageViewWithWallpaperSetOption(
              imageUrl: _wallpaperItemList[index].imageUrl,
            ),
          );
        },
        imageUrl: _wallpaperItemList[index].imageUrl,
      ),
    );
  }

  Widget _buildWallpaperImageElement({
    required String imageUrl,
    required VoidCallback onTapFunction,
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
              child: Image.network(
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return CircularProgressIndicator(
                      color: AppColor.circularProgressColor,
                    );
                  }
                  return child;
                },
                imageUrl,
                fit: BoxFit.cover,
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
                      onPressed: () {},
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
