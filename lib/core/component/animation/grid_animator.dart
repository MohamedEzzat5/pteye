import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pteye/core/utils/media_query_values.dart';


class GridAnimator extends StatefulWidget {
  final List<Widget>? children;
  final int? duration;
  final double? verticalOffset;
  final ScrollPhysics? physics;
  final Axis scrollDirection;

  const GridAnimator({
    Key? key,
    this.children,
    this.duration,
    this.scrollDirection = Axis.vertical,

    this.verticalOffset,
    this.physics,
  }) : super(key: key);

  @override
  GridAnimatorState createState() => GridAnimatorState();
}

class GridAnimatorState extends State<GridAnimator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:context.height,
      child: AnimationConfiguration.synchronized(
        child: SlideAnimation(
          verticalOffset: 50.0,
          child: AnimationLimiter(
            //    GridView.builder(
            //                     itemCount: 10,
            //                     padding: EdgeInsets.all(kFormPaddingHorizontal),
            //                     physics: const NeverScrollableScrollPhysics(),
            //                     shrinkWrap: true,
            //                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //                       childAspectRatio: (1 / 0.5),
            //                       crossAxisCount: 1,
            //                       mainAxisSpacing: 5,
            //                       crossAxisSpacing: 5,
            //                     ),
            //                     itemBuilder: (context, index) {
            child: GridView.builder(
              scrollDirection: widget.scrollDirection,
              itemCount: widget.children!.length,
              physics: widget.physics,
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: (1 / 0.5),
                crossAxisCount: 1,
                mainAxisSpacing: context.toPadding,
                crossAxisSpacing: 5,
              ),
              itemBuilder: (_, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,

                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(

                      child: widget.children![index],
                    ),
                  ),
                );
              },
              // separatorBuilder: (context, index) {
              //   return widget.scrollDirection == Axis.vertical
              //       ? const SizedBox(height: kFormPaddingVertical,)
              //       : const SizedBox(width: kFormPaddingHorizontal,);
              // },
            ),
          ),
        ),
      ),
    );
  }
}
