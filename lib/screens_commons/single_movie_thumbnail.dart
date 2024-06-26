// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mcini/data/model/movie_model.dart';
import 'package:mcini/screens/movie/movie_player_page.dart';

import 'package:mcini/utilities/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SingleMovieThumbnail extends StatefulWidget {
  const SingleMovieThumbnail(
      {super.key, required this.deviceSize, required this.movieData});
  final Size deviceSize;
  final MovieModel movieData;

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
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.movieData.thumbnail ?? ''));

    // if (widget.movieData.thumbnail != null) {
    //   _controller = WebViewController()
    //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //     ..loadRequest(Uri.parse(widget.movieData.thumbnail ?? ''));
    // } else {
    //   _controller = WebViewController()
    //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //     ..loadFlutterAsset('lib/assets/images/banner.png');
    // }
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
          onTap: () {
            print("VIDEO THUMBNAIL HAS BEEN CLICKED");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MoviePlayerPage(
                  // controller: WebViewController(),
                  movie: widget.movieData,
                ),
              ),
            );
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
              Container(
                width: deviceSize.width * 0.4,
                height: deviceSize.width * 0.4 + 20,
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: SizedBox(
                    // width: deviceSize.width,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0),
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
            child: Text(
              widget.movieData.title ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: widget.deviceSize.width * 0.03),
            ),
          ),
        ),
      ],
    );
  }
}
