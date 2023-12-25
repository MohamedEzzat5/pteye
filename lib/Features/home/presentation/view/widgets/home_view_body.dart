import 'package:flutter/material.dart';
import 'package:pteye/Features/home/presentation/view/widgets/custom_diseases_grid_view.dart';
import 'package:pteye/Features/home/presentation/view/widgets/custom_hello_container.dart';
import 'package:pteye/core/utils/style.dart';
import 'package:pteye/core/widgets/custom_app_bar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          CustomAppBar(appBarTitle: 'الرئيسية'),
          const HelloContainer(),
          const Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                 Text('الامراض',style: Styles.textStyle20,),
              ],
            ),
          ),
          const CustomDiseasesGridView(),

        ],

      ),
    );
  }
}



