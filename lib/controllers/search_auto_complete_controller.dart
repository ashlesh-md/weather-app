import 'dart:async';
import 'dart:convert';
import 'package:firebase_crud/models/search_auto_complete.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchAutoCompleteController extends GetxController {
  final Rx<StreamController<List<SearchAutoGenerate>>> _streamSearchController =
      StreamController<List<SearchAutoGenerate>>.broadcast().obs;
  List<SearchAutoGenerate> allsearchdata = [];
  get streamSearchController => _streamSearchController.value;
  final _searchData = ''.obs;
  get searchData => _searchData.value;
  setvalue(String newSearch) {
    _searchData.value = newSearch;
  }

  Future<void> getSearchdata() async {
    var url = Uri.parse(
        'http://api.weatherapi.com/v1/search.json?key=dbb0f4dd8d444f45a66101010222710&q=${_searchData.value}');
    final response = await http.get(url);
    final jsonData = json.decode(response.body);
    // print(response.body.length);
    allsearchdata.clear();
    for (int index = 0; index < 10; index++) {
      // print('Json data : $jsonData');
      // print('Json data : ${response.body.length}');
      String name = jsonData[index]["name"];
      String region = jsonData[index]["region"];
      String country = jsonData[index]["country"];
      var jsonModelData = {'name': name, 'region': region, 'country': country};
      SearchAutoGenerate dataModel = SearchAutoGenerate.fromJson(jsonModelData);
      allsearchdata.add(dataModel);
    }

    // print(allsearchdata);
    _streamSearchController.value.sink.add(allsearchdata);
  }

  @override
  void onInit() {
    super.onInit();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      allsearchdata.clear();
      getSearchdata();
    });
  }

  @override
  void onClose() {
    super.onClose();
    _searchData.close();
    _streamSearchController.close();
  }
}
