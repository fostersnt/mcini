import 'dart:convert';

import 'package:mcini/data/interface/i_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mcini/utilities/app_colors.dart';
import 'package:mcini/utilities/shared_preferences.dart';

class SubscriberModel {
  final int id;
  final String name;
  final String email;
  final String msisdn;
  final String subscription_status;
  final int subscription_id;

  SubscriberModel({
    required this.id,
    required this.name,
    required this.email,
    required this.msisdn,
    required this.subscription_status,
    required this.subscription_id,
  });

  factory SubscriberModel.fromJson(Map<String, dynamic> json) {
    return SubscriberModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      msisdn: json['msisdn'],
      subscription_status: json['subscription_status'],
      subscription_id: json['subscription_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'msisdn': msisdn,
      'subscription_status': subscription_status,
      'subscription_id': subscription_id,
    };
  }

  static Future<Map<String, dynamic>> getSubscriber(String msisdn) async {
    String baseUrl = IRepository.apiBaseURL;
    String endpoint = 'user/login';
    String url = "$baseUrl/$endpoint";
    bool isValidPhoneNumber = AppColors.validatePhoneNumber(msisdn);

    try {
      if (msisdn == '') {
        return {
          'response_status': 'failed',
          'response_message': 'Phone number should not be empty',
        };
      }

      if (!isValidPhoneNumber) {
        return {
          'response_status': 'failed',
          'response_message': 'Invalid phone number',
        };
      }

      final response = await http.post(
        Uri.parse(url),
        body: {'msisdn': msisdn},
      );
      final jsonData = jsonDecode(response.body);
      final subscriberData = jsonData['data'];
      //Storing the subscriber data in local storage
      await LocalStorage.storeSubscriberLocally(subscriberData);
      if (jsonData['success'] == 'true') {
        subscriberData['response_status'] = 'success';
        subscriberData['response_message'] = 'Data fetched successfully';
      } else {
        return {
          'response_status': 'failed',
          'response_message': jsonData['message']
        };
      }
      return subscriberData;
    } catch (e) {
      return {
        'response_status': 'failed',
        'response_message': e.toString(),
      };
    }
  }
}
