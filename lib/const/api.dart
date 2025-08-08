//
// import 'package:flutter/cupertino.dart';
// import 'package:myweather/const/constant.dart';
// import 'package:http/http.dart' as http ;
//
// class WeatherApp{
//   final String baseurl="http://api.weatherapi.com/v1/current.json ";
//   Future<void> getWeatherData(String location) async {
//     String apiUrl= "$baseurl?key=$apiKey&q=$location";
//     try{
//    final response= await   http.get(Uri.parse(apiUrl));
//    if(response.statusCode == 200){
// print(response.body);
//    } else{
//      throw Exception("Failed to load weather ");
//    }
//     }catch(e){
//       throw Exception("Failed to load weather ");
//     }
//     print("Requesting: $apiUrl");
//
//   }
//
// }