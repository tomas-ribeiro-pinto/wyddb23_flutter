import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:wyddb23_flutter/Components/wyd_resources.dart';

class VideoPage extends StatelessWidget {
  VideoPage({Key? key, required this.controller}) : super(key: key);

  CachedVideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
          child: controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: CachedVideoPlayer(controller)
                  )
              : CircularProgressIndicator(color:WydColors.yellow)), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}