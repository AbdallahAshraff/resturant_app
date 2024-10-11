import 'package:flutter/material.dart';
import 'package:resturant_app/utils/color.dart';


class CustomImage extends StatelessWidget {
  const CustomImage(this.name,
      {super.key, this.width = 100,
      this.height = 100,
      this.bgColor,
      this.borderWidth = 0,
      this.borderColor,
      this.radius = 50});

  final String name;
  final double width;
  final double height;
 final double borderWidth;
final Color? borderColor;
 final Color? bgColor;
  
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? cardColor, width: borderWidth),
        color: bgColor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(1, 2), // changes position of shadow
          ),
        ],
        image: DecorationImage(image: NetworkImage(name), fit: BoxFit.cover),
      ),
    );
  }
}
