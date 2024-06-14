import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mcini/data/model/movie_model.dart';
import 'package:mcini/routes/app_routes.dart';
import 'package:mcini/screens/home/custom_navigation_bar.dart';
import 'package:mcini/screens/home/home_page.dart';
import 'package:mcini/screens/home/home_slider.dart';
import 'package:mcini/screens/movie/movie_player_page.dart';
import 'package:mcini/screens_commons/movie_categories_grouping.dart';
import 'package:device_preview/device_preview.dart';
import 'package:mcini/utilities/app_colors.dart';

void main() {
  ;
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // routes: getRoutes(),
      //Device preview settings
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Mcini Mobile',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      // home: const HomeSlider(),
      // home: const MoviePlayerPage(),
      // home: const MovieCategoriesGroup(),
      home: Scaffold(
        backgroundColor: AppColors.blackColor,
        body: null,
        bottomNavigationBar: CustomNavigationBar(),
      ),
      // initialRoute: '/',
    );
  }
}
