import 'package:flutter/material.dart';
import 'package:mcini/utilities/app_colors.dart';

class HomePageShimmerEffect extends StatelessWidget {
  const HomePageShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            width: deviceSize.width,
            height: deviceSize.height * 0.37,
            color: AppColors.shimmerColor,
          ),
          // SizedBox(height: 20),
          ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20),
            physics:
                const NeverScrollableScrollPhysics(), // Disable scrolling for inner ListView
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildShimmerContainer(deviceSize),
                    // SizedBox(width: deviceSize.width * 0.1),
                    _buildShimmerContainer(deviceSize),
                    // SizedBox(width: deviceSize.width * 0.1),
                    // _buildShimmerContainer(deviceSize),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerContainer(Size deviceSize) {
    return Container(
      width: deviceSize.width * 0.4,
      height: (deviceSize.width * 0.4) + 10,
      color: AppColors.shimmerColor,
    );
  }

  // Widget _buildColoredContainer(Size deviceSize) {
  //   return Container(
  //     width: deviceSize.width * 0.3,
  //     height: deviceSize.width * 0.3 + 10,
  //     color:
  //         AppColors.redColor, // Example color, replace with your actual color
  //   );
  // }
}
