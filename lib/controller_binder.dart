import 'package:flutter_wallpaper_app/presentation/controllers/main_bottom_nav_screen_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(MainBottomNavScreenController());
  }
}
