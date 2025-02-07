import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              'Movie App',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: Text('home'.tr),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            title: Text('settings'.tr),
            onTap: () {
              Get.toNamed('/settings');
            },
          ),
        ],
      ),
    );
  }
}
