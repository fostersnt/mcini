import 'package:flutter/material.dart';
import 'dart:ui';

class BlurEffectPage extends StatelessWidget {
  const BlurEffectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // The background image or content
          Positioned.fill(
            child: Image.network(
              'https://example.com/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // The frosted glass effect
          const Center(
            child: BlurEffectView(
              width: 300.0,
              height: 300.0,
            ),
          ),
        ],
      ),
    );
  }
}

class BlurEffectView extends StatelessWidget {
  final double width;
  final double height;

  const BlurEffectView({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        width: width,
        height: height,
        child: Stack(
          children: <Widget>[
            // Blur effect
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
            // Optional content on top of the blur effect
            const Center(
              child: Text(
                'Frosted Glass',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
