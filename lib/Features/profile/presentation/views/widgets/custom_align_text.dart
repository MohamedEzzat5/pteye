import 'package:flutter/material.dart';

import '../../../../../core/utils/style.dart';

class CustomAlignText extends StatelessWidget {
   CustomAlignText({super.key,required this.text});
String text;
  @override
  Widget build(BuildContext context) {
    return  Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(text,style: Styles.textStyle18,),
        ));
  }
}
