import 'package:flutter/material.dart';
import 'package:mcini/screens/home/home_page.dart';

Map<String, WidgetBuilder> getRoutes() {
  return {
    '/': (context) => const HomeView(),
    // 'movie_player': (context) => const MoviePlayerPage(),
  };
}
