import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_app/data/services/set_lock_screen_service.dart';
import 'package:flutter_wallpaper_app/data/services/set_wallpaper_service.dart';
import 'package:flutter_wallpaper_app/presentation/widgets/cached_network_image_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

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
            height: 16,
          ),
          _buildSetLockScreenButton(),
          Expanded(
            child: InteractiveViewer(
              child: cachedNetworkImageFetcher(
                imageUrl: imageUrl,
                boxFit: BoxFit.contain,
              ),
            ),
          ),
          _buildSetWallpaperButton(),
        ],
      ),
    );
  }

  Widget _buildSetWallpaperButton() {
    return InkWell(
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
                await Fluttertoast.showToast(
                  msg: "Wait while setting the wallpaper for you.",
                  textColor: Colors.white,
                  backgroundColor: Colors.black,
                  fontSize: 20,
                );

                Get.back();

                if (await SetWallpaperService(imageUrl: imageUrl)
                    .setWallpaper()) {
                  await Fluttertoast.showToast(
                    msg: "Wallpaper set was successful.",
                    textColor: Colors.white,
                    backgroundColor: Colors.green,
                    fontSize: 20,
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: "Wallpaper set Failed",
                    textColor: Colors.white,
                    backgroundColor: Colors.red,
                    fontSize: 20,
                  );
                }
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
        decoration: BoxDecoration(
          color: Colors.grey.shade600.withOpacity(0.80),
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        height: 45,
        child: const Center(
          child: Text(
            "Set As Wallpaper",
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }

  Widget _buildSetLockScreenButton() {
    return InkWell(
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
                await Fluttertoast.showToast(
                  msg: "Wait while setting the lock screen for you.",
                  textColor: Colors.white,
                  backgroundColor: Colors.black,
                  fontSize: 20,
                );

                Get.back();

                if (await SetLockScreenService(imageUrl: imageUrl)
                    .setLockScreen()) {
                  await Fluttertoast.showToast(
                    msg: "Lockscreen set was successful.",
                    textColor: Colors.white,
                    backgroundColor: Colors.green,
                    fontSize: 20,
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: "Lockscreen set Failed",
                    textColor: Colors.white,
                    backgroundColor: Colors.red,
                    fontSize: 20,
                  );
                }
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
        decoration: BoxDecoration(
          color: Colors.grey.shade600.withOpacity(0.80),
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        height: 45,
        child: const Center(
          child: Text(
            "Set As Lockscreen",
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }
}
