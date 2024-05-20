import 'dart:convert';

import 'package:flutter_wallpaper_app/data/models/wallpaper_element_model.dart';
import 'package:flutter_wallpaper_app/data/services/network_caller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../data/utils/urls.dart';

class SearchResultScreenController extends GetxController {
  final List<WallpaperElementModel> _wallpaperItemList = [];

  List<WallpaperElementModel> get wallpaperItemList => _wallpaperItemList;

  void clearWallpaperList() {
    _wallpaperItemList.clear();
  }

  final int _searchPageNumber = 1;

  Future<void> fetchWallpaperList({required searchKeyword}) async {

    final http.Response response = await NetworkCaller.getRequest(
      url: Urls.getSearchUrl(
        searchKeyword: searchKeyword,
        pageNumber: _searchPageNumber,
      ),
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
