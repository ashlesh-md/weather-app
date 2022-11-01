import 'package:firebase_crud/constants/drawer.dart';
import 'package:firebase_crud/controllers/drawer_controller.dart';
import 'package:firebase_crud/firebase/crud.dart';
import 'package:firebase_crud/views/home/main_views/favourites.dart';
import 'package:firebase_crud/views/home/main_views/home_page.dart';
import 'package:firebase_crud/views/home/main_views/recent_search.dart';
import 'package:firebase_crud/views/home/main_views/search_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainAppPage extends StatefulWidget {
  MainAppPage({Key? key}) : super(key: key);

  @override
  State<MainAppPage> createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  ControllerDrawer drawerController = Get.put(ControllerDrawer());

  @override
  Widget build(BuildContext context) {
    return Obx(() => drawerController.drawerState == DrawerConstants.home
        ? HomePage(scaffoldKey: scaffoldKey)
        : drawerController.drawerState == DrawerConstants.recentSearch
            ? RecentSearch(
                scaffoldKey: scaffoldKey,
                drawerController: drawerController,
              )
            : drawerController.drawerState == DrawerConstants.search
                ? SearchPage(scaffoldKey: scaffoldKey)
                : Favourite(
                    scaffoldKey: scaffoldKey,
                    drawerController: drawerController,
                  ));
  }
}
