import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mcini/utilities/app_colors.dart';

class ProfilePartials {
  static Widget secttion(
      Size screenSize, String label, String labelValue, Icon myIcon) {
    final double myFontSize = screenSize.width * 0.05;
    const double myIconSize = 25.0;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //PHONE NUMBER SECTION
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              label,
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: myFontSize,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            color: AppColors.greySub,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                myIcon,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      labelValue,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: myFontSize,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
