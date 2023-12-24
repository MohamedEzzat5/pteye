import 'package:flutter/material.dart';
import 'package:pteye/core/utils/assets.dart';
import 'package:pteye/core/utils/constance.dart';
import 'package:pteye/core/widgets/custom_app_bar.dart';
import 'package:pteye/generated/assets.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return  Column(
      children: [
        CustomAppBar(appBarTitle: 'الرئيسية'),
        Container(
          padding:const  EdgeInsets.symmetric(horizontal: 20),
          margin: const EdgeInsets.all(20),
          height: height*.15,
          width: double.infinity,
          decoration:  BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child:  Row(
            children: [
              Image.asset(Assets.imagesHealthy),
              Column(children: [
                Text('أهلاً بك Mohamed'),
                Text('درب جيداً لصحة أفضل'),
              ],)
            ],
          ),
        )


      ],
    );
  }
}


