import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_app/data/utils/persistent_keys.dart';
import 'package:wallpaper_handler/wallpaper_handler.dart';

import '../../secret/api_key.dart';

class SetLockScreenService {
  late final String imageUrl;

  SetLockScreenService({
    required this.imageUrl,
  });

  Future<bool> setLockScreen() async {
    try {
      await DefaultCacheManager().removeFile(
        PersistentKeys.lockScreenKey,
      );

      final file = await DefaultCacheManager().getSingleFile(
        imageUrl,
        key: PersistentKeys.lockScreenKey,
        headers: {"Authorization": apiKey},
      );

      bool result = await WallpaperHandler.instance.setWallpaperFromFile(
        file.path,
        WallpaperLocation.lockScreen,
      );
      return result;
    } catch (e) {
      return false;
    }
  }
}
