import 'package:firebase_crud/controllers/drawer_controller.dart';
import 'package:firebase_crud/views/home/components/custom_drawer.dart';
import 'package:firebase_crud/controllers/try.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/drawer.dart';
import '../../../firebase/crud.dart';

class Favourite extends StatefulWidget {
  const Favourite({
    Key? key,
    required this.drawerController,
    required this.scaffoldKey,
  }) : super(key: key);

  final ControllerDrawer drawerController;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  GetSearchDataController getSearchDataController =
      Get.put(GetSearchDataController());
  @override
  void initState() {
    // TODO: implement initState
    getSearchDataController.getAllDataFromStorage();
    widget.drawerController.changeState(DrawerConstants.home);
    widget.drawerController.changeState(DrawerConstants.favourite);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              widget.drawerController.changeState(DrawerConstants.home);
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Favourite',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              GestureDetector(
                child: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              )
            ],
          )),
      key: widget.scaffoldKey,
      drawer: CustomDrawer(),
      body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/splash/background_android.png"),
                  fit: BoxFit.fill)),
          child: getSearchDataController.favourites.length == 0
              ? Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/splash/no_favourites.png',
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        child: const Text(
                          'No Favourited added',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      )
                    ],
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Text(
                              '${getSearchDataController.favourites.length} City added as favorite',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                          GestureDetector(
                            child: const Text('Remove All',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  content: const Text(
                                    "Are you sure want to remove all the favourites",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              child: const Text(
                                                'No',
                                                style: TextStyle(
                                                    color: Colors.deepPurple,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 30,
                                            ),
                                            GestureDetector(
                                              child: const Text(
                                                'Yes',
                                                style: TextStyle(
                                                    color: Colors.deepPurple,
                                                    fontSize: 18),
                                              ),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: ListView.builder(
                          itemCount: getSearchDataController.favourites.length,
                          itemBuilder: (context, index) {
                            return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                ),
                                padding: const EdgeInsets.all(20),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 10),
                                child: Obx(() => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${getSearchDataController.favourites[index][0] ?? 0}',
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 229, 57),
                                                  fontSize: 18),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.sunny,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        '${getSearchDataController.favourites[index][1] ?? 0}°c',
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18))
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                    '${getSearchDataController.favourites[index][2] ?? 0}',
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16))
                                              ],
                                            ),
                                            SizedBox(
                                              height: 0,
                                              width: 0,
                                              child: Text(
                                                  '${widget.drawerController.drawerState}'),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          child: const Icon(
                                            Icons.favorite,
                                            color: Color.fromARGB(
                                                255, 216, 190, 23),
                                          ),
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                content: Text(
                                                  "Are you sure want to remove ${getSearchDataController.favourites[index][0] ?? 0}",
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.grey),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(ctx).pop();
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          const Text(
                                                            'No',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .deepPurple,
                                                                fontSize: 18),
                                                          ),
                                                          const SizedBox(
                                                            width: 30,
                                                          ),
                                                          TextButton(
                                                            child: const Text(
                                                                'Yes',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .deepPurple,
                                                                    fontSize:
                                                                        18)),
                                                            onPressed: () {
                                                              setState(() {
                                                                removeDataToFavourite(
                                                                    data:
                                                                        '${getSearchDataController.favourites[index][0]}');

                                                                widget
                                                                    .drawerController
                                                                    .changeState(
                                                                        DrawerConstants
                                                                            .favourite);
                                                                getSearchDataController
                                                                    .getAllDataFromStorage();
                                                                Navigator.pop(
                                                                    context);
                                                              });
                                                            },
                                                          )
                                                        ],
                                                      )),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    )));
                          }),
                    ),
                  ],
                )),
    );
  }
}
