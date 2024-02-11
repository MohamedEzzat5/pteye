import 'package:flutter/material.dart';

import '../../../../../core/utils/style.dart';

class CustomAlignText extends StatelessWidget {
   const CustomAlignText({super.key,required this.text});
final String text;
  @override
  Widget build(BuildContext context) {
    return  Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(text,style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w700),),
        ));
  }
}
