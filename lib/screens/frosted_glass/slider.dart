import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ImageSliderPage(),
      routes: {
        '/profile': (context) => const UserProfilePage(),
      },
    );
  }
}

class ImageSliderPage extends StatefulWidget {
  const ImageSliderPage({super.key});

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
        title: const Text('Image Slider'),
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
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: const Center(
        child: Text('This is the user profile page'),
      ),
    );
  }
}
