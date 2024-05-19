import 'dart:convert';

import 'package:flutter_wallpaper_app/data/models/wallpaper_element_model.dart';
import 'package:flutter_wallpaper_app/data/utils/urls.dart';
import 'package:flutter_wallpaper_app/presentation/secrate/api_key.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchResultScreenController extends GetxController {
  final List<WallpaperElementModel> _wallpaperItemList = [];

  List<WallpaperElementModel> get wallpaperItemList => _wallpaperItemList;

  void clearWallpaperList() {
    _wallpaperItemList.clear();
  }

  final int _searchPageNumber = 1;

  Future<void> getWallpaperList({required searchKeyword}) async {
    final http.Response response = await http.get(
      Uri.parse(
        Urls.getSearchUrl(
          searchKeyword: searchKeyword,
          pageNumber: _searchPageNumber,
        ),
      ),
      headers: {"Authorization": apiKey},
    );

    for (int i = 0; i < jsonDecode(response.body)["photos"].length; i++) {
      _wallpaperItemList.add(
        WallpaperElementModel(
          smallImageUrl: jsonDecode(response.body)["photos"][i]["src"]["medium"]
              .toString(),
          imageId: jsonDecode(response.body)["photos"][i]["id"].toString(),
          bigImageUrl: jsonDecode(response.body)["photos"][i]["src"]["original"]
              .toString(),
        ),
      );
    }
    update();
  }
}
