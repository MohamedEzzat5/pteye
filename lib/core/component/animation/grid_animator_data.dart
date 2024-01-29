import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pteye/core/utils/media_query_values.dart';
import '../../utils/constance.dart';
import '../spaces.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_spinkit/flutter_spinkit.dart';


class GridAnimatorData extends StatefulWidget {
  final int? itemCount;
  final int? duration;
  final int crossAxisCount;
  final double height;
  final double width;
  final double? verticalOffset;
  final ScrollPhysics? physics;
  final bool primary;
  final bool shrinkWrap;
  final bool isAnimated;
  final Widget? loadingWidget;
  final int? simmerItemCount;
  final Widget? noDataWidget;
  final Widget? separatorWidget;
  final bool isReverse;
  final Axis scrollDirection;
  final IndexedWidgetBuilder itemBuilder;
  final EdgeInsetsGeometry? padding;

  //pagination
  final Function? onNextCall;
  final int? totalPages;
  final int? currentPage;
  final bool? isNextPageLoading;

  const GridAnimatorData({
    Key? key,
    this.itemCount,
    this.duration,
    this.isAnimated = true,
    this.scrollDirection = Axis.vertical,
    this.primary = false,
    this.shrinkWrap = true,
    this.isReverse = false,
    required this.itemBuilder,
    this.noDataWidget,
    this.separatorWidget,
    this.loadingWidget,
    this.verticalOffset,
    this.height=127,
    this.width=172,
    this.crossAxisCount =2,
    this.padding,
    this.physics,
    this.simmerItemCount,
    this.isNextPageLoading,
    this.onNextCall,
    this.currentPage,
    this.totalPages,
  }) : super(key: key);

  @override
  GridAnimatorDataState createState() => GridAnimatorDataState();
}

class GridAnimatorDataState extends State<GridAnimatorData> {


  @override
  Widget build(BuildContext context) {
    if (widget.itemCount == null) {
      return widget.loadingWidget != null
          ? _buildSimmerList()
          :  const Center(child: SpinKitFadingCircle(color: kPrimaryColor,));
    } else if (widget.itemCount == 0) {
      return widget.noDataWidget ?? const SizedBox();
    } else {
      return SizedBox(
        child: AnimationConfiguration.synchronized(
          child: SlideAnimation(
              verticalOffset: widget.scrollDirection == Axis.vertical && widget.isAnimated ? 50.0 : null,
              horizontalOffset: widget.scrollDirection == Axis.horizontal && widget.isAnimated ? 50.0 : null,
              child: AnimationLimiter(
                  child: GridView.builder(
                    gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: context.width,
                      mainAxisSpacing:context.toPadding  ,
                      childAspectRatio: 10,
                      crossAxisSpacing: context.toPadding,
                      mainAxisExtent: context.height,

                    ),/*          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: (1 / 1),
                      crossAxisCount: widget.crossAxisCount,
                      mainAxisSpacing: kFormPaddingHorizontal,
                      crossAxisSpacing: kFormPaddingVertical,
                    ),*/
                itemCount: widget.itemCount ?? 0,
                itemBuilder: widget.itemBuilder,
                scrollDirection: widget.scrollDirection,
                primary: widget.primary,
                physics: widget.physics ?? const AlwaysScrollableScrollPhysics(),
                shrinkWrap: widget.shrinkWrap,
                padding: widget.padding,
                reverse: widget.isReverse,
                // separatorBuilder: (context, index) {
                //   return widget.separatorWidget ??
                //       (widget.scrollDirection == Axis.vertical
                //           ?const VerticalSpace( kFormPaddingVertical)
                //           :const HorizontalSpace( kFormPaddingHorizontal)
                //       );
                // },
              ))),
        ),
      );
    }
  }

  _buildSimmerList() {
    return ListView.separated(
      itemCount: widget.simmerItemCount ?? 1,
      itemBuilder: (context, index) {
        return widget.loadingWidget ?? Container();
      },
      scrollDirection: widget.scrollDirection,
      primary: widget.primary,
      shrinkWrap: widget.shrinkWrap,
      padding: widget.padding,
      reverse: widget.isReverse,
      separatorBuilder: (context, index) {
        return widget.separatorWidget ??
            (widget.scrollDirection == Axis.vertical
                ?  VerticalSpace( context.toPadding)
                : HorizontalSpace( context.toPadding)
            );
      },
    );
  }
}
