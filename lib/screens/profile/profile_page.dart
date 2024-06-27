// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mcini/screens/login/login_page.dart';

import 'package:mcini/screens/profile/profile_partials.dart';
import 'package:mcini/screens/profile/subscription_details_page.dart';
import 'package:mcini/utilities/app_colors.dart';
import 'package:mcini/utilities/shared_preferences.dart';

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
  bool initialSwitchValue = false;
  bool closeModalFlag = false;
  String subscriptionModalText = 'Please wait...';

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

    // switchFunction(bool newValue) {
    //   setState(() {
    //     initialSwitchValue = !newValue;
    //   });
    //   print('THE SWITCH BUTTON HAS BEEN CLICKED: $initialSwitchValue');
    // }

    final switchToggle = Switch(
      value: initialSwitchValue,
      onChanged: (value) async {
        final subscriberData = await LocalStorage.getStoredSubscriber();
        if (subscriberData != null &&
            subscriberData['subscription_status'].toLowerCase() == 'inactive') {
          String? result = await AppColors.showsubscriptionPlanModal(context);
          if (result != null) {
            print('SUBSCRIPTION PLAN: $result');
            AppColors.showCustomModal(context, subscriptionModalText);
            setState(() {
              Future.delayed(const Duration(seconds: 3));
              closeModalFlag = true;
              initialSwitchValue = value;
            });
          }
          print('NETWORK PREFIX: ${subscriberData['msisdn'].substring(3, 5)}');
        } else {
          print("INITIAL SWITCH VALUE: $value");
          ScaffoldMessenger.of(context).showSnackBar(
            AppColors.customSnackBar(
                'You have no active subscription', deviceSize, true),
          );
        }
      },
      // activeColor: AppColors.blueColor,
      trackColor: initialSwitchValue
          ? MaterialStateProperty.all(AppColors.blueColor)
          : MaterialStateProperty.all(AppColors.switchOffColor),
      // trackOutlineColor: MaterialStateProperty.all(AppColors.blueColor),
      thumbColor: MaterialStateProperty.all(AppColors.whiteColor),
      // trackOutlineWidth: MaterialStateProperty.all(1),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.miniBlueColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Account Management',
          style: TextStyle(
            color: AppColors.blueColor,
          ),
        ),
      ),
      backgroundColor: AppColors.miniBlueColor,
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
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
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
                            caretIcon, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SubscriptionDetailsPage(),
                            ),
                          );
                        }),
                        ProfilePartials.subscriptionWidget(
                            deviceSize,
                            'Subscription',
                            unSubscriptionIcon,
                            switchToggle,
                            () => null),
                        ProfilePartials.subscriptionWidget(
                            deviceSize,
                            'Watch History',
                            watchHistoryIcon,
                            caretIcon,
                            () => null),
                      ],
                    ),
                  ),
                ),
                //LOGOUT SECTION
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: InkWell(
                    onTap: () {
                      print('YOU HAVE LOGGED OUT SUCCESSFULLY');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 40, 10, 20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: AppColors.blueColor,
                            size: 30,
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 10),
                          // child:
                          Text(
                            'Sign out',
                            style: TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: myFontSize),
                          ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
