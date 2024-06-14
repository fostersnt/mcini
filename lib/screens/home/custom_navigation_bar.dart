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
  final List<Widget> _pages = [
    const HomePage(),
    Center(child: Text('Search')),
    Center(child: Text('Notifications')),
    Center(child: Text('Profile')),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.favorite,
        color: AppColors.whiteColor,
      ),
      label: 'Search',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.search,
        color: AppColors.whiteColor,
      ),
      label: 'Notifications',
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.person),
    //   label: 'Profile',
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    // int selectedIndex = 0; // Index to keep track of the selected page

    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(color: AppColors.whiteColor),
        unselectedLabelStyle: TextStyle(color: AppColors.blueColor),
        backgroundColor: AppColors.blackColor,
        fixedColor: AppColors.whiteColor,
        items: _bottomNavBarItems,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
          print('CURRENT INDEX: $value');
        },
      ),
    );
  }
}
