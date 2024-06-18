import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageSliderPage(),
      routes: {
        '/profile': (context) => UserProfilePage(),
      },
    );
  }
}

class ImageSliderPage extends StatefulWidget {
  @override
  _ImageSliderPageState createState() => _ImageSliderPageState();
}

class _ImageSliderPageState extends State<ImageSliderPage> {
  final PageController _pageController = PageController();

  void _onPageChanged(int index) {
    if (index == 2) {
      // Index 2 corresponds to the third image
      Navigator.pushNamed(context, '/profile');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Slider'),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: <Widget>[
          Image.network('https://example.com/image1.jpg'),
          Image.network('https://example.com/image2.jpg'),
          Image.network('https://example.com/image3.jpg'),
        ],
      ),
    );
  }
}

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Center(
        child: Text('This is the user profile page'),
      ),
    );
  }
}
