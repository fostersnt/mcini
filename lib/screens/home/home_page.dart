import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mcini/data/model/movie_model.dart';
import 'package:mcini/screens/home/hero_section.dart';
import 'package:mcini/screens_commons/single_movie_thumbnail.dart';
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
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: SingleMovieThumbnail(
                      deviceSize: screenSize,
                      movieData: MovieModel(
                          name: 'Lilwayne De Drunk',
                          title: 'Ghana Best',
                          category: 'Local Movie'),
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
