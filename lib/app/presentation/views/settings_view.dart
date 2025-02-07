import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('change_language'.tr),
            DropdownButton<String>(
              value: Get.locale?.languageCode ?? 'en',
              onChanged: (value) {
                if (value != null) {
                  controller.changeLanguage(value);
                }
              },
              items: ['en', 'es'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value == 'en' ? 'English' : 'Español'),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Obx(() {
              final isDarkMode = controller.themeController.isDarkMode.value;
              return SwitchListTile(
                title: Text(isDarkMode ? 'dark_mode'.tr : 'light_mode'.tr),
                value: isDarkMode,
                onChanged: (value) {
                  controller.toggleTheme();
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
