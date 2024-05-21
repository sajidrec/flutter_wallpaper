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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isFavourite'] = isFavourite;
    data['smallImageUrl'] = smallImageUrl;
    data['bigImageUrl'] = bigImageUrl;
    data['imageId'] = imageId;
    return data;
  }
}
