import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('DEMOAPP'), Text('v1.0.0')],
              ),
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.shop),
              title: const Text('Shop'),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
