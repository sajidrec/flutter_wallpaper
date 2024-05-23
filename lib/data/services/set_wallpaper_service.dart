import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_app/data/utils/shared_pref_keys.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallpaper_handler/wallpaper_handler.dart';

import '../../secret/api_key.dart';

class SetWallpaperService {
  late final String imageUrl;

  SetWallpaperService({
    required this.imageUrl,
  }) {
    setWallpaper();
  }

  Future<void> setWallpaper() async {
    try {
      await DefaultCacheManager().removeFile(
        PersistentKeys.wallpaperKey,
      );

      final file = await DefaultCacheManager().getSingleFile(
        imageUrl,
        key: PersistentKeys.wallpaperKey,
        headers: {"Authorization": apiKey},
      );

      await DefaultCacheManager().removeFile(
        PersistentKeys.wallpaperKey,
      );

      await WallpaperHandler.instance.setWallpaperFromFile(
        file.path,
        WallpaperLocation.homeScreen,
      );
    } catch (e) {
      await Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: "Wallpaper set unsuccessful please try again.",
      );
    }
  }
}
