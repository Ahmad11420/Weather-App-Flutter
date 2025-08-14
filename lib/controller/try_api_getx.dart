import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:weather/weather.dart';

import '../const/constant.dart';

class TryApi extends GetxController {
  final WeatherFactory _wf = WeatherFactory(openWeatherAPIKey);
  var weather = Rx<Weather?>(null);
  var isSearch = true.obs;

  Future<void> searchCity(String city) async {
    try {
      Weather w = await _wf.currentWeatherByCityName(city);
      weather.value = w;
    } catch (e) {
      print("Error fetching weather: $e");
      Get.snackbar(
        "Error",
        "Failed to fetch weather data for $city",

        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        duration: Duration(seconds: 1),
      );
    }
  }
}
