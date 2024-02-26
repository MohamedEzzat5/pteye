// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:pteye/core/utils/constance.dart';
// import 'package:pteye/core/utils/style.dart';
// import 'package:video_player/video_player.dart';
// import 'package:chewie/chewie.dart';
//
// class VideoPlayerView extends StatefulWidget {
//   final String videoUrl;
//
//   const VideoPlayerView({Key? key, required this.videoUrl}) : super(key: key);
//
//   @override
//   VideoPlayerViewState createState() => VideoPlayerViewState();
// }
//
// class VideoPlayerViewState extends State<VideoPlayerView> {
//   late VideoPlayerController _videoPlayerController;
//   late ChewieController _chewieController;
//
//   @override
//   void initState() {
//     super.initState();
//     _videoPlayerController =
//         VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController,
//       autoPlay: true,
//       zoomAndPan: true,
//       allowFullScreen: true,
//       placeholder: SpinKitFadingCircle(
//         color: kPrimaryColor,
//       ),
//       looping: false,
//       autoInitialize: true,
//       showControlsOnInitialize: false,
//       showControls: true,
//       errorBuilder: (context, errorMessage) {
//         print('=================' + errorMessage.toString());
//         return Center(
//             child: Text(
//           'برجاء التأكد من الاتصال بالانترنت',
//           style: Styles.textStyle20.copyWith(color: Colors.white),
//         ));
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     _chewieController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: kPrimaryColor),
//         centerTitle: true,
//         title: Text(''),
//       ),
//       body: Center(
//         child: Chewie(
//           controller: _chewieController,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:pteye/core/utils/constance.dart';

class VideoPlayerView extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerView({Key? key, required this.videoUrl}) : super(key: key);

  @override
  VideoPlayerViewState createState() => VideoPlayerViewState();
}

class VideoPlayerViewState extends State<VideoPlayerView> {
  late YoutubePlayerController _youtubePlayerController;

  @override
  void initState() {
    super.initState();
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl) ?? 'X7xtJIRF0NI',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        loop: true,
        hideThumbnail: true,
        isLive: false,
        forceHD: false,
        useHybridComposition: false,
      ),
    );
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _youtubePlayerController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _youtubePlayerController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kPrimaryColor),
        centerTitle: true,
      ),
      body: Center(
        child: YoutubePlayer(
          aspectRatio: 16 / 9,
          controller: _youtubePlayerController,
          showVideoProgressIndicator: true,
          progressColors: const ProgressBarColors(
              playedColor: kPrimaryColor, handleColor: kPrimaryColor),
          progressIndicatorColor: kPrimaryColor,
          bottomActions: [
            CurrentPosition(),
            ProgressBar(
              isExpanded: true,
              colors: const ProgressBarColors(
                playedColor: kPrimaryColor,
                handleColor: kPrimaryColor,
              ),
            ),
            RemainingDuration(),

          ],
        ),
      ),
    );
  }
}
