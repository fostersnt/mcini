// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mcini/data/model/movie_model.dart';
import 'package:mcini/screens/movie/movie_player_page.dart';

import 'package:mcini/utilities/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SingleMovieThumbnail extends StatelessWidget {
  const SingleMovieThumbnail(
      {super.key, required this.deviceSize, required this.movieData});
  final Size deviceSize;
  final MovieModel movieData;
  final double customHeight = 150;
  final double customWidth = 150;
  @override
  Widget build(BuildContext context) {
    final thumbnailWidth = deviceSize.width * 0.4;
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
                  controller: WebViewController(),
                  movie: movieData,
                ),
              ),
            );
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'lib/assets/images/banner.png',
                // movieData.thumbnail,
                fit: BoxFit.fill,
                width: thumbnailWidth,
                height: deviceSize.width * 0.3,
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
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: SizedBox(
            width: thumbnailWidth,
            child: Text(
              movieData.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: deviceSize.width * 0.04),
            ),
          ),
        ),
      ],
    );
  }
}
