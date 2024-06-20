// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mcini/screens/profile/profile_partials.dart';
import 'package:mcini/utilities/app_colors.dart';

class ProfilePage extends StatefulWidget {
  final Map<String, dynamic> subscriberData;
  const ProfilePage({
    super.key,
    required this.subscriberData,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    final double myFontSize = deviceSize.width * 0.05;
    const double iconSize = 25.0;

//PHONE ICON
    final Icon phoneIcon = Icon(
      Icons.phone_outlined,
      color: AppColors.whiteColor,
      size: iconSize,
    );

    //EMAIL ICON
    final Icon emailIcon = Icon(
      Icons.email_outlined,
      color: AppColors.whiteColor,
      size: iconSize,
    );

    //PHONE ICON
    final Icon thumbIcon = Icon(
      Icons.thumb_up_outlined,
      color: AppColors.whiteColor,
      size: iconSize,
    );

    final caretIcon = Icon(
      Icons.arrow_forward_ios_rounded,
      color: AppColors.blueColor,
      size: iconSize,
    );

    final subscriptionIcon = Icon(
      Icons.lock_outline,
      color: AppColors.whiteColor,
      size: iconSize,
    );

    final unSubscriptionIcon = Icon(
      Icons.toggle_on_outlined,
      color: AppColors.whiteColor,
      size: iconSize,
    );

    final watchHistoryIcon = Icon(
      Icons.paste_sharp,
      color: AppColors.whiteColor,
      size: iconSize,
    );

    bool initialSwitchValue = false;

    switchFunction() {
      setState(() {
        initialSwitchValue = !initialSwitchValue;
      });
      print('THE SWITCH BUTTON HAS BEEN CLICKED');
    }

    final switchToggle = Switch(
      value: initialSwitchValue,
      onChanged: switchFunction(),
      // activeColor: AppColors.blueColor,
      thumbColor: initialSwitchValue
          ? MaterialStateProperty.all(AppColors.blueColor)
          : MaterialStateProperty.all(AppColors.whiteColor),
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
      body: SizedBox(
        width: deviceSize.width,
        height: deviceSize.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //ABOUT SECTION
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'About',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: myFontSize,
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: AppColors.greyMain,
                    width: deviceSize.width,
                    // height: deviceSize.height * 0.35,
                    child: Column(
                      children: [
                        ProfilePartials.secttion(deviceSize, 'Full Name',
                            widget.subscriberData['name'] ?? 'N/A', thumbIcon),
                        ProfilePartials.secttion(
                            deviceSize,
                            'Phone Number',
                            widget.subscriberData['msisdn'] ?? 'N/A',
                            phoneIcon),
                        ProfilePartials.secttion(deviceSize, 'E-Mail',
                            widget.subscriberData['email'] ?? 'N/A', emailIcon),
                      ],
                    ),
                  ),
                ),
                //SUBSCRIPTIONS SECTION
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: Text(
                    'Subscriptions',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: myFontSize,
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: AppColors.greyMain,
                    width: deviceSize.width,
                    // height: deviceSize.height * 0.35,
                    child: Column(
                      children: [
                        ProfilePartials.subscriptionWidget(
                            deviceSize,
                            'Subscription status',
                            subscriptionIcon,
                            caretIcon,
                            switchFunction),
                        ProfilePartials.subscriptionWidget(
                            deviceSize,
                            'Unsubscription',
                            unSubscriptionIcon,
                            switchToggle,
                            switchFunction),
                        ProfilePartials.subscriptionWidget(
                            deviceSize,
                            'Watch History',
                            watchHistoryIcon,
                            caretIcon,
                            switchFunction),
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