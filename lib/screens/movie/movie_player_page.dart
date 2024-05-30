// import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';

class MoviePlayerPage extends StatefulWidget {
  const MoviePlayerPage({super.key});

  @override
  State<MoviePlayerPage> createState() => _MoviePlayerPageState();
}

class _MoviePlayerPageState extends State<MoviePlayerPage> {
  late CustomVideoPlayerController _customVideoPlayerController;

  @override
  void initState() {
    super.initState();
    initializaVideoPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomVideoPlayer(
          customVideoPlayerController: _customVideoPlayerController),
    );
  }

  void initializaVideoPlayer() {
    CachedVideoPlayerController _cachedVideoPlayerController;
    _cachedVideoPlayerController =
        CachedVideoPlayerController.asset('lib/assets/videos/crabs.mp4')
          ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _cachedVideoPlayerController,
      customVideoPlayerSettings: CustomVideoPlayerSettings(
        thumbnailWidget: Image.asset('lib/assets/images/banner.png'),
      ),
    );
  }
}
