import 'package:firebase_crud/constants/drawer.dart';
import 'package:get/get.dart';

class ControllerDrawer extends GetxController {
  final Rx<DrawerConstants> _drawerState = DrawerConstants.home.obs;
  get drawerState => _drawerState.value;
  changeState(DrawerConstants drawerState) {
    _drawerState.value = drawerState;
  }

  getColor(DrawerConstants drawerState) {
    if (_drawerState.value == drawerState) {
      return true;
    }
    return false;
  }
}
