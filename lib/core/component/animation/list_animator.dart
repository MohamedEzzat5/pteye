import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pteye/core/utils/media_query_values.dart';


class ListAnimator extends StatefulWidget {
  final List<Widget>? children;
  final int? duration;
  final double? verticalOffset;
  final ScrollPhysics? physics;
  final Axis scrollDirection;

  const ListAnimator({
    Key? key,
    this.children,
    this.duration,
    this.scrollDirection = Axis.vertical,

    this.verticalOffset,
    this.physics,
  }) : super(key: key);

  @override
  ListAnimatorState createState() => ListAnimatorState();
}

class ListAnimatorState extends State<ListAnimator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:context.height,
      child: AnimationConfiguration.synchronized(
        child: SlideAnimation(
          verticalOffset: 50.0,
          child: AnimationLimiter(
            child: ListView.separated(
              scrollDirection: widget.scrollDirection,
              itemCount: widget.children!.length,
              physics: widget.physics,
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
              separatorBuilder: (context, index) {
                return widget.scrollDirection == Axis.vertical
                    ?  SizedBox(height: context.toPadding,)
                    :  SizedBox(width: context.toPadding,);
              },
            ),
          ),
        ),
      ),
    );
  }
}
