// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mcini/data/model/movie_model.dart';
import 'package:mcini/screens/movie/movie_player_page.dart';

import 'package:mcini/utilities/app_colors.dart';
import 'package:mcini/utilities/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SingleMovieThumbnail extends StatefulWidget {
  SingleMovieThumbnail({
    super.key,
    required this.deviceSize,
    required this.movieData,
    required this.movieIndex,
    required this.childWidget,
  });
  final Size deviceSize;
  final List<MovieModel> movieData;
  int movieIndex;
  final Widget childWidget;

  @override
  State<SingleMovieThumbnail> createState() => _SingleMovieThumbnailState();
}

class _SingleMovieThumbnailState extends State<SingleMovieThumbnail> {
  final double customHeight = 150;

  final double customWidth = 150;

  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the WebViewController
    print('MOVIE INDEX INDEX 1 === ${widget.movieIndex}');
    if (widget.movieData.length == widget.movieIndex) {
      widget.movieIndex = widget.movieData.length - 1;
    }

    if (widget.movieData[widget.movieIndex].thumbnail != null) {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(
          Uri.parse(widget.movieData[widget.movieIndex].thumbnail ?? ''),
        );
    } else {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadFlutterAsset('lib/assets/images/banner.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    final thumbnailWidth = widget.deviceSize.width * 0.4;
    final thumbnailHeight = widget.deviceSize.width * 0.5;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () async {
            print("VIDEO THUMBNAIL HAS BEEN CLICKED");
            final subscriberData = await LocalStorage.getStoredSubscriber();
            print('SUB STATUS: $subscriberData');
            if (subscriberData != null &&
                subscriberData['subscription_status'] != null &&
                subscriberData['subscription_status'].toLowerCase() ==
                    'inactive') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MoviePlayerPage(
                    // controller: WebViewController(),
                    movie_index: widget.movieIndex,
                    movies: widget.movieData,
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                AppColors.customSnackBar(
                    'You have no active subscription', deviceSize, true),
              );
            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Image.asset(
              //   'lib/assets/images/banner.png',
              //   // movieData.thumbnail,
              //   fit: BoxFit.fill,
              //   width: 160,
              //   height: 180,
              // ),
              SizedBox(
                width: deviceSize.width * 0.4,
                height: deviceSize.width * 0.4 + 20,
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    // width: deviceSize.width,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: WebViewWidget(
                        controller: _controller,
                      ),
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  ClipOval(
                    child: Container(
                      width: 40,
                      height: 40,
                      // color: AppColors.whiteColor,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(width: 2, color: AppColors.whiteColor),
                      ),
                      child: Icon(
                        CupertinoIcons.play,
                        color: AppColors.whiteColor,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
              // ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(3, 5, 0, 0),
          child: SizedBox(
            width: thumbnailWidth,
            child: widget.childWidget,
          ),
        ),
      ],
    );
  }
}
