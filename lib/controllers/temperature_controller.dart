import 'package:get/get.dart';

class TemperatureController extends GetxController {
  final RxBool _isDegree = true.obs;
  get isDegree => _isDegree.value;
  RxInt _temperature = 36.obs;
  get temperature => _temperature;
  changeState() {
    _isDegree.value = !_isDegree.value;
  }
}
