
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';
import '../../const/constant.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
final TextEditingController _controller=TextEditingController();

  final WeatherFactory _wf=WeatherFactory(openWeatherAPIKey);
  Weather? _weather;


  void _searchCity(value){
    if(value.isNotEmpty){
      _wf.currentWeatherByCityName(value).then((w){
        setState(() {
          _weather=w;
        });
      });
    }

  }

      bool isSearch=true;



  @override
  Widget build(BuildContext context) {
   final height= MediaQuery.of(context).size.height;
    final width= MediaQuery.of(context).size.width;
    if (_weather==null){
      return const Center(
        child: Image(image:AssetImage('assets/images/loading.gif') ),
      );
    }
    return Scaffold(
      body: Column(

           children: [
             Stack(
               children: [
                 SingleChildScrollView(
                   child: Container(
                     height: height,
                     width: width,
                     decoration: BoxDecoration(

                       image: DecorationImage(image: AssetImage('assets/images/sunny.png'),
                         fit:BoxFit.cover,
                       ),
                     ),
                   ),
                 ),
                 Row(
                 //  mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left: 32,top: 18),
                       child: IconButton(onPressed: (){
                         setState(() {
                           isSearch=!isSearch;
                         });

                       }, icon: Icon(Icons.search,color: Color.fromARGB(255, 239, 170, 130),size: 34  ,)),
                     ),

                      if(isSearch)
                      SizedBox(
                        width: 240,
                        height: 40,
                        child: TextFormField(

                          controller: _controller ,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 250, 226, 189),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 239, 170, 130)
                              ),

                              borderRadius: BorderRadius.circular(20)
                            )

                          ),
                          onFieldSubmitted: (value) {
                            _searchCity(value);
                          },
                        ),
                      )


                   ],
                 ),
                 Positioned(
                          left: 30,
                   top: 70,
                   child: Column(
                     children: [
                       Container(

                         height: height*0.38,
                         width: width*0.84,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(40),
                           color: Color.fromARGB(255, 250, 226, 189),
                         ),
                         child: Column(

                           children: [

                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.only(top: 13),
                                   child: Text("Today",style: GoogleFonts.poppins(
                                     fontSize: 23,
                                     color:   Color.fromARGB(255, 239, 170, 130)
                                   ),),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.only(top: 20),
                                   child: Icon(Icons.keyboard_arrow_down_sharp,size: 30,color: Color.fromARGB(255, 239, 170, 130),),
                                 )
                               ],
                             ),


                           SizedBox(
                             height: height*0.01
                           ),
                               Row(
                                 children: [
                                   SizedBox(
                                       height: 0.04,
                                       width: 0.1,
                                       child: Image.asset("assets/images/sun.png ")),
                                   Padding(
                                     padding: const EdgeInsets.only(left:110),
                                     child: Text('${_weather!.temperature!.celsius!.toInt()}°',style: GoogleFonts.poppins(
                                       color: Color.fromARGB(255, 239, 170, 130),
                                       fontSize: 66,
                                       fontWeight:FontWeight.w500,

                                     ),
                                     ),
                                   ),
                                 ],

                               ),
                            Text(_weather!.weatherDescription.toString(),style: GoogleFonts.poppins(
                              color: Color.fromARGB(255, 239, 170, 130),
                              fontSize: 16,
                            ),),
                              SizedBox(
                                height: height*0.014,
                              ),
                              Text(_weather?.areaName ?? '',style:GoogleFonts.poppins(
                                color: Color.fromARGB(255, 239, 170, 130),
                                fontSize: 16,
                              ) ,),
                             SizedBox(
                               height: height*0.014,
                             ),
                             Text(
                               DateFormat('d MMMM y').format(_weather!.date!),style:GoogleFonts.poppins(
                               color: Color.fromARGB(255, 239, 170, 130),
                               fontSize: 16,
                             )  ,),
                             SizedBox(
                               height: height*0.014,
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text("Feels like  ${_weather!.tempFeelsLike!.celsius!.toInt()}°",style: GoogleFonts.poppins(
                                   color: Color.fromARGB(255, 239, 170, 130),
                                   fontSize: 13,
                                 ),),
                                SizedBox(
                                  width: width*0.05,

                                ),
                                 Text(  "Sunset at  ${ DateFormat('HH:mm').format(_weather!.sunset!)}",style: GoogleFonts.poppins(
                                   color: Color.fromARGB(255, 239, 170, 130),
                                   fontSize: 13,
                                 ),),
                               ],
                             )
                           ],


                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(top: 45),
                         child: Opacity(
                           opacity: 0.7,

                           child: Container(

                         // child: Text(_weather!.sunrise.toString()),
                             height: height*0.23,
                             width: width*0.85,
                             decoration: BoxDecoration(
                                 color: Color.fromARGB(255, 250, 226, 189),
                                 borderRadius: BorderRadius.circular(40)

                             ),
                           ),
                         ),
                       ),
                       SizedBox(
                         height: 40 ,
                       ),
                       Text("The sun doesn’t rush — it rises when it’s time \nLife is the same — trust your pace.\nThere’s no race in blooming.\nShine in your own way.\nEven quiet progress is progress.\nYou’re exactly where you need to be."



                           ,style:GoogleFonts.poppins(
                             color: Colors.white,
                             fontSize: 14,
                           ) ),
                     ],
                   ),
                 ),


               ],
             )
           ],
      ),
    );
  }
}
