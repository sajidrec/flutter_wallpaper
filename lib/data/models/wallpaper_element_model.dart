class WallpaperElement {
  late bool isFavourite;

  late final String smallImageUrl;
  late final String bigImageUrl;
  late final String imageId;

  WallpaperElement({
    required this.smallImageUrl,
    required this.bigImageUrl,
    required this.imageId,
    this.isFavourite = false,
  });

  WallpaperElement.fromJson(Map<String, dynamic> json) {
    isFavourite = json['isFavourite'];
    smallImageUrl = json['smallImageUrl'];
    bigImageUrl = json['bigImageUrl'];
    imageId = json['imageId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isFavourite'] = isFavourite;
    data['smallImageUrl'] = smallImageUrl;
    data['bigImageUrl'] = bigImageUrl;
    data['imageId'] = imageId;
    return data;
  }
}
