import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/controllers/api_data_controller.dart';
import 'package:firebase_crud/controllers/favourite_controller.dart';
import 'package:firebase_crud/controllers/firebase_controller.dart';
import 'package:get/get.dart';

import '../views/home/main_views/try2.dart';

ApiDataController apiDataController = Get.put(ApiDataController());

FirebaseController firebaseController = Get.put(FirebaseController());

class GetSearchDataController extends GetxController {
  final _favourites = [].obs;
  final _recent_search = [].obs;

  get favourites => _favourites.value;
  get recent_searches => _recent_search.value;
  FavouriteController favouriteController = Get.put(FavouriteController());
  Future<void> getAllDataFromStorage() async {
    final _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance.collection('data');
    print('------------');
    print(firebaseController.id);
    DocumentSnapshot snapshot =
        await categories.doc(firebaseController.id).get();
    var data = snapshot.data() as Map;
    var fav = data['favourites'];
    var recent = data['recent_search'];
    _favourites.clear();
    fav.forEach((element) {
      fetchSearchData(element).then((value) {
        print(element);
        _favourites.add([
          '${element}',
          '${value['main']['temp']}',
          value['weather'][0]['description'],
          '${value['weather'][0]['id']}'
        ]);
      });
    });
  }

  Future<void> getAllRecentFromStorage() async {
    final _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance.collection('data');
    DocumentSnapshot snapshot =
        await categories.doc(firebaseController.id).get();
    var data = snapshot.data() as Map;
    var recent = data['recent_search'];
    _recent_search.clear();
    recent.forEach((element) {
      fetchSearchData(element).then((value) {
        _recent_search.add([
          '${element}',
          '${value['main']['temp']}',
          value['weather'][0]['description'],
          '${value['weather'][0]['id']}'
        ]);
      });
    });
  }

  removeItem(String data) {
    _favourites.value.remove(data);
  }

  addItem(String data) {
    _favourites.value.add(data);
  }

  RxBool isFavourite(String data) {
    RxBool returndata = false.obs;
    _favourites.forEach((element) {
      if (element[0].toString().toLowerCase() == data.toLowerCase()) {
        returndata.value = true;
      }
    });
    return returndata;
  }

  @override
  void onInit() {
    _favourites.clear();
    _recent_search.clear();
    getAllDataFromStorage();
    getAllRecentFromStorage();
    super.onInit();
  }
}
