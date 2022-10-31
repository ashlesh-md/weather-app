import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';

class GetDataByName extends GetxController {
  RxMap _jsonModelData = {}.obs;
  get jsonModelData => _jsonModelData.value;
  String searchdata = '';
  getDataByName(String search) async {
    searchdata = search;
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=${search}&appid=9d3fd511637028c667538aec847749eb&units=metric');
    var http;
    final response = await http.get(url);
    final jsonData = json.decode(response.body);
    String place = jsonData["name"];
    String state = jsonData["sys"]["country"];
    String description = jsonData["weather"][0]["description"];
    double temperature = jsonData["main"]["temp"];
    double tempMinimum = jsonData["main"]["temp_min"];
    double tempMaximum = jsonData["main"]["temp_max"];
    int humidity = jsonData["main"]["humidity"];
    double feelsLike = jsonData["main"]["feels_like"];
    _jsonModelData.clear();
    _jsonModelData.value = {
      "place": place,
      "state": state,
      "description": description,
      "temperature": temperature,
      "tempMinimum": tempMinimum,
      "tempMaximum": tempMaximum,
      "humidity": humidity,
      "feelsLike": feelsLike
    };
    print(_jsonModelData.value);
  }
}
