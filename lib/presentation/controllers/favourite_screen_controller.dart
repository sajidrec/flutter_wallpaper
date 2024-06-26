import 'dart:convert';
import 'package:flutter_wallpaper_app/data/models/wallpaper_element_model.dart';
import 'package:flutter_wallpaper_app/data/utils/persistent_keys.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteScreenController extends GetxController {
  final List<WallpaperElement> _wallpaperItemList = [];

  List<WallpaperElement> get wallpaperItemList => _wallpaperItemList;

  Future<void> fetchWallpaperItemList() async {
    _wallpaperItemList.clear();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> favWallpaperList = sharedPreferences.getStringList(
          PersistentKeys.favouriteImageKey,
        ) ??
        [];

    for (int i = 0; i < favWallpaperList.length; i++) {
      WallpaperElement wallpaperElement = WallpaperElement.fromJson(
        jsonDecode(
          favWallpaperList[i],
        ),
      );
      _wallpaperItemList.add(wallpaperElement);
    }
    update();
  }

  Future<void> deleteWallpaper({
    required String imageId,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<String> favWallpaperList = sharedPreferences.getStringList(
          PersistentKeys.favouriteImageKey,
        ) ??
        [];

    for (int i = 0; i < favWallpaperList.length; i++) {
      if (jsonDecode(favWallpaperList[i])["imageId"] == imageId) {
        favWallpaperList.removeAt(i);
        break;
      }
    }

    await sharedPreferences.setStringList(
      PersistentKeys.favouriteImageKey,
      favWallpaperList,
    );

    fetchWallpaperItemList();
  }
}
