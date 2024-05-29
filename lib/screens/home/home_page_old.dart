import 'package:flutter/material.dart';
import 'package:mcini/utilities/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double heroImageHeight = screenSize.height * 0.35;
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                'lib/images/banner.png',
                width: screenSize.width,
                height: heroImageHeight,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: heroImageHeight * 0.16, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.whiteColor,
                      ),
                      onTap: () {
                        print("Mcini logo is clicked");
                      },
                    ),
                    InkWell(
                      child: Icon(
                        Icons.search,
                        color: AppColors.whiteColor,
                        size: 35,
                      ),
                      onTap: () {
                        print("Search icon is clicked");
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: heroImageHeight * 0.33, horizontal: 10),
                child: Container(
                  width: screenSize.width * 0.5,
                  height: heroImageHeight * 0.6,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Lorem Ipsum Lorem Ipsum Lorem Ipsum",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Extra text Extra text Extra text Extra text Extra text Extra text text Extra text Extra text Extra text text Extra text Extra text Extra text",
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: 60,
                            height: 25,
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
                                    style:
                                        TextStyle(color: AppColors.whiteColor),
                                  ),
                                  Icon(
                                    Icons.play_arrow_rounded,
                                    color: AppColors.whiteColor,
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
          ),
        ],
      ),
    );
  }
}
