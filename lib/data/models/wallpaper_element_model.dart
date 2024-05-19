class WallpaperElementModel {
  bool isFavourite;

  final String imageUrl;
  final String imageId;

  WallpaperElementModel({
    required this.imageUrl,
    required this.imageId,
    this.isFavourite = false,
  });
}
