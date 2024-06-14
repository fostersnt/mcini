import 'package:flutter/material.dart';
import 'package:mcini/utilities/app_colors.dart';

class HeroSection extends StatelessWidget {
  final Size deviceSize;

  const HeroSection({super.key, required this.deviceSize});
  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
    final double heroImageHeight = deviceSize.height * 0.37;
    return Stack(
      children: [
        Image.asset(
          'lib/assets/images/banner.png',
          width: deviceSize.width,
          height: heroImageHeight,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.whiteColor,
                  size: deviceSize.width * 0.05,
                ),
                onTap: () {
                  print("Mcini logo is clicked");
                },
              ),
              InkWell(
                child: Icon(
                  Icons.search,
                  color: AppColors.whiteColor,
                  size: deviceSize.width * 0.08,
                ),
                onTap: () {
                  print("Search icon is clicked");
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 50, 0, 0),
          child: SizedBox(
            width: deviceSize.width * 0.8,
            // height: heroImageHeight * 0.3,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                    child: Text(
                      "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: deviceSize.width * 0.05,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "Extra text Extra text Extra text Extra Extra text Extra text Extra text Extra text Extra text Extra text text Extra text Extra text Extra text text Extra text Extra text Extra text",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: deviceSize.width * 0.04,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      width: deviceSize.width * 0.2,
                      height: deviceSize.width * 0.08,
                      padding: const EdgeInsets.only(left: 5),
                      color: AppColors.blueColor,
                      child: InkWell(
                        onTap: () {
                          print("The PLAY button has been clicked");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Play",
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: deviceSize.width * 0.04,
                              ),
                            ),
                            Icon(
                              Icons.play_arrow_rounded,
                              color: AppColors.whiteColor,
                              size: deviceSize.width * 0.08,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
