import 'package:flutter/material.dart';
import 'package:pteye/core/utils/constance.dart';


class CustomOutlinedButton extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final VoidCallback onPressed; // voidCallback = void Function()
  final Widget child;
  final Color borderColor;

  const CustomOutlinedButton({
    Key? key,
    required this.onPressed,
    this.width = double.infinity,
    this.radius = 8,
    required this.child,
    this.height = 50,
    this.borderColor = kPrimaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            side: BorderSide(width: 2, color: borderColor),
          ),
          onPressed: onPressed,
          child: child),
    );
  }
}