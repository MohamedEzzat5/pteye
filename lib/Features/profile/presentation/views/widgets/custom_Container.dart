import 'package:flutter/material.dart';
import 'package:pteye/core/utils/style.dart';

class CustomContainer extends StatelessWidget {
   CustomContainer({super.key,required this.text});
String text;
  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.centerRight,
      height: 60,
      width: double.infinity,
      margin:const EdgeInsets.symmetric(horizontal: 16),
      padding:const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12)
      ),
      child:  Text(text,style: Styles.textStyle16,),
    );
  }
}
