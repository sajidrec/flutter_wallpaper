import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_app/data/utils/shared_pref_keys.dart';
import 'package:wallpaper_handler/wallpaper_handler.dart';

import '../../secret/api_key.dart';

class SetWallpaperService {
  late final String imageUrl;

  SetWallpaperService({
    required this.imageUrl,
  });

  Future<bool> setWallpaper() async {
    try {
      await DefaultCacheManager().removeFile(
        PersistentKeys.wallpaperKey,
      );

      final file = await DefaultCacheManager().getSingleFile(
        imageUrl,
        key: PersistentKeys.wallpaperKey,
        headers: {"Authorization": apiKey},
      );

      bool result = await WallpaperHandler.instance.setWallpaperFromFile(
        file.path,
        WallpaperLocation.homeScreen,
      );

      return result;
    } catch (e) {
      return false;
    }
  }
}
