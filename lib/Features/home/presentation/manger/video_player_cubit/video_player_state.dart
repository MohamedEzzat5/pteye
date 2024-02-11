// import 'package:equatable/equatable.dart';
// import 'package:video_player/video_player.dart';
// import 'package:chewie/chewie.dart';
//
// abstract class VideoPlayerState extends Equatable {
//   const VideoPlayerState();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class VideoPlayerInitial extends VideoPlayerState {}
//
// class VideoPlayerLoading extends VideoPlayerState {}
//
// class VideoPlayerLoaded extends VideoPlayerState {
//   final VideoPlayerController videoPlayerController;
//   final ChewieController chewieController;
//
//   const VideoPlayerLoaded({
//     required this.videoPlayerController,
//     required this.chewieController,
//   });
//
//   @override
//   List<Object?> get props => [videoPlayerController, chewieController];
// }
//
// class VideoPlayerError extends VideoPlayerState {
//   final String errorMessage;
//
//   const VideoPlayerError({
//     required this.errorMessage,
//   });
//
//   @override
//   List<Object?> get props => [errorMessage];
// }
