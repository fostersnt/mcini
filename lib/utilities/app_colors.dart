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
  static Color greyMain = const Color(0xff414141);
  static Color greySub = const Color(0xff4b4b4b);
  static Color switchOffColor = const Color(0xffdadada);
  static Color miniBlueColor = const Color(0xff031115);
  static Color shimmerColor = const Color(0xfff1f3f4);

  static customSnackBar(String errorMessage, Size deviceSize, bool isError) {
    //SUCCESS ICON
    final Icon successIcon = Icon(
      Icons.check_circle,
      color: blueColor,
      size: 25,
    );

//ERROR ICON
    final Icon errorIcon = Icon(
      Icons.error,
      color: redColor,
      size: 25,
    );

    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.whiteColor,
      margin: EdgeInsets.only(bottom: deviceSize.height - 150),
      content: Container(
        child: Center(
          child: Row(
            children: [
              isError ? errorIcon : successIcon,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    errorMessage,
                    style: TextStyle(
                      color: isError ? redColor : blueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: deviceSize.width * 0.04,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static bool validatePhoneNumber(String msisdn) {
    bool finalOutcome = true;
    if (msisdn.length == 12) {
      String prefix = msisdn.substring(0, 3); //233
      String mainPrefix = msisdn.substring(3, 4);
      if (prefix == '233' && mainPrefix == '2') {
        RegExp regex = RegExp(r'^2332[04567]\d{7}$');
        finalOutcome = regex.hasMatch(msisdn);
      } else if (prefix == '233' && mainPrefix == '5') {
        RegExp regex = RegExp(r'^2335[034567]\d{7}$');
        finalOutcome = regex.hasMatch(msisdn);
      } else {
        finalOutcome = false;
      }
    } else if (msisdn.length == 10) {
      String prefix = msisdn.substring(0, 1); //0
      String mainPrefix = msisdn.substring(1, 2);
      if (prefix == '0' && mainPrefix == '2') {
        RegExp regex = RegExp(r'^02[04567]\d{7}$');
        finalOutcome = regex.hasMatch(msisdn);
      } else if (prefix == '0' && mainPrefix == '5') {
        RegExp regex = RegExp(r'^05[034567]\d{7}$');
        finalOutcome = regex.hasMatch(msisdn);
      } else {
        finalOutcome = false;
      }
    } else {
      finalOutcome = false;
    }
    // RegExp regex = RegExp(r'^0[25][34567]\d{7}$');
    // msisdn.substring(0, 1);
    return finalOutcome;
  }
}
