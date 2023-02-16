import 'package:demo_app/app/controllers/app_controller.dart';
import 'package:demo_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends GetView<AppController> {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('SETTINGS'),
      ),
      body: ListView(
        children:
            ListTile.divideTiles(color: context.theme.dividerColor, tiles: [
          SwitchListTile.adaptive(
              secondary: Icon(controller.isDark
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined),
              title: const Text('Dark mode'),
              value: controller.isDark,
              onChanged: controller.changeTheme),
          ListTile(
            leading: const Icon(Icons.shopping_cart_outlined),
            title: const Text('Maximum cart items'),
            trailing: Text('${AppData.maxCartValue}'),
          ),
          ListTile(
            leading: const Icon(Icons.font_download_outlined),
            title: const Text('Default font family'),
            trailing: Text(AppData.fontFamily),
          ),
          ListTile(
            leading: const Icon(Icons.timer_outlined),
            title: const Text('HTTP timeout duration'),
            trailing: Text('${AppData.httpTimeout.inSeconds} seconds'),
          ),
        ]).toList(),
      ),
    );
  }
}
