import 'package:flutter/material.dart';
import 'package:flutter_chat_app_basic/core/companent/drawer/list_tile_drawer.dart';

class DrawerCustom extends StatelessWidget {
  final VoidCallback onProfileTap;
  final VoidCallback onSignOut;
  final VoidCallback chatTap;
  const DrawerCustom(
      {super.key,
      required this.onProfileTap,
      required this.onSignOut,
      required this.chatTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            //header
            const DrawerHeader(
                child: Icon(
              Icons.people,
              size: 100,
            )),
            //home list tile
            ListTileCustom(
              text: 'H O M E ',
              icon: Icons.home,
              onTap: () => Navigator.pop(context),
            ),

            //profile list tile
            ListTileCustom(
              text: 'P R O F İ L E',
              icon: Icons.people,
              onTap: onProfileTap,
            ),
            //profile list tile
            ListTileCustom(
              text: 'C H A T S',
              icon: Icons.chat,
              onTap: chatTap,
            ),
          ]),

          //log out
          ListTileCustom(
            text: 'L O G  O U T',
            icon: Icons.logout,
            onTap: onSignOut,
          )
        ],
      ),
    );
  }
}
