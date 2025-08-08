import 'package:flutter/material.dart';
class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.height,
    required this.width,
    required this.text,
    required this.icon,
    required this.color,
  });

  final double height;
  final double width;
  final dynamic text;
  final Widget icon;
  final dynamic color;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: height*0.08,
      width: width*0.6,
      decoration: BoxDecoration(
          color:  color,
          borderRadius: BorderRadius.circular(40)
      ),
      child:  Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text,
            icon ,
          ],
        ),

      ),
    );
  }
}
