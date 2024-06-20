import 'package:flutter/material.dart';
import 'package:mcini/screens/home/home_page.dart';
import 'package:mcini/screens/profile/profile_page.dart';
import 'package:mcini/utilities/app_colors.dart';

class CustomNavigationBar extends StatefulWidget {
  final Map<String, dynamic> subscriberModel;
  const CustomNavigationBar({super.key, required this.subscriberModel});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      // const HomePage(),
      const HomeView(),
      // Center(child: Text('Home')),
      const Center(child: Text('Favorites')),
      const Center(child: Text('Search')),
      ProfilePage(subscriberData: widget.subscriberModel),
    ];

    final Size deviceSize = MediaQuery.of(context).size;
    double iconSize = deviceSize.width * 0.08;
    final List<BottomNavigationBarItem> bottomNavBarItems = [
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
      body: pages[selectedIndex],
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
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
                  child: Column(
                    children: [
                      Icon(
                        Icons.home_filled,
                        color: selectedIndex == 0
                            ? AppColors.blueColor
                            : AppColors.whiteColor,
                        size: iconSize,
                      ),
                      Text(
                        'Home',
                        style: TextStyle(
                          color: selectedIndex == 0
                              ? AppColors.blueColor
                              : AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
                  child: Column(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: selectedIndex == 1
                            ? AppColors.blueColor
                            : AppColors.whiteColor,
                        size: iconSize,
                      ),
                      Text(
                        'Favorite',
                        style: TextStyle(
                          color: selectedIndex == 1
                              ? AppColors.blueColor
                              : AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
                  child: Column(
                    children: [
                      Icon(
                        Icons.search_outlined,
                        color: selectedIndex == 2
                            ? AppColors.blueColor
                            : AppColors.whiteColor,
                        size: iconSize,
                      ),
                      Text(
                        'Search',
                        style: TextStyle(
                          color: selectedIndex == 2
                              ? AppColors.blueColor
                              : AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
                  child: Column(
                    children: [
                      Icon(
                        Icons.person,
                        color: selectedIndex == 3
                            ? AppColors.blueColor
                            : AppColors.whiteColor,
                        size: iconSize,
                      ),
                      Text(
                        'Account',
                        style: TextStyle(
                          color: selectedIndex == 3
                              ? AppColors.blueColor
                              : AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
