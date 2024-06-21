import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mcini/utilities/app_colors.dart';

class SubscriptionDetailsPage extends StatelessWidget {
  const SubscriptionDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    final double defaultFontSize = deviceSize.width * 0.04;
    //SUBSCRIPTION PLAN ICON
    final Icon subscriptionPlanIcon = Icon(
      Icons.lock_outline,
      color: AppColors.whiteColor,
    );

    //SUBSCRIPTION PLAN ICON
    final Icon changeSubscriptionIcon = Icon(
      Icons.edit_outlined,
      color: AppColors.blueColor,
    );

    //DIVIDER
    final Padding customDivider = Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Divider(
        color: AppColors.greySub,
        thickness: 2,
      ),
    );

    const SizedBox customSizedBox = SizedBox(
      width: 20,
    );

    final Icon statusLeftWidget = Icon(
      Icons.circle_outlined,
      color: AppColors.whiteColor,
    );
    final ClipRRect statusRightWidget = ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: AppColors.blueColor,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          'Active',
          style: TextStyle(color: AppColors.whiteColor),
        ),
      ),
    );

    final Icon expiryDateLeftWidget = Icon(
      Icons.calendar_month,
      color: AppColors.whiteColor,
    );

    final Text expiryDateRightWidget = Text(
      '14/08/2024',
      style: TextStyle(color: AppColors.whiteColor),
    );

    return Scaffold(
      backgroundColor: AppColors.miniBlueColor,
      appBar: AppBar(
        backgroundColor: AppColors.miniBlueColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
          ),
        ),
        title: Text(
          'Subscription Status',
          style: TextStyle(
            color: AppColors.blueColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //SUBSCRIPTION PLAN STARTS
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          subscriptionPlanIcon,
                          customSizedBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Subscription Plan',
                                style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: defaultFontSize,
                                ),
                              ),
                              Text(
                                'Daily',
                                style: TextStyle(
                                  color: AppColors.blueColor,
                                  fontSize: defaultFontSize,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          print('DO YOU WANT TO CHANGE SUBSCRIPTION PLAN?');
                        },
                        child: Row(
                          children: [
                            Text(
                              'Change',
                              style: TextStyle(
                                color: AppColors.blueColor,
                                fontSize: defaultFontSize,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            changeSubscriptionIcon,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //SUBSCRIPTION PLAN ENDS HERE
                //DIVIDER
                customDivider,
                customRowWidget(statusLeftWidget, 'Status', statusRightWidget),
                customDivider,
                customRowWidget(
                    expiryDateLeftWidget, 'Expiry Date', expiryDateRightWidget),
                customDivider,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customRowWidget(Widget leftWidget, String label, Widget rightWidget) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                leftWidget,
                const SizedBox(
                  width: 20,
                ),
                Text(
                  'Status',
                  style: TextStyle(color: AppColors.whiteColor),
                ),
              ],
            ),
            rightWidget,
          ],
        ),
      ),
    );
  }
}
