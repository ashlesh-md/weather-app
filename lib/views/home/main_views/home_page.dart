import 'package:firebase_crud/constants/image_getter.dart';
import 'package:firebase_crud/controllers/api_data_controller.dart';
import 'package:firebase_crud/controllers/drawer_controller.dart';
import 'package:firebase_crud/controllers/favourite_controller.dart';
import 'package:firebase_crud/controllers/ip_geo_location_controller.dart';
import 'package:firebase_crud/models/data.dart';
import 'package:firebase_crud/views/home/components/custom_appbar.dart';
import 'package:firebase_crud/views/home/components/custom_drawer.dart';
import 'package:firebase_crud/views/home/components/favourite_widget.dart';
import 'package:firebase_crud/views/home/components/radio_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/celsius_to_fahrenheit.dart';
import '../../../controllers/temperature_controller.dart';
import '../../../controllers/try.dart';

class HomePage extends StatelessWidget {
  HomePage({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  FavouriteController favouriteController = Get.put(FavouriteController());
  TemperatureController temperatureController =
      Get.put(TemperatureController());
  ApiDataController apiDataController = Get.put(ApiDataController());
  IpDataController IpdataController = Get.put(IpDataController());
  ControllerDrawer drawerController = Get.put(ControllerDrawer());
  GetSearchDataController getSearchDataController =
      Get.put(GetSearchDataController());
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DataModel>(
      stream: apiDataController.streamController.stream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return const Text('Waiting');
            } else {
              var data = snapshot.data!;
              String temperature =
                  celciusToFahrenheit(double.parse(data.temperature ?? '0'))
                      .toStringAsFixed(2);
              return Scaffold(
                key: scaffoldKey,
                drawer: CustomDrawer(),
                body: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/splash/background_android.png"),
                          fit: BoxFit.fill)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomAppBar(scaffoldKey: scaffoldKey),
                      Column(
                        children: [
                          Column(
                            children: [
                              Text(
                                IpdataController.allStateData.value.isNotEmpty
                                    ? IpdataController.allStateData.value[2]
                                    : "",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 16),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                '${data.place} ${IpdataController.allStateData.value.isNotEmpty ? IpdataController.allStateData.value[1] : ""}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 25),
                              FavouriteWidget(
                                  favouriteController: favouriteController)
                            ],
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: Image.asset(
                                  getImage(data.description ?? 'sunny'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Obx(
                                () => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 0,
                                      width: 0,
                                      child: Text(
                                          '${temperatureController.isDegree}'),
                                    ),
                                    temperatureController.isDegree
                                        ? Text(
                                            '${data.temperature}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 52,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : Text(
                                            '${temperature}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 52,
                                                fontWeight: FontWeight.bold),
                                          ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    RadioButtons()
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                '${data.description}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            color: Colors.white,
                            width: double.infinity,
                            height: 0.5,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white.withOpacity(0.15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SingleChildScrollView(
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.thermostat_outlined,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Min-Max',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '${data.tempMaximum} ${data.tempMinimum}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 19),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.sunny_snowing,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Feels Like',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            '${data.feelsLike}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 19),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.water_drop_outlined,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Humidity',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            '${data.humidity}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 19),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
        }
      },
    );
  }
}
