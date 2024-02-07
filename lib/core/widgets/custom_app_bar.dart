import 'package:flutter/material.dart';
import 'package:pteye/core/utils/assets.dart';
import 'package:pteye/core/utils/constance.dart';
import 'package:pteye/core/utils/style.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key,required this.appBarTitle});
  final String appBarTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 52.5,right: 20,left: 20,bottom: 12.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              AssetsData.logo1,
              width: 85,
            ),
            const Spacer(),
            Text(appBarTitle,style: Styles.textStyle20.copyWith(color: kPrimaryColor,fontWeight: FontWeight.w600),),
          ],
        ),
      ),
    );
  }
}
