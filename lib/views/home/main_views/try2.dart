import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future fetchSearchData(String searchData) async {
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=${searchData}&appid=9d3fd511637028c667538aec847749eb&units=metric'));
  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load album');
  }
}
