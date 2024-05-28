import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mcini/screens/home/hero_section.dart';
import 'package:mcini/utilities/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: AppColors.blackColor,
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          //Image and top text
          Padding(
              padding: const EdgeInsets.all(0),
              child: HeroSection(
                deviceSize: screenSize,
              )),
          //First category
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              color: AppColors.whiteColor,
              // width: 100,
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Container(
                      width: 100,
                      height: 100,
                      color: AppColors.blueColor,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
