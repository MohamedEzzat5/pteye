import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pteye/core/utils/app_router.dart';
import 'package:pteye/core/utils/style.dart';
import 'package:pteye/generated/assets.dart';


class CustomExerciseGridViewItem extends StatelessWidget {
  final String exerciseName;
  final String videoLink;

  const CustomExerciseGridViewItem({
    Key? key,
    required this.exerciseName,
    required this.videoLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(AppRouter.kVideoPlayerView,extra: videoLink);
        // Handle video tap, e.g., open the video link
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Spacer(flex: 1),
            AspectRatio(
              aspectRatio: 3 / 1.55,
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  // You can use a video thumbnail here if available
                  image: DecorationImage(
                    image: AssetImage(
                      Assets.imagesVideoPlay,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(textAlign: TextAlign.center,
              exerciseName,maxLines: 2,
              style:  Styles.textStyle16.copyWith(fontWeight: FontWeight.w600,overflow:TextOverflow.ellipsis,),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
