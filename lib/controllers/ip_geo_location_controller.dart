import 'dart:async';
import 'dart:convert';
import 'package:firebase_crud/controllers/api_data_controller.dart';
import 'package:firebase_crud/models/ip_geo_locator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class IpDataController extends GetxController {
  final Rx<StreamController<IPGeoLocator>> _streamIpController =
      StreamController<IPGeoLocator>.broadcast().obs;
  // ignore: non_constant_identifier_names
  RxList allStateData = [].obs;
  ApiDataController apiDataController = Get.put(ApiDataController());
  get streamIpController => _streamIpController.value;
  final _searchData = 'Mangalore'.obs;
  get searchData => _searchData.value;
  setvalue(String newSearch) {
    _searchData.value = newSearch;
  }

  Future<void> getIdata() async {
    var url = Uri.parse(
        'https://api.ipgeolocation.io/timezone?apiKey=2fdba03c75ec4d5782397929635e931c&location=${_searchData.value}');
    final response = await http.get(url);
    final jsonData = json.decode(response.body);
    String country = jsonData['geo']['country'];
    String state = jsonData['geo']['state'];
    String timezone = jsonData['timezone'];
    String date = jsonData['date'];
    String dateTime = jsonData['date_time'];
    String dateTimeTxt = jsonData['date_time_txt'];
    String dateTimeWti = jsonData['date_time_wti'];
    allStateData.value.clear();
    allStateData.value.add(country);
    allStateData.value.add(state);
    allStateData.value.add(dateTimeTxt);
  }

  @override
  void onInit() {
    super.onInit();
    Timer.periodic(Duration(seconds: 1), (timer) {
      getIdata();
    });
  }

  @override
  void onClose() {
    super.onClose();
    _streamIpController.close();
  }
}
