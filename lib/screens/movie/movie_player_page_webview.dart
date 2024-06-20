// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mcini/utilities/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:mcini/data/model/movie_model.dart';

class MoviePlayerPage extends StatefulWidget {
  final WebViewController controller;
  final MovieModel movie;
  const MoviePlayerPage({
    super.key,
    required this.movie,
    required this.controller,
  });

  @override
  State<MoviePlayerPage> createState() => _MoviePlayerPageState();
}

class _MoviePlayerPageState extends State<MoviePlayerPage> {
  final cookieManager = WebViewCookieManager();
  var loadingPercentage = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   // Modify from here...
  //   widget.controller.setNavigationDelegate(
  //     NavigationDelegate(
  //       onPageStarted: (url) {
  //         setState(() {
  //           loadingPercentage = 0;
  //         });
  //       },
  //       onProgress: (progress) {
  //         setState(() {
  //           loadingPercentage = progress;
  //         });
  //       },
  //       onPageFinished: (url) {
  //         setState(() {
  //           loadingPercentage = 100;
  //         });
  //       },
  //     ),
  //   );
  //   // ...to here.
  // }

  @override
  Widget build(BuildContext context) {
    String videoUrl =
        // 'https://www.youtube.com/shorts/NsMKvVdEPkw';
        'https://iframe.mediadelivery.net/embed/182548/e941715e-7de1-4875-a42b-c52a982fa72c?autoplay=false';

    String kExamplePage = '''

<iframe src="$videoUrl"
                        loading="mcini" style="border: none; position: absolute; top: 0; height: 50%; width: 100%;"
                        allow="" allowfullscreen="true">
                    </iframe>

''';
    // widget.controller.loadRequest(Uri.parse(widget.movie.videoUrl));
    widget.controller.loadHtmlString(kExamplePage);
    // widget.controller.loadRequest(
    //   Uri.parse(videoUrl),
    //   method: LoadRequestMethod.get,
    // );
    return Scaffold(
      appBar: AppBar(),
      // body: Html(data: kExamplePage),
      // body: WebViewWidget(controller: widget.controller),
      body: Stack(
        children: [
          WebViewWidget(
            controller: widget.controller, // MODIFY
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
