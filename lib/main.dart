import 'package:flutter/material.dart';
import 'package:mcini/screens/home_slider/home_slider.dart';
import 'package:mcini/screens/movie/movie_player_page.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mcini',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      home: const HomeSlider(),
      // home: const MoviePlayerPage(),
      // home: const MovieCategoriesGroup(),
      // home: const HomePage(),
    );
  }
}
