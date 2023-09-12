import 'package:flutter/material.dart';
import 'package:flutter_chat_app_basic/core/companent/drawer/list_tile_drawer.dart';
import 'package:flutter_chat_app_basic/core/constants/icon_const.dart';
import 'package:flutter_chat_app_basic/core/services/auth/auth_services.dart';
import 'package:flutter_chat_app_basic/view/pages/chat_pages/home_page.dart';
import 'package:flutter_chat_app_basic/view/pages/profile_pages/profile_home_page.dart';
import 'package:provider/provider.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    void goToProfilePage() {
      //pop the drawer menu
      Navigator.pop(context);

      //push profile page
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileHomePage(),
          ));
    }

    void goToChatPage() {
      //pop the drawer menu
      Navigator.pop(context);

      //push profile page
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    }

    void signOut() {
      //get authservice
      final authServices = context.read<AuthService>();
      //signOut
      authServices.signOut();
    }

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
              icon: IconCustomConst.home,
              onTap: () => Navigator.pop(context),
            ),

            //profile list tile
            ListTileCustom(
              text: 'P R O F İ L E',
              icon: IconCustomConst.profilePicPerson,
              onTap: goToProfilePage,
            ),
            //profile list tile
            ListTileCustom(
              text: 'C H A T S',
              icon: IconCustomConst.chats,
              onTap: goToChatPage,
            ),
          ]),

          //log out
          ListTileCustom(
            text: 'L O G  O U T',
            icon: IconCustomConst.signOutIcon,
            onTap: signOut,
          )
        ],
      ),
    );
  }
}
