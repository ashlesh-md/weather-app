import 'package:firebase_crud/controllers/api_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/favourite_controller.dart';
import '../../../firebase/crud.dart';
import '../../../controllers/try.dart';

class FavouriteWidget extends StatefulWidget {
  FavouriteWidget({
    Key? key,
    required this.favouriteController,
  }) : super(key: key);

  final FavouriteController favouriteController;

  @override
  State<FavouriteWidget> createState() => _FavouriteWidgetState();
}

class _FavouriteWidgetState extends State<FavouriteWidget> {
  ApiDataController apiDataController = Get.put(ApiDataController());

  GetSearchDataController getSearchDataController =
      Get.put(GetSearchDataController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => !widget.favouriteController.isFavourite
              ? GestureDetector(
                  child: const Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                  ),
                  onTap: () {
                    addDataToFavourite(data: apiDataController.searchData);
                    widget.favouriteController.set(true);
                  })
              : GestureDetector(
                  child: Icon(
                    Icons.favorite,
                    color: Colors.yellow.shade600,
                  ),
                  onTap: () {
                    removeDataToFavourite(data: apiDataController.searchData);
                    widget.favouriteController.set(false);
                  }),
        ),
        const SizedBox(
          width: 10,
        ),
        Obx(() => !widget.favouriteController.isFavourite
            ? const Text(
                'Add to favourite',
                style: TextStyle(color: Colors.white, fontSize: 16),
              )
            : const Text(
                'Remove from favourite',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ))
      ],
    );
  }
}
