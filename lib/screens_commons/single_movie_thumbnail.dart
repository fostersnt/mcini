// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mcini/data/model/movie_model.dart';

import 'package:mcini/utilities/app_colors.dart';

class SingleMovieThumbnail extends StatelessWidget {
  const SingleMovieThumbnail(
      {super.key, required this.deviceSize, required this.movieData});
  final Size deviceSize;
  final MovieModel movieData;
  final double customHeight = 150;
  final double customWidth = 150;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            print("VIDEO THUMBNAIL HAS BEEN CLICKED");
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'lib/assets/images/banner.png',
                width: customWidth,
                height: customHeight,
                fit: BoxFit.fill,
              ),
              // Container(
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
            width: customWidth,
            child: Text(
              movieData.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: AppColors.whiteColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
