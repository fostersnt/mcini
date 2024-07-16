import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mcini/data/provider/movie_provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _results = [];
  bool _isLoading = false;

  // Future<void> _search() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   String query = _searchController.text;
  //   if (query.isEmpty) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     return;
  //   }

  //   // Replace with your API URL
  //   final response =
  //       await http.get(Uri.parse('https://api.example.com/search?q=$query'));

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       _results = json.decode(response.body);
  //       _isLoading = false;
  //     });
  //   } else {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     throw Exception('Failed to load data');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final provider = MovieProvider();
              final moviedata = await provider.getAllData();
              if (moviedata.isNotEmpty) {
                print('MOVIE DATA FOR SEARCHING IS NOT EMPTY');
                print(
                    'FIRST MOVIE COLLECTION IS: ${moviedata[0].collectionName}');
              } else {
                print('MOVIE DATA FOR SEARCHING IS EMPTY');
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _results.isEmpty
              ? const Center(child: Text('No results found'))
              : ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_results[index]['title']),
                      subtitle: Text(_results[index]['description']),
                    );
                  },
                ),
    );
  }
}
