import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/data.dart';
import 'try.dart';

GetSearchDataController getSearchDataController =
    Get.put(GetSearchDataController());

class ApiDataController extends GetxController {
  Rx<StreamController<DataModel>> _streamController =
      StreamController<DataModel>.broadcast().obs;

  get streamController => _streamController.value;
  final _searchData = 'Mangalore'.obs;
  get searchData => _searchData.value;
  setvalue(String newSearch) {
    _searchData.value = newSearch;
  }

  Future<void> getWeatherdata() async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=${_searchData.value}&appid=9d3fd511637028c667538aec847749eb&units=metric');
    final response = await http.get(url);
    final jsonData = json.decode(response.body);
    String place = jsonData["name"].toString();
    String state = jsonData["sys"]["country"].toString();
    String description = jsonData["weather"][0]["description"].toString();
    String temperature = jsonData["main"]["temp"].toString();
    String tempMinimum = jsonData["main"]["temp_min"].toString();
    String tempMaximum = jsonData["main"]["temp_max"].toString();
    String humidity = jsonData["main"]["humidity"].toString();
    String feelsLike = jsonData["main"]["feels_like"].toString();

    var jsonModelData = {
      "place": place,
      "state": state,
      "description": description,
      "temperature": temperature,
      "tempMinimum": tempMinimum,
      "tempMaximum": tempMaximum,
      "humidity": humidity,
      "feelsLike": feelsLike
    };
    DataModel dataModel = DataModel.fromJson(jsonModelData);
    _streamController.value.sink.add(dataModel);
  }

  @override
  void onInit() {
    super.onInit();
    getSearchDataController.favourites.clear();
    getSearchDataController.getAllDataFromStorage();
    getSearchDataController.getAllRecentFromStorage();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      getWeatherdata();
    });
  }

  @override
  void onClose() {
    super.onClose();
    _streamController.close();
  }
}
