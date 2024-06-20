// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';

import 'package:mcini/data/model/movie_model.dart';
import 'package:mcini/utilities/app_colors.dart';

class MoviePlayerPage extends StatefulWidget {
  final MovieModel movie;
  const MoviePlayerPage({
    super.key,
    required this.movie,
  });

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
    final myMovieData = widget.movie;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        foregroundColor: AppColors.whiteColor,
        elevation: 1,
      ),
      backgroundColor: AppColors.blackColor,
      // bottomNavigationBar: CustomNavigationBar(),
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
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(
                        'lib/assets/images/banner.png',
                        width: deviceScreen.width,
                        height: deviceScreen.height * 0.3,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Unable to play video. An ERROR has occurred',
                          // errorMessage,
                          // widget.movie.videoUrl,
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: deviceScreen.width * 0.05,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Container(
                          child: Text(
                            myMovieData.description != ''
                                ? myMovieData.description
                                : 'No Description Available',
                            style: TextStyle(
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          width: deviceScreen.width,
                          color: AppColors.blueColor,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Go Back',
                              style: TextStyle(
                                  fontSize: deviceScreen.width * 0.05,
                                  color: AppColors.whiteColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  void initializaVideoPlayer() {
    CachedVideoPlayerController cachedVideoPlayerController;
    cachedVideoPlayerController =
        // CachedVideoPlayerController.asset('lib/assets/videos/crabs.mp4')
        CachedVideoPlayerController.network(
            'https://iframe.mediadelivery.net/embed/182548/e941715e-7de1-4875-a42b-c52a982fa72c')
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
