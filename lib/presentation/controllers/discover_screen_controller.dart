import 'dart:convert';
import 'package:flutter_wallpaper_app/data/models/wallpaper_element_model.dart';
import 'package:flutter_wallpaper_app/data/services/network_caller.dart';
import 'package:flutter_wallpaper_app/data/utils/shared_pref_keys.dart';
import 'package:flutter_wallpaper_app/data/utils/urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DiscoverScreenController extends GetxController {
  final List<WallpaperElement> _wallpaperItemList = [];

  List<WallpaperElement> get getWallpaperItemList => _wallpaperItemList;

  WallpaperElement getWallpaperItem({required int index}) {
    return _wallpaperItemList[index];
  }

  void setFavouriteStatus({
    required int index,
    required bool isFavourite,
  }) {
    _wallpaperItemList[index].isFavourite = isFavourite;
    update();
  }

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

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final favListSharedPref = sharedPreferences.getStringList(
      SharedPrefKeys.favouriteImageKey,
    );

    List<String> listOfFavImageId = [];

    for (int i = 0; i < (favListSharedPref?.length ?? 0); i++) {
      listOfFavImageId.add(jsonDecode(favListSharedPref![i])["imageId"]);
    }

    for (int i = 0; i < jsonDecode(response.body)["photos"].length; i++) {
      bool isFavourite = listOfFavImageId.contains(
        jsonDecode(response.body)["photos"][i]["id"].toString(),
      );
      _wallpaperItemList.add(
        WallpaperElement(
          smallImageUrl: jsonDecode(response.body)["photos"][i]["src"]["medium"]
              .toString(),
          imageId: jsonDecode(response.body)["photos"][i]["id"].toString(),
          bigImageUrl: jsonDecode(response.body)["photos"][i]["src"]["original"]
              .toString(),
          isFavourite: isFavourite,
        ),
      );
    }

    listOfFavImageId.clear();

    update();
  }

  Future<void> deleteFromFavourite({required int index}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<String> favWallpaperList = sharedPreferences.getStringList(
          SharedPrefKeys.favouriteImageKey,
        ) ??
        [];

    for (int i = 0; i < favWallpaperList.length; i++) {
      if (jsonDecode(favWallpaperList[i])["imageId"] ==
          _wallpaperItemList[index].imageId) {
        favWallpaperList.removeAt(i);
        break;
      }
    }

    await sharedPreferences.setStringList(
      SharedPrefKeys.favouriteImageKey,
      favWallpaperList,
    );
  }

  Future<void> addToFavouriteList({required int index}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<String> favWallpaperList =
        sharedPreferences.getStringList(SharedPrefKeys.favouriteImageKey) ?? [];

    favWallpaperList.add(
      jsonEncode(
        _wallpaperItemList[index].toJson(),
      ),
    );

    await sharedPreferences.setStringList(
      SharedPrefKeys.favouriteImageKey,
      favWallpaperList,
    );
  }
}
