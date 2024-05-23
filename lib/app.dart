import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_app/controller_binder.dart';
import 'package:flutter_wallpaper_app/presentation/screens/splash_screen.dart';
import 'package:flutter_wallpaper_app/presentation/utils/app_color.dart';
import 'package:get/get.dart';

class WallpaperApp extends StatelessWidget {
  const WallpaperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: _buildThemeData(),
      initialBinding: ControllerBinder(),
      home: const SplashScreen(),
    );
  }

  ThemeData _buildThemeData() {
    return ThemeData(
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
        bodySmall: TextStyle(color: Colors.white),
      ),
      scaffoldBackgroundColor: AppColor.appBackgroundColor,
    );
  }
}
