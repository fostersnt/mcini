// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
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
  final cookieManager = WebViewCookieManager();
  var loadingPercentage = 0;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the WebViewController
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
          'https://iframe.mediadelivery.net/embed/182548/b3560a19-8182-48f9-8888-cbd052887171?autoplay=true'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // body: Html(data: kExamplePage),
      // body: WebViewWidget(controller: widget.controller),
      body: Stack(
        children: [
          WebViewWidget(
            controller: _controller, // MODIFY
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
            ),
        ],
      ),
    );
  }
}
