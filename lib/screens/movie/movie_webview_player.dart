// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mcini/data/model/movie_model.dart';

class MovieWebviewPlayer extends StatefulWidget {
  final MovieModel movie;
  const MovieWebviewPlayer({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MovieWebviewPlayer> createState() => _MovieWebviewPlayerState();
}

class _MovieWebviewPlayerState extends State<MovieWebviewPlayer> {
  @override
  Widget build(BuildContext context) {
    final currentMovie = widget.movie;
    return Scaffold(
      appBar: AppBar(
        title: Text(currentMovie.title),
      ),
    );
  }
}
