// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';

import 'package:mcini/data/model/movie_model.dart';
import 'package:mcini/screens/home/custom_navigation_bar.dart';
import 'package:mcini/utilities/app_colors.dart';

class MoviePlayerPage extends StatefulWidget {
  final MovieModel movie;
  const MoviePlayerPage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MoviePlayerPage> createState() => _MoviePlayerPageState();
}

class _MoviePlayerPageState extends State<MoviePlayerPage> {
  late CustomVideoPlayerController _customVideoPlayerController;
  bool isVideoLoading = true;
  bool isError = false;
  String errorMessage = '';
  @override
  void initState() {
    super.initState();
    initializaVideoPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceScreen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        foregroundColor: AppColors.whiteColor,
        elevation: 1,
      ),
      backgroundColor: AppColors.blackColor,
      bottomNavigationBar: CustomNavigationBar(),
      body: isVideoLoading
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.whiteColor,
              ),
            )
          : !isError
              ? Column(
                  children: [
                    CustomVideoPlayer(
                      customVideoPlayerController: _customVideoPlayerController,
                    )
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Text(
                      widget.movie.videoUrl,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: deviceScreen.width * 0.04,
                      ),
                    ),
                  ),
                ),
    );
  }

  void initializaVideoPlayer() {
    CachedVideoPlayerController cachedVideoPlayerController;
    cachedVideoPlayerController =
        // CachedVideoPlayerController.asset('lib/assets/videos/crabs.mp4')
        CachedVideoPlayerController.network(widget.movie.videoUrl)
          ..initialize()
              .then((value) => setState(() {
                    isVideoLoading = false;
                  }))
              .catchError((error) {
            // Handle the error here
            setState(() {
              isVideoLoading = false;
              isError = true;
              errorMessage = error.toString();
            });
            print('Error initializing video player: $error');
            print('VIDEO URL: ${widget.movie.videoUrl}');
          });
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: cachedVideoPlayerController,
      customVideoPlayerSettings: const CustomVideoPlayerSettings(
          // thumbnailWidget: Image.asset('lib/assets/images/banner.png'),
          ),
    );
  }
}
