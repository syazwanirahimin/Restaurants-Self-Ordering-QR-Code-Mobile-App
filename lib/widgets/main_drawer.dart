import 'package:flutter/material.dart';

import '../screens/categories_screen.dart';
import '../screens/scan_screen.dart';

class MainDrawer extends StatelessWidget {
  static const routName = '/main-drawer';

  Widget buildListTile(String title, IconData icon, Function onTap) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Digital Menu',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          this.buildListTile(
            'Scan',
            Icons.qr_code_scanner,
                () {
              Navigator.of(context).pushReplacementNamed(ScanScreen.routName);
            },
          ),
          this.buildListTile(
            'Menu',
            Icons.restaurant,
            () {
              Navigator.of(context).pushReplacementNamed(CategoriesScreen.routName);
            },
          ),
        ],
      ),
    );
  }
}
