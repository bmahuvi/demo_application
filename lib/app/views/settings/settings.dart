import 'package:demo_application/app/provider/providers.dart';
import 'package:demo_application/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
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
            ListTile.divideTiles(color: Theme.of(context).dividerColor, tiles: [
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
          Consumer<ChangeThemeProvider>(
            builder: (context, theme, child) => SwitchListTile.adaptive(
              value: theme.isDark,
              secondary: Icon(theme.isDark
                  ? Icons.nightlight_round
                  : Icons.wb_sunny_outlined),
              title: const Text('Dark mode'),
              onChanged: theme.changeTheme,
            ),
          )
        ]).toList(),
      ),
    );
  }
}
