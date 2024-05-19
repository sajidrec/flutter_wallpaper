import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_app/presentation/screens/discover_screen.dart';
import 'package:flutter_wallpaper_app/presentation/screens/favourite_screen.dart';
import 'package:flutter_wallpaper_app/presentation/screens/home_screen.dart';
import 'package:flutter_wallpaper_app/presentation/screens/search_screen.dart';
import 'package:get/get.dart';

class MainBottomNavScreenController extends GetxController {
  int _currentItemIndex = 0;

  int get currentItemIndex => _currentItemIndex;

  final List _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const FavouriteScreen(),
    const DiscoverScreen(),
  ];

  Widget getCurrentScreen() {
    return _screens[_currentItemIndex];
  }

  void changeNavigationIndex(int index) {
    _currentItemIndex = index;
    update();
  }
}
