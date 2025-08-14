import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myweather/controller/try_api_getx.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';
import '../../const/constant.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _controller = TextEditingController();
  final TryApi _tryApi = Get.put(TryApi());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tryApi.searchCity("Lahore");
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // if (_weather==null){
    //   return const Center(
    //     child: Image(image:AssetImage('assets/images/loading.gif') ),
    //   );
    // }

    return Scaffold(
      body: Obx(() {
        if (_tryApi.weather.value == null) {
          return const Center(
            child: Image(image: AssetImage('assets/images/loading.gif')),
          );
        }
        final _weather = _tryApi.weather.value!;
        final code = _weather.weatherConditionCode ?? 0;
        final bgImage = (code == 800)
            ? 'assets/images/sunny.png'
            : (code > 800 && code < 805)
            ? 'assets/images/Clouds.png'
            : (code > 599 && code < 623)
            ? 'assets/images/Snowing.png'
            : (code > 499 && code < 532)
            ? 'assets/images/Raining.png'
            : 'assets/images/sunny.png';
        final weatherImage = (code == 800)
            ? 'assets/images/sun.png'
            : (code > 800 && code < 805)
            ? 'assets/images/cloud.png'
            : (code > 599 && code < 623)
            ? 'assets/images/cloud.png'
            : (code > 499 && code < 532)
            ? 'assets/images/rain.png'
            : 'assets/images/sunny.png';

        final myfillcolors = (code == 800)
            ? Color.fromARGB(255, 250, 226, 189)
            : (code > 800 && code < 805)
            ? Color.fromARGB(255, 90, 139, 171)
            : (code > 599 && code < 623)
            ? Color.fromARGB(255, 167, 172, 196)
            : (code > 499 && code < 532)
            ? Color.fromARGB(255, 97, 82, 115)
            : Color.fromARGB(255, 167, 172, 196);
        final mytextcolors = (code == 800)
            ? Color.fromARGB(255, 239, 170, 130)
            : (code > 800 && code < 805)
            ? Color.fromARGB(255, 174, 213, 228)
            : (code > 599 && code < 623)
            ? Color.fromARGB(255, 226, 226, 227)
            : (code > 499 && code > 532)
            ? Color.fromARGB(255, 194, 184, 255)
            : Color.fromARGB(255, 194, 184, 255);

        return Column(
          children: [
            Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    height: height * 1,
                    width: width,

                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          bgImage,
                          // _weather.weatherDescription == 'cloudy'
                          //     ? 'assets/images/Clouds.png'
                          //     : _weather.weatherConditionCode == 'sunny'
                          //     ? 'assets/images/sunny.png'
                          //     : _weather.weatherConditionCode == 'snow'
                          //     ? 'assets/images/Snowing.png'
                          //     : _weather.weatherConditionCode == 'rain'
                          //     ? 'assets/images/Raining.png'
                          //     : 'assets/images/Clouds.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 34),
                  child: Row(
                    //  mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 32, top: 13),
                        child: IconButton(
                          onPressed: () {
                            _tryApi.isSearch.value = !_tryApi.isSearch.value;
                          },
                          icon: Icon(
                            Icons.search,
                            color: mytextcolors,
                            size: 34,
                          ),
                        ),
                      ),

                      if (_tryApi.isSearch.value)
                        SizedBox(
                          width: 240,
                          height: 40,
                          child: TextFormField(
                            style: TextStyle(color: mytextcolors),
                            controller: _controller,
                            textInputAction: TextInputAction.search,
                            cursorColor: mytextcolors,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  String value = _controller.text.trim();
                                  if (value.isNotEmpty) {
                                    _tryApi.searchCity(value);
                                  }
                                },
                                icon: Icon(Icons.send, color: mytextcolors),
                              ),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: myfillcolors,

                              focusColor: mytextcolors,
                              hintText: "Write your City ",
                              hintStyle: TextStyle(color: mytextcolors),

                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mytextcolors),

                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: mytextcolors,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onFieldSubmitted: (value) {
                              if (value.isNotEmpty) {
                                _tryApi.searchCity(value.trim());
                              }
                            },
                          ),
                        ),
                    ],
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 120,
                  child: Column(
                    children: [
                      Container(
                        height: height * 0.38,
                        width: width * 0.84,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: myfillcolors,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 13),
                                  child: Text(
                                    "Today",
                                    style: GoogleFonts.poppins(
                                      fontSize: 23,
                                      color: mytextcolors,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 30,
                                    color: mytextcolors,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: height * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: height * 0.08,
                                  width: width * 0.2,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(weatherImage),
                                    ),
                                    color: myfillcolors,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    '${_weather.temperature!.celsius!.toInt()}°',
                                    style: GoogleFonts.poppins(
                                      color: mytextcolors,
                                      fontSize: 66,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              _weather.weatherDescription.toString(),
                              style: GoogleFonts.poppins(
                                color: mytextcolors,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: height * 0.014),
                            Text(
                              _weather.areaName ?? '',
                              style: GoogleFonts.poppins(
                                color: mytextcolors,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: height * 0.014),
                            Text(
                              DateFormat('d MMMM y').format(_weather.date!),
                              style: GoogleFonts.poppins(
                                color: mytextcolors,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: height * 0.014),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Feels like  ${_weather.tempFeelsLike!.celsius!.toInt()}°",
                                  style: GoogleFonts.poppins(
                                    color: mytextcolors,
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(width: width * 0.05),
                                Text(
                                  "Sunset at  ${DateFormat('HH:mm').format(_weather.sunset!)}",
                                  style: GoogleFonts.poppins(
                                    color: mytextcolors,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.06),
                      Opacity(
                        opacity: 0.9,
                        child: Container(
                          height: height * 0.23,
                          width: width * 0.85,
                          decoration: BoxDecoration(
                            color: myfillcolors,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Column(
                            children: [
                              SafeArea(
                                child: Row(
                                  children: [
                                    Text(
                                      "  Humidity ${_weather.humidity}%",
                                      style: GoogleFonts.poppins(
                                        color: mytextcolors,
                                        fontSize: 17,
                                      ),
                                    ),

                                    Text(
                                      "  Pressure ${_weather.pressure}hpa",
                                      style: GoogleFonts.poppins(
                                        color: mytextcolors,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SafeArea(
                                child: Row(
                                  children: [
                                    Text(
                                      '  Min Temp ${_weather.tempMin!.celsius!.toInt()}°',
                                      style: GoogleFonts.poppins(
                                        color: mytextcolors,
                                        fontSize: 17,
                                      ),
                                    ),
                                    SizedBox(width: width * 0.18),
                                    Text(
                                      'Max Temp ${_weather.tempMax!.celsius!.toInt()}°',
                                      style: GoogleFonts.poppins(
                                        color: mytextcolors,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SafeArea(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "  Wind Speed  ${_weather.windSpeed} m/s",
                                      style: GoogleFonts.poppins(
                                        color: mytextcolors,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.013),
                      Text(
                        "The sun doesn’t rush — it rises when it’s time \nLife is the same — trust your pace.\nThere’s no race in blooming.\nShine in your own way.\nEven quiet progress is progress.\nYou’re exactly where you need to be.",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
