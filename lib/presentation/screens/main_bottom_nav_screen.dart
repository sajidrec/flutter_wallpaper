import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_app/presentation/controllers/main_bottom_nav_screen_controller.dart';
import 'package:flutter_wallpaper_app/presentation/utils/app_color.dart';
import 'package:get/get.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: GetBuilder<MainBottomNavScreenController>(
        builder: (controller) => controller.getCurrentScreen(),
      ),
      bottomNavigationBar: GetBuilder<MainBottomNavScreenController>(
          builder: (mainBottomNavController) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: mainBottomNavController.currentItemIndex,
          onTap: (index) {
            mainBottomNavController.changeNavigationIndex(index);
          },
          backgroundColor: AppColor.bottomNavColor,
          elevation: 3,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.65),
          unselectedLabelStyle: const TextStyle(fontSize: 0),
          items: _buildBottomNavItems(),
        );
      }),
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavItems() {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home_filled),
        label: "Home",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: "Search",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: "Favourite",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.auto_awesome),
        label: "Discover",
      ),
    ];
  }
}
