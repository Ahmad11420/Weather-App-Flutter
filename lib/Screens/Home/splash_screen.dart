import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myweather/Screens/Home/weather_screen.dart';
import 'dart:math';

import '../../Custom_Widgets/custom_container.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;
  @override

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller=AnimationController(vsync: this,
    duration: Duration(seconds: 10),
    );
    _animation=Tween<double>(begin: 0.1,end: 2 * pi).animate(_controller);
    _controller.repeat(reverse: true);

  }
   @override
   void dispose(){
    _controller.dispose();
    super.dispose();
   }

  @override
  Widget build(BuildContext context) {
  final  height= MediaQuery.of(context).size.height;
  final  width= MediaQuery.of(context).size.width;

    return Scaffold(
   body:Column(
     children: [
       Stack(
         children: [
           Container(
             height: height,
             width: width,
             decoration: BoxDecoration(
                 gradient: LinearGradient(colors: [Colors.blue,Colors.blue,Colors.white],begin: Alignment.topRight,end: Alignment.bottomLeft)
             ),
           ),
           Padding(
             padding: const EdgeInsets.only(left: 93,top: 200),

               child: AnimatedBuilder(
                 animation: _animation,
                 builder: (context, child) {
                   return Transform(alignment: Alignment.center,transform: Matrix4.identity()..rotateZ(_animation.value),child: child
                     ,);
                 },
                 child: Column(
                   children: [
                     Container(
                       height: 200,
                       width: 200,
                       decoration: BoxDecoration(
                         gradient: LinearGradient(colors: [Colors.yellow,Colors.yellow,Colors.amber,Colors.amber,Colors.amber]),
                         color: Colors.amber,
                         borderRadius: BorderRadius.circular(200)
                       ),
                     ),

                   ],
                 ),
               ),



             ),
           Padding(
             padding: const EdgeInsets.only(top: 500,left: 50),
             child: Row(
               children: [
                 Text('Welcome To ',style: GoogleFonts.playwriteAuQld(
                     color: Colors.amber,fontSize:20
                 ),),
                 Text(' SKY CAST',style: GoogleFonts.oswald(
                     color: Colors.black,fontSize:30
                 ),),
               ],
             ),
           ),
           Positioned(
             bottom: 40,
             left: width * 0.2,
             child: InkWell(
               onTap: (){
                // Get.to(WeatherScreen());
                Navigator.push(context, MaterialPageRoute(builder: (context) =>WeatherScreen() ,));
               },
               child: CustomContainer(height: height, width: width,color: Colors.amber,icon: Icon(Icons.arrow_forward_outlined),text: Text("  NEXT", style: GoogleFonts.roboto(
                 fontSize: 25,
                 fontWeight: FontWeight.bold,
                 color: Colors.black,
               )),           ),
             ),
           ),
         ],

       )
     ],
   ),
    );
  }
}

