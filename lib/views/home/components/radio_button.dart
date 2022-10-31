import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/temperature_controller.dart';

class RadioButtons extends StatelessWidget {
  RadioButtons({
    Key? key,
  }) : super(key: key);
  TemperatureController temperatureController =
      Get.put(TemperatureController());
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: temperatureController.isDegree
                    ? Colors.white
                    : Colors.transparent,
                border: Border.all(color: Colors.white)),
            child: Center(
              child: Text(
                '°C',
                style: TextStyle(
                    fontSize: 18,
                    color: temperatureController.isDegree
                        ? Color.fromARGB(255, 227, 40, 68)
                        : Colors.white),
              ),
            ),
          ),
          onTap: () {
            temperatureController.changeState();
          },
        ),
        GestureDetector(
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: !temperatureController.isDegree
                    ? Colors.white
                    : Colors.transparent,
                border: Border.all(color: Colors.white)),
            child: Center(
              child: Text(
                '°F',
                style: TextStyle(
                    fontSize: 18,
                    color: !temperatureController.isDegree
                        ? Color.fromARGB(255, 227, 40, 68)
                        : Colors.white),
              ),
            ),
          ),
          onTap: () {
            temperatureController.changeState();
          },
        )
      ],
    );
  }
}
