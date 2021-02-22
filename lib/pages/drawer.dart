import 'package:flutter/material.dart';
import 'package:todotrial/widgets/createDrawerBodyItem.dart';
import 'package:todotrial/widgets/createDrawerHeader.dart';
import 'package:todotrial/routes/pageRoute.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(),
          createDrawerBodyItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () => {
                    Navigator.pushReplacementNamed(context, pageRoutes.home),
                  }),
          createDrawerBodyItem(
              icon: Icons.account_circle,
              text: 'Profile',
              onTap: () => {
                    Navigator.pushReplacementNamed(context, pageRoutes.login),
                  }),
          ListTile(
            title: Text('App version 1.0.0'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
