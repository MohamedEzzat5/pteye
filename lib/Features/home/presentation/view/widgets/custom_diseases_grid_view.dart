import 'package:flutter/material.dart';
import 'package:pteye/Features/home/presentation/view/widgets/custom_diseases_grid_view_item.dart';

class CustomDiseasesGridView extends StatelessWidget {
  const CustomDiseasesGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 15,crossAxisSpacing: 15,),
        itemCount: 20,
        physics: const  BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        itemBuilder: (context, index){
          return const CustomGridViewItem();
        },

      ),
    );
  }
}
