import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcini/data/provider/movie_provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // void _makeAPICall() async {
  //   // Replace this URL with your API endpoint
  //   String apiUrl = 'https://api.example.com/data?query=$_searchQuery';

  //   try {
  //     var response = await http.get(Uri.parse(apiUrl));

  //     if (response.statusCode == 200) {
  //       // API call was successful, handle response data here
  //       var jsonData = jsonDecode(response.body);
  //       // Handle your data processing here
  //       print('API Response: $jsonData');
  //     } else {
  //       // API call failed, handle error
  //       print('Failed to load data: ${response.statusCode}');
  //       throw Exception('Failed to load data');
  //     }
  //   } catch (e) {
  //     // Handle exceptions thrown during API call
  //     print('Exception encountered: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: TextField(
          autofocus: true,
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              print('Search button clicked');
              final provider = MovieProvider();
              final movieData = provider.getAllData();
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              // Make API call here
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Your content here',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
