import 'package:get/get.dart';

import '../../core/theme/theme_controller.dart';
import '../controllers/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ThemeController());
    Get.lazyPut(() => SettingsController(themeController: Get.find()));
  }
}
