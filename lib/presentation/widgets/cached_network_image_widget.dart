import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_app/presentation/utils/app_color.dart';
import 'package:shimmer/shimmer.dart';

Widget cachedNetworkImageFetcher({
  required String imageUrl,
  required BoxFit boxFit,
}) {
  return CachedNetworkImage(
    fit: boxFit,
    imageUrl: imageUrl,
    placeholder: (context, imageUrl) => Shimmer.fromColors(
      baseColor: AppColor.appBackgroundColor,
      highlightColor: Colors.white,
      child: Container(
        color: AppColor.appBackgroundColor,
      ),
    ),
    errorWidget: (context, imageUrl, error) => const Icon(
      Icons.error,
      color: Colors.red,
    ),
  );
}
