// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mcini/data/model/subscriber_model.dart';
import 'package:mcini/utilities/app_colors.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> subscriberModel;
  const ProfilePage({
    super.key,
    required this.subscriberModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: InkWell(
        //   onTap: () {
        //     Navigator.of(context).pop();
        //   },
        //   child: Icon(
        //     Icons.arrow_back,
        //     color: AppColors.whiteColor,
        //   ),
        // ),
        backgroundColor: AppColors.blackColor,
        // automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Account Management',
          style: TextStyle(
            color: AppColors.blueColor,
          ),
        ),
      ),
      backgroundColor: AppColors.blackColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(subscriberModel['msisdn']),
          ),
        ],
      ),
    );
  }
}
