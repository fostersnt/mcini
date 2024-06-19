// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mcini/data/model/subscriber_model.dart';

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
        title: const Text('Profile'),
      ),
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
