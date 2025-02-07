import 'package:get/get.dart';

import '../bindings/home_binding.dart';
import '../views/home_view.dart';
import '../views/settings_view.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => SettingsPage(),
    ),
  ];
}
