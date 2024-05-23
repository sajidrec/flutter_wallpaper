import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_handler/wallpaper_handler.dart';

class SetWallpaperService {
  late final String imageUrl;

  SetWallpaperService({
    required this.imageUrl,
  }) {
    setWallpaper();
  }

  Future<void> setWallpaper() async {
    final file = await DefaultCacheManager().getSingleFile(imageUrl);

    await WallpaperHandler.instance.setWallpaperFromFile(
      file.path,
      WallpaperLocation.homeScreen,
    );
  }
}
