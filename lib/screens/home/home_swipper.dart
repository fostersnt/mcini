import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:mcini/screens/login/login_page.dart';

class HomeSwipper extends StatelessWidget {
  final List<String> images;
  const HomeSwipper({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(images[index]),
              fit: BoxFit.cover,
            ),
          ),
          child: index == images.length - 1
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: const Center(
                    child: Text(
                      'Tap to Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : Container(),
        );
      },
    );
  }
}
