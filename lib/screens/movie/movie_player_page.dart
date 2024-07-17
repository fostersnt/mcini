import 'package:flutter/material.dart';
import 'package:mcini/data/model/movie_model.dart';
import 'package:mcini/screens/movie/similar_movies.dart';
import 'package:mcini/utilities/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:mcini/screens/movie/movie_view_all_page.dart';

class MoviePlayerPage extends StatefulWidget {
  final int movie_index;
  final List<MovieModel> movies;

  const MoviePlayerPage(
      {super.key, required this.movie_index, required this.movies});
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
    print('MOVIE INDEX: ${widget.movie_index}');
    print('MOVIES: ${widget.movies[widget.movie_index].thumbnail}');
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
          Uri.parse(widget.movies[widget.movie_index].videoUrl ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final myMovies = widget.movies;
    final singleMovie = myMovies[widget.movie_index];
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
      body: SizedBox(
        height: deviceSize.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: deviceSize.width,
                height: deviceSize.width,
                child: WebViewWidget(
                  controller: _controller,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  singleMovie.title ?? 'N/A',
                  style: TextStyle(
                    color: AppColors.blueColor,
                    fontSize: deviceSize.width * 0.05,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      'Overview',
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: deviceSize.width * 0.05,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  singleMovie.description ?? 'N/A',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: deviceSize.width * 0.035,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
                child: Text(
                  'Similar Movies',
                  style: TextStyle(
                    color: AppColors.blueColor,
                    fontSize: deviceSize.width * 0.05,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SimilarMovies(
                  myMovies: myMovies,
                  clickedMovieIndex: widget.movie_index,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
