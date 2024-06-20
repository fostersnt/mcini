// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mcini/utilities/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:mcini/data/model/movie_model.dart';

class MoviePlayerPage extends StatefulWidget {
  final MovieModel movie;
  const MoviePlayerPage({
    super.key,
    required this.movie,
  });

  @override
  State<MoviePlayerPage> createState() => _MoviePlayerPageState();
}

class _MoviePlayerPageState extends State<MoviePlayerPage> {
  late final WebViewController controller;
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..loadRequest(
        Uri.parse('https://flutter.dev'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(
          controller: controller,
        ),
        if (loadingPercentage < 100)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: LinearProgressIndicator(
                value: loadingPercentage / 100.0,
                color: AppColors.blueColor,
              ),
            ),
          ),
      ],
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Flutter WebView'),
    //   ),
    //   body: WebViewWidget(
    //     controller: controller,
    //   ),
    // );
  }
}
