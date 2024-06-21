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
    final Divider customDivider = Divider(
      color: AppColors.greySub,
      thickness: 2.2,
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
                          const SizedBox(
                            width: 20,
                          ),
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
                // Container(child: ,),
                // Container(child: ,),
                // Container(child: ,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
