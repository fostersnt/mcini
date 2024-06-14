import 'package:flutter/material.dart';
import 'package:mcini/screens/home/home_page.dart';
import 'package:mcini/screens/movie/movie_player_page.dart';

Map<String, WidgetBuilder> getRoutes() {
  return {
    '/': (context) => const HomePage(),
    'movie_player': (context) => const MoviePlayerPage(),
  };
}
