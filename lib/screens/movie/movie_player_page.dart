import 'package:flutter/material.dart';
import 'package:mcini/data/model/movie_model.dart';
import 'package:mcini/utilities/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MoviePlayerPage extends StatefulWidget {
  final MovieModel movie;

  const MoviePlayerPage({super.key, required this.movie});
  @override
  _MoviePlayerPageSate createState() => _MoviePlayerPageSate();
}

class _MoviePlayerPageSate extends State<MoviePlayerPage> {
  late final WebViewController _controller;
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    // Initialize the WebViewController
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.movie.videoUrl ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        title: const Text('Video Player'),
        backgroundColor: AppColors.blackColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: Column(
        children: [
          // Stack(
          //   children: [
          SizedBox(
            height: deviceSize.width,
            width: deviceSize.width,
            child: WebViewWidget(
              controller: _controller,
            ),
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
            ),
          // ],
          // ),
        ],
      ),
    );
  }
}
