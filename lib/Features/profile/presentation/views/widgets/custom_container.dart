import 'package:flutter/material.dart';
import 'package:pteye/core/utils/style.dart';

class CustomProfileContainer extends StatelessWidget {
   const CustomProfileContainer({super.key,required this.text});
final String text;
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
      child:  Text(text,style: Styles.textStyle16.copyWith(),),
    );
  }
}
