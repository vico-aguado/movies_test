import 'package:get/get.dart';

import '../../core/theme/theme_controller.dart';
import '../controllers/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ThemeController(
          preferencesService: Get.find(),
        ));
    Get.lazyPut(() => SettingsController(
          themeController: Get.find(),
          preferencesService: Get.find(),
        ));
  }
}
