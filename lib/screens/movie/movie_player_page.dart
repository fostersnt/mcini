import 'package:flutter/material.dart';
import 'package:mcini/data/model/movie_model.dart';
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
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: deviceSize.width + 10,
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: SizedBox(
                    width: deviceSize.width,
                    height: 300,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: WebViewWidget(
                        controller: _controller,
                      ),
                    ),
                  ),
                ),
              ),
              if (loadingPercentage < 100)
                LinearProgressIndicator(
                  value: loadingPercentage / 100.0,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
