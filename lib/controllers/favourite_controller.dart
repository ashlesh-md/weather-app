import 'package:firebase_crud/controllers/api_data_controller.dart';
import 'package:firebase_crud/controllers/try.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController {
  final RxBool _isFavourite = false.obs;
  get isFavourite => _isFavourite.value;
  // GetSearchDataController getSearchDataController =
  //     Get.put(GetSearchDataController());
  // ApiDataController apiDataController = Get.put(ApiDataController());

  changeState() {
    if (getSearchDataController
            .isFavourite(apiDataController.searchData)
            .value ==
        true) {
      _isFavourite.value = true;
    } else {
      _isFavourite.value = false;
    }
  }

  set(bool val) {
    _isFavourite.value = val;
  }
}
