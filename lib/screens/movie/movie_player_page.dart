// import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:mcini/utilities/app_colors.dart';

class MoviePlayerPage extends StatefulWidget {
  const MoviePlayerPage({super.key});

  @override
  State<MoviePlayerPage> createState() => _MoviePlayerPageState();
}

class _MoviePlayerPageState extends State<MoviePlayerPage> {
  late CustomVideoPlayerController _customVideoPlayerController;
  bool isVideoLoading = true;
  @override
  void initState() {
    super.initState();
    initializaVideoPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        foregroundColor: AppColors.whiteColor,
        elevation: 1,
      ),
      backgroundColor: AppColors.blackColor,
      body: isVideoLoading
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.whiteColor,
              ),
            )
          : Column(
              children: [
                CustomVideoPlayer(
                  customVideoPlayerController: _customVideoPlayerController,
                ),
              ],
            ),
    );
  }

  void initializaVideoPlayer() {
    CachedVideoPlayerController cachedVideoPlayerController;
    cachedVideoPlayerController =
        CachedVideoPlayerController.asset('lib/assets/videos/crabs.mp4')
          ..initialize().then((value) => setState(() {
                isVideoLoading = false;
              }));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: cachedVideoPlayerController,
      customVideoPlayerSettings: CustomVideoPlayerSettings(
        thumbnailWidget: Image.asset('lib/assets/images/banner.png'),
      ),
    );
  }
}
