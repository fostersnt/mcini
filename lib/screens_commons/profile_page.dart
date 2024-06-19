// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:mcini/data/model/subscriber_model.dart';
import 'package:mcini/screens_commons/profile_partials.dart';
import 'package:mcini/utilities/app_colors.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> subscriberData;
  const ProfilePage({
    super.key,
    required this.subscriberData,
  });

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    final double myFontSize = deviceSize.width * 0.05;
    const double iconSize = 25.0;

//PHONE ICON
    final Icon phoneIcon = Icon(
      Icons.phone,
      color: AppColors.whiteColor,
      size: iconSize,
    );

    //EMAIL ICON
    final Icon emailIcon = Icon(
      Icons.email,
      color: AppColors.whiteColor,
      size: iconSize,
    );

    //PHONE ICON
    final Icon thumbIcon = Icon(
      Icons.thumb_up,
      color: AppColors.whiteColor,
      size: iconSize,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Account Management',
          style: TextStyle(
            color: AppColors.blueColor,
          ),
        ),
      ),
      backgroundColor: AppColors.blackColor,
      body: Container(
        width: deviceSize.width,
        height: deviceSize.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: AppColors.greyMain,
                    width: deviceSize.width,
                    // height: deviceSize.height * 0.35,
                    child: Column(
                      children: [
                        ProfilePartials.secttion(deviceSize, 'Full Name',
                            subscriberData['name'] ?? 'N/A', thumbIcon),
                        ProfilePartials.secttion(deviceSize, 'Phone Number',
                            subscriberData['msisdn'], phoneIcon),
                        ProfilePartials.secttion(deviceSize, 'E-Mail',
                            subscriberData['msisdn'], emailIcon),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
