import 'package:get/get.dart';

class DeleteController extends GetxController {
  final RxBool _isTappend = false.obs;
  get isTapped => _isTappend.value;
  changeState(bool value) {
    _isTappend.value = value;
  }
}
