class WallpaperElementModel {
  bool isFavourite;

  final String smallImageUrl;
  final String bigImageUrl;
  final String imageId;

  WallpaperElementModel({
    required this.smallImageUrl,
    required this.bigImageUrl,
    required this.imageId,
    this.isFavourite = false,
  });
}
