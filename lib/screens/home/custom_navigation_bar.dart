import 'package:flutter/material.dart';
import 'package:mcini/data/model/subscriber_model.dart';
import 'package:mcini/screens/home/home_page.dart';
import 'package:mcini/utilities/app_colors.dart';

class CustomNavigationBar extends StatefulWidget {
  final SubscriberModel subscriberModel;
  CustomNavigationBar({super.key, required this.subscriberModel});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    // Center(child: Text('Home')),
    Center(child: Text('Favorites')),
    Center(child: Text('Search')),
    Center(child: Text('Profile')),
  ];

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    double iconSize = deviceSize.width * 0.08;
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
      bottomNavigationBar: Container(
        color: AppColors.bottomNavColor,
        height: 70,
        // child: BottomNavigationBar(
        //   iconSize: deviceSize.width * 0.08,
        //   elevation: 1,
        //   backgroundColor: AppColors.bottomNavColor,
        //   onTap: (value) {
        //     setState(() {
        //       selectedIndex = value;
        //     });
        //     print('CURRENT INDEX: $value');
        //   },
        //   items: _bottomNavBarItems,
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //Home icon
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
              },
              child: Container(
                child: Icon(
                  Icons.home_filled,
                  color: selectedIndex == 0
                      ? AppColors.blueColor
                      : AppColors.whiteColor,
                  size: iconSize,
                ),
              ),
            ),
            //Favorite icon
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
              },
              child: Container(
                child: Icon(
                  Icons.favorite,
                  color: selectedIndex == 1
                      ? AppColors.blueColor
                      : AppColors.whiteColor,
                  size: iconSize,
                ),
              ),
            ),
            //Search icon
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = 2;
                });
              },
              child: Container(
                child: Icon(
                  Icons.search_outlined,
                  color: selectedIndex == 2
                      ? AppColors.blueColor
                      : AppColors.whiteColor,
                  size: iconSize,
                ),
              ),
            ),
            //Profile icon
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = 3;
                });
              },
              child: Container(
                child: Icon(
                  Icons.person,
                  color: selectedIndex == 3
                      ? AppColors.blueColor
                      : AppColors.whiteColor,
                  size: iconSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
