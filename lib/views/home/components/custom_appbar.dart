import 'package:firebase_crud/constants/drawer.dart';
import 'package:firebase_crud/controllers/drawer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  ControllerDrawer drawerController = Get.put(ControllerDrawer());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                      child: Image.asset('assets/home/icon_menu_white.png',
                          height: 15),
                      onTap: () {
                        if (scaffoldKey.currentState!.isDrawerOpen) {
                          scaffoldKey.currentState!.closeDrawer();
                        } else {
                          scaffoldKey.currentState!.openDrawer();
                        }
                      }),
                  const SizedBox(
                    width: 40,
                  ),
                  Image.asset(
                    'assets/splash/logo_splash.png',
                    height: 25,
                  )
                ],
              ),
              GestureDetector(
                child: Image.asset(
                  'assets/home/icon_search_white.png',
                  height: 20,
                ),
                onTap: () {
                  drawerController.changeState(DrawerConstants.search);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
