import 'package:flutter/material.dart';
import 'package:mcini/screens/login/login_page.dart';
import 'package:mcini/utilities/app_colors.dart';

class HomeSwipper extends StatefulWidget {
  final List<String> images;

  const HomeSwipper({Key? key, required this.images}) : super(key: key);

  @override
  _HomeSwipperState createState() => _HomeSwipperState();
}

class _HomeSwipperState extends State<HomeSwipper> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          itemCount: widget.images.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.images[index]),
                  fit: BoxFit.cover,
                ),
              ),
              child: index == widget.images.length - 1
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
          onPageChanged: (index) {
            setState(() {
              currentPageIndex = index;
            });
          },
        ),
        Positioned(
          bottom: 20.0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < widget.images.length; i++)
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: i == currentPageIndex ? 12.0 : 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i == currentPageIndex ? Colors.white : Colors.grey,
                  ),
                ),
            ],
          ),
        ),
        Positioned(
          bottom: 40.0,
          left: MediaQuery.of(context).size.width * 0.46,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            child: Text(
              'Skip',
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}



/*
OLD CODE

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
*/