// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mcini/data/model/subscriber_model.dart';
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
  bool closeModalFlag = false;
  String subscriptionModalText = 'Please wait...';
  Map<String, dynamic> userData = {};
  late bool initialSwitchValue;

  @override
  void initState() {
    super.initState();
    // Initialize initialSwitchValue based on subscriberData
    initialSwitchValue = widget.subscriberData.isNotEmpty &&
            widget.subscriberData['subscription_status'] == 'active'
        ? true
        : false;
  }

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

    final switchToggle = Switch(
      value: initialSwitchValue,
      onChanged: (value) async {
        final subscriberData = widget.subscriberData;
        // final subscriberData = await LocalStorage.getStoredSubscriber();
        print('SSSSSSSS ===== $subscriberData');
        if (initialSwitchValue == true) {
          AppColors.showCustomModal(context, 'Unsubscription in progress...');
          Future.delayed(
            const Duration(seconds: 15),
            () async {
              final unsubscriptionResult =
                  await SubscriberModel.unsubscription();
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }

              if (unsubscriptionResult == true) {
                setState(
                  () {
                    initialSwitchValue = false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      AppColors.customSnackBar(
                        'You have successfully unsubscribed',
                        deviceSize,
                        false,
                      ),
                    );
                  },
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  AppColors.customSnackBar(
                    'Sorry, unsubscription failed',
                    deviceSize,
                    true,
                  ),
                );
              }
            },
          );
        } else if (subscriberData != null &&
            subscriberData['subscription_status'].toLowerCase() == 'inactive' &&
            initialSwitchValue == false) {
          String? planName = await AppColors.showsubscriptionPlanModal(context);
          if (planName != null) {
            print('SUBSCRIPTION PLAN: $planName');
            AppColors.showCustomModal(
              context,
              'Please wait...',
              isDismissible: false,
              isProcessing: true,
            );
            bool subscriptionCall = await SubscriberModel.initiateSubscription(
              subscriberData['msisdn'],
              planName,
            );
            //CHECKING IF SUBSCRIPTION REQUEST HAS BEEN SENT SUCCESSFULLY
            if (subscriptionCall == true) {
              Navigator.of(context).pop();

              subscriptionCall = false;
              AppColors.showCustomModal(
                context,
                'Approve the momo prompt to continue',
                isDismissible: false,
                isProcessing: true,
              );
              Future.delayed(
                const Duration(seconds: 10),
                () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                    AppColors.showCustomModal(
                      context,
                      'Confirming subscription...',
                      isDismissible: false,
                      isProcessing: true,
                    );
                  }
                },
              );
              Future.delayed(const Duration(seconds: 40), () async {
                final subscriptionStatus =
                    await SubscriberModel.subscriptionStatus(
                        subscriberData['msisdn']);
                Navigator.of(context).pop();

                if (subscriptionStatus.toLowerCase() == 'inactive') {
                  setState(() {
                    initialSwitchValue = true;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    AppColors.customSnackBar(
                      'Subscription successful',
                      deviceSize,
                      false,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    AppColors.customSnackBar(
                      'Subscription failed',
                      deviceSize,
                      true,
                    ),
                  );
                }
              });
            } else {
              print('FAILED TO CHANGE INITIAL SWITCH VALUE');
              setState(() {
                initialSwitchValue = false;
              });
            }
          }
          print('NETWORK PREFIX: ${subscriberData['msisdn'].substring(3, 5)}');
        } else {
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
                              builder: (context) => SubscriptionDetailsPage(
                                subscriptionData: widget.subscriberData,
                              ),
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
