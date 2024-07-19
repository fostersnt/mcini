import 'package:flutter/material.dart';
import 'package:mcini/data/model/movie_model.dart';
import 'package:mcini/data/provider/movie_provider.dart';
import 'package:mcini/screens/movie/movie_player_page.dart';
import 'package:mcini/utilities/app_colors.dart';
import 'package:mcini/utilities/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<MovieModel> _results = [];
  bool _isLoading = false;
  bool _isDefault = true;
  List<String> searchHistory = [];
  List<MovieModel> _filteredMovies = [];

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
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.greySub,
      appBar: AppBar(
        backgroundColor: AppColors.greyMain,
        automaticallyImplyLeading: false,
        title: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: TextField(
            autofocus: true,
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search by movie title...',
              border: InputBorder.none,
              fillColor: AppColors.whiteColor,
              filled: true,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 30,
              color: AppColors.whiteColor,
            ),
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
              final movieResult = await provider.getAllData();
              setState(() {
                _results = movieResult;
                _isLoading = false;
                _isDefault = false;
              });

              if (_results.isNotEmpty) {
                print('MOVIE DATA FOR SEARCHING IS NOT EMPTY');
                setState(() {
                  _filteredMovies = _results.where((movie) {
                    return movie.title!
                        .toLowerCase()
                        .contains(_searchController.text.toLowerCase());
                  }).toList();
                });
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
          : _filteredMovies.isNotEmpty
              ? ListView.builder(
                  itemCount: _filteredMovies.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return MoviePlayerPage(
                              movie_index: index,
                              movies: _filteredMovies,
                            );
                          },
                        ));
                      },
                      child: ListTile(
                        title: Text(
                          _filteredMovies[index].title ?? 'N/A',
                          style: TextStyle(
                            color: AppColors.whiteColor,
                          ),
                        ),
                        subtitle: Text(
                          _filteredMovies[index].collectionName ?? 'N/AAA',
                          style: TextStyle(
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    );
                  },
                )
              : _isDefault
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                        itemCount: searchHistory.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              searchHistory[index],
                              style: TextStyle(
                                color: AppColors.whiteColor,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.close,
                                color: AppColors.whiteColor,
                              ),
                              onPressed: () {
                                _removeItem(index);
                                LocalStorage.storeSearchHistroy(searchHistory);
                              },
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
    );
  }
}
