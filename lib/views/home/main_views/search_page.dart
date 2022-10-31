import 'package:firebase_crud/controllers/api_data_controller.dart';
import 'package:firebase_crud/controllers/drawer_controller.dart';
import 'package:firebase_crud/controllers/search_auto_complete_controller.dart';
import 'package:firebase_crud/firebase/crud.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/drawer.dart';
import '../../../controllers/try.dart';
import '../../../models/search_auto_complete.dart';
import '../components/custom_drawer.dart';

class SearchPage extends StatelessWidget {
  SearchPage({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  ControllerDrawer drawerController = Get.put(ControllerDrawer());
  SearchAutoCompleteController searchAutoController =
      Get.put(SearchAutoCompleteController());
  ApiDataController apiDataController = Get.put(ApiDataController());
  GetSearchDataController getSearchDataController =
      Get.put(GetSearchDataController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Scaffold(
          appBar: AppBar(
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(4.0),
                  child: Container(
                    color: Colors.grey,
                    width: double.infinity,
                    height: 0.75,
                  )),
              backgroundColor: Colors.white,
              elevation: 0,
              leading: GestureDetector(
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onTap: () {
                  drawerController.changeState(DrawerConstants.home);
                },
              ),
              title: Column(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      searchAutoController.setvalue(value);
                    },
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search for City',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 18)),
                  ),
                ],
              )),
          backgroundColor: Colors.white,
          key: scaffoldKey,
          drawer: CustomDrawer(),
          body: Obx(() => StreamBuilder<List<SearchAutoGenerate>>(
                stream: searchAutoController.streamSearchController.stream,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.indigo,
                        ),
                      );
                    default:
                      if (snapshot.hasError) {
                        return const Text('Waiting');
                      } else {
                        var data = snapshot.data!;
                        return data.length > 0
                            ? ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          color: Colors.grey,
                                          width: double.infinity,
                                          height: 1,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Text(
                                            '${data[index].name}',
                                            style: const TextStyle(
                                                height: 2, fontSize: 20),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      addDataToRecentSearch(
                                          data: '${data[index].name}');
                                      apiDataController
                                          .setvalue('${data[index].name}');
                                      addDataToRecentSearch(
                                          data: '${data[index].name}');

                                      drawerController
                                          .changeState(DrawerConstants.home);
                                    },
                                  );
                                },
                              )
                            : const SizedBox();
                      }
                  }
                },
              ))),
    );
  }
}
