import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_wallpaper_app/presentation/screens/main_bottom_nav_screen.dart';
import 'package:flutter_wallpaper_app/presentation/utils/app_color.dart';
import 'package:flutter_wallpaper_app/presentation/utils/assets_path.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _moveToHomeScreen();
  }

  Future<void> _moveToHomeScreen() async {
    Timer(const Duration(milliseconds: 3500), () {
      Get.off(() => const MainBottomNavScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.black87,
          ),
          SvgPicture.asset(
            AssetsPath.backgroundSvg,
            height: Get.height,
            width: Get.width,
            fit: BoxFit.cover,
          ),
          Center(
            child: Shimmer.fromColors(
              baseColor: Colors.yellowAccent,
              highlightColor: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogoText(),
                  const SizedBox(height: 16),
                  _buildSubtitleText(),
                  const SizedBox(height: 16),
                  CircularProgressIndicator(
                    color: AppColor.circularProgressColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text _buildSubtitleText() {
    return const Text(
      "Set beautiful wallpaper on your device",
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    );
  }

  Widget _buildLogoText() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.yellowAccent.shade400.withOpacity(0.75),
          fontSize: 50,
          fontWeight: FontWeight.w600,
        ),
        children: [
          TextSpan(
            text: "Sajid ",
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
            ),
          ),
          const TextSpan(text: "Studio"),
        ],
      ),
    );
  }
}
