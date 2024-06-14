import 'package:flutter/material.dart';
import 'package:mcini/screens/home/home_page.dart';
import 'package:mcini/utilities/app_colors.dart';

class CustomNavigationBar extends StatefulWidget {
  CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int selectedIndex = 0;
  // double myPadding = 10;

  final List<Widget> _pages = [
    const HomePage(),
    // Center(child: Text('Home')),
    Center(child: Text('Search')),
    Center(child: Text('Notifications')),
    Center(child: Text('Profile')),
  ];

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    final List<BottomNavigationBarItem> _bottomNavBarItems = [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color:
              selectedIndex == 0 ? AppColors.blueColor : AppColors.whiteColor,
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.favorite,
          color:
              selectedIndex == 1 ? AppColors.blueColor : AppColors.whiteColor,
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.search,
          color:
              selectedIndex == 2 ? AppColors.blueColor : AppColors.whiteColor,
        ),
        label: '',
      ),
    ];

    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: deviceSize.width * 0.08,
        elevation: 1,
        backgroundColor: AppColors.blackColor,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
          print('CURRENT INDEX: $value');
        },
        items: _bottomNavBarItems,
      ),
    );
  }
}
