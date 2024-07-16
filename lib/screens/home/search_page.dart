import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcini/data/model/movie_model.dart';
import 'dart:convert';
import 'package:mcini/data/provider/movie_provider.dart';
import 'package:mcini/utilities/app_colors.dart';
import 'package:mcini/utilities/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<MovieModel> _results = [];
  bool _isLoading = false;
  bool _isDefault = true;
  List<String> searchHistory = [];

  @override
  void initState() {
    super.initState();
    _fetchSearchHistory(); // Fetch data on page load
  }

  Future<void> _fetchSearchHistory() async {
    final data = await LocalStorage.getSearchHistory();
    if (data != null) {
      setState(() {
        searchHistory = data;
      });
    }
  }

  void _removeItem(int index) {
    setState(() {
      searchHistory.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(
          autofocus: true,
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search by movie title...',
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });

              final query = _searchController.text;
              if (query.isNotEmpty && !searchHistory.contains(query)) {
                setState(() {
                  searchHistory.add(query);
                });
                await LocalStorage.storeSearchHistroy(searchHistory);
              }

              final provider = MovieProvider();
              _results = await provider.getAllData();
              setState(() {
                _isLoading = false;
                _isDefault = false;
              });

              if (_results.isNotEmpty) {
                print('MOVIE DATA FOR SEARCHING IS NOT EMPTY');
                print(
                    'FIRST MOVIE COLLECTION IS: ${_results[0].collectionName}');
              } else {
                print('MOVIE DATA FOR SEARCHING IS EMPTY');
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.blueColor,
              ),
            )
          : _results.isNotEmpty
              ? ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_results[index].title ?? 'N/A'),
                      subtitle: Text(_results[index].collectionName ?? 'N/AAA'),
                    );
                  },
                )
              : _isDefault
                  ? Padding(
                      padding: EdgeInsets.all(10.0),
                      child: ListView.builder(
                        itemCount: searchHistory.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(searchHistory[index]),
                            trailing: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                _removeItem(index);
                                LocalStorage.storeSearchHistroy(searchHistory);
                              },
                            ),
                          );
                        },
                      ),
                    )
                  : const Center(child: Text('No results found')),
    );
  }
}
