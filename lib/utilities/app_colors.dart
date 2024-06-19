import 'package:flutter/material.dart';

class AppColors {
  //This class is purposely for defining the colors that would be used throughout the application
  static Color blackColor =
      const Color(0xFF010101); //Color(int.parse('xff010101'));
  static Color blueColor = const Color(0xFF00ccff);
  static Color whiteColor = const Color(0xFFffffff);
  static Color bottomNavColor = const Color(0xff031419);
  static Color txtFieldBgColor = const Color(0xff454545);
  static Color redColor = const Color(0xffe84c1f);

  static customSnackBar(String errorMessage, Size deviceSize, bool isError) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.whiteColor,
      margin: EdgeInsets.only(bottom: deviceSize.height - 150),
      content: Container(
        child: Text(
          errorMessage,
          style: TextStyle(
            color: isError ? redColor : blueColor,
            fontWeight: FontWeight.bold,
            fontSize: deviceSize.width * 0.04,
          ),
        ),
      ),
    );
  }
}
