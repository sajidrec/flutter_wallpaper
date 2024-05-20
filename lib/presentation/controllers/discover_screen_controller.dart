import 'dart:convert';
import 'package:flutter_wallpaper_app/data/models/wallpaper_element_model.dart';
import 'package:flutter_wallpaper_app/data/services/network_caller.dart';
import 'package:flutter_wallpaper_app/data/utils/urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DiscoverScreenController extends GetxController {
  final List<WallpaperElementModel> _wallpaperItemList = [];

  List<WallpaperElementModel> get wallpaperItemList => _wallpaperItemList;

  int _searchPageNumber = 1;

  void increaseSearchPageNumber() {
    _searchPageNumber++;
  }

  Future<void> fetchWallpaperList() async {
    final http.Response response = await NetworkCaller.getRequest(
      url: Urls.getRandomImageListUrl(
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
