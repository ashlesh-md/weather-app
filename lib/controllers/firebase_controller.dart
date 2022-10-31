import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getNumber();
  }

  final Rx<String?> _userId = '7624880294'.obs;
  getNumber() {
    if (FirebaseAuth.instance.currentUser != null) {
      changeNumber(FirebaseAuth.instance.currentUser!.phoneNumber.toString());
    }
  }

  get id => _userId.value;
  changeNumber(String number) {
    _userId.value = number;
  }
}
