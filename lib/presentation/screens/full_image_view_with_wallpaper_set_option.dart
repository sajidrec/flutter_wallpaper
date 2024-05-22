import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_app/presentation/widgets/cached_network_image_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:wallpaper_handler/wallpaper_handler.dart';

class FullImageViewWithWallpaperSetOption extends StatelessWidget {
  final String imageUrl;

  const FullImageViewWithWallpaperSetOption({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Expanded(
              child: cachedNetworkImageFetcher(
            imageUrl: imageUrl,
            boxFit: BoxFit.contain,
          )),
          InkWell(
            onTap: () {
              Get.defaultDialog(
                middleText: "",
                contentPadding: const EdgeInsets.all(12),
                title: "Are you sure?",
                backgroundColor: Colors.white,
                actions: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.red),
                    ),
                    onPressed: () async {
                      Fluttertoast.showToast(
                        msg: "Wait while setting the wallpaper for you.",
                        textColor: Colors.white,
                        backgroundColor: Colors.black,
                        fontSize: 20,
                      );
                      Get.back();

                      final file =
                          await DefaultCacheManager().getSingleFile(imageUrl);

                      await WallpaperHandler.instance.setWallpaperFromFile(
                        file.path,
                        WallpaperLocation.homeScreen,
                      );

                      Fluttertoast.showToast(
                        msg: "Wallpaper set was successful.",
                        textColor: Colors.white,
                        backgroundColor: Colors.green,
                        fontSize: 20,
                      );
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
            child: Container(
              color: Colors.grey.shade600.withOpacity(0.80),
              height: 70,
              child: const Center(
                child: Text(
                  "Set as wallpaper",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
