import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/controllers/drawer_controller.dart';
import 'package:firebase_crud/views/phone-auth-verification-main/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/drawer.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key? key}) : super(key: key);
  ControllerDrawer drawerController = Get.put(ControllerDrawer());

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Obx(() => Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    title: Text(
                      'Home',
                      style: TextStyle(
                          fontSize: 16,
                          color: drawerController.getColor(DrawerConstants.home)
                              ? Colors.black
                              : Colors.grey),
                    ),
                    onTap: () {
                      drawerController.changeState(DrawerConstants.home);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Favourite',
                      style: TextStyle(
                          fontSize: 16,
                          color: drawerController
                                  .getColor(DrawerConstants.favourite)
                              ? Colors.black
                              : Colors.grey),
                    ),
                    onTap: () {
                      drawerController.changeState(DrawerConstants.favourite);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Recent Search',
                      style: TextStyle(
                          fontSize: 16,
                          color: drawerController
                                  .getColor(DrawerConstants.recentSearch)
                              ? Colors.black
                              : Colors.grey),
                    ),
                    onTap: () {
                      drawerController
                          .changeState(DrawerConstants.recentSearch);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Logout',
                      style: TextStyle(
                          fontSize: 16,
                          color: drawerController
                                  .getColor(DrawerConstants.recentSearch)
                              ? Colors.black
                              : Colors.grey),
                    ),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  LoginScreen()));
                    },
                  ),
                ],
              ),
            )));
  }
}
