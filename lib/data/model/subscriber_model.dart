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
      // print('ERROR RESPONSE DATA: ${e.toString()}');
      return {
        'response_status': 'failed',
        'response_message': e.toString(),
      };
    }
  }

  static String networkType(String msisdn) {
    List<String> mtnPrefixes = ['024', '025', '054', '055'];
    List<String> atPrefixes = ['026', '027', '056', '057'];

    String network = '';
    String prefix = msisdn.substring(3, 5);

    if (mtnPrefixes.contains('0$prefix')) {
      network = 'mtn';
    } else if (atPrefixes.contains('0$prefix')) {
      network = 'at';
    } else {
      network = '';
    }
    return network;
  }

  static Future<bool> subscriptionPlanId(
      String msisdn, String subscription_plan_name) async {
    Map<String, dynamic> subscriptionPlans = {
      "mtn_daily": "hjjh",
      "mtn_weekly": "hjjh",
      "at_daily": "hjjh",
      "at_weekly": "hjjh",
    };

    String main_subscription_plan_id = '';
    String main_subscription_plan_type = subscription_plan_name.toLowerCase();
    bool susbcriptionApiResult = false;

    String plan = '';

    String network = networkType(msisdn).toLowerCase();

    if (network != '') {
      main_subscription_plan_id =
          subscriptionPlans['${network}_${main_subscription_plan_type}'];
      if (network == 'mtn' && main_subscription_plan_type == 'daily') {
        mtnSubscription(msisdn, true);
      } else if (network == 'mtn' && main_subscription_plan_type == 'weekly') {
        mtnSubscription(msisdn, false);
      } else if (network == 'at' && main_subscription_plan_type == 'daily') {
        atSubscription(msisdn, true);
      } else if (network == 'at' && main_subscription_plan_type == 'weekly') {
        atSubscription(msisdn, false);
      } else {}
    }

    return susbcriptionApiResult;
  }

  static mtnSubscription(String msisdn, bool isDailyPlan) async {
    String baseURL = IRepository.apiBaseURL;
    String endpoint = '';
    // final data =
    // final requestBody = {
    //   'msisdn': '',
    //   'network': '',
    //   'plan_id': '',
    // };
    // final data = await http.get(Uri.parse('$baseURL/$endpoint'));
    return true;
  }

  static atSubscription(String msisdn, bool isDailyPlan) async {
    String baseURL = IRepository.apiBaseURL;
    String endpoint = '';
    // final data =
    // final requestBody = {
    //   'msisdn': '',
    //   'network': '',
    //   'plan_id': '',
    // };
    // final data = await http.get(Uri.parse('$baseURL/$endpoint'));
    return true;
  }
}
