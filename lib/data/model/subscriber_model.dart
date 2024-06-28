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

  static Future<bool> initiateSubscription(
      String msisdn, String subscriptionPlanName) async {
    String mainSubscriptionPlanType = subscriptionPlanName.toLowerCase();

    bool susbcriptionApiResult = false;

    String plan = '';

    String network = networkType(msisdn).toLowerCase();

    if (network != '') {
      if (network == 'mtn' &&
          (mainSubscriptionPlanType == 'daily' ||
              mainSubscriptionPlanType == 'weekly')) {
        susbcriptionApiResult =
            await mtnSubscription(msisdn, isDailyPlan: true);
      } else if (network == 'at' &&
          (mainSubscriptionPlanType == 'daily' ||
              mainSubscriptionPlanType == 'weekly')) {
        susbcriptionApiResult = await atSubscription(msisdn, true);
      } else {
        susbcriptionApiResult = false;
      }
    }

    return susbcriptionApiResult;
  }

  static Future<bool> mtnSubscription(String msisdn,
      {bool isDailyPlan = true}) async {
    String dailyPlanId = '9915310034';
    String weeklyPlanId = '9915310035';
    bool finalResult = false;

    String baseURL = IRepository.apiBaseURL;
    String endpoint = 'mtn/subscription';
    Map<String, dynamic> requestBody = {
      'msisdn': msisdn,
      'network': 'MTN',
      'plan_id': dailyPlanId,
    };
    if (!isDailyPlan) {
      requestBody = {
        'msisdn': msisdn,
        'network': 'MTN',
        'plan_id': weeklyPlanId,
      };
    }
    try {
      final response =
          await http.post(Uri.parse('$baseURL/$endpoint'), body: requestBody);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == 'true') {
          final mainData = jsonResponse['data'];
          finalResult = true;
          print('SUBSCRIPTION DATA FROM API: $mainData');
        } else {
          finalResult = false;
          print('SUBSCRIPTION REQUEST FAILED');
        }
      } else {
        finalResult = false;
        print('FAILED TO REACH SUBSCRIPTION API ==== ${response.statusCode}');
      }
    } catch (e) {
      finalResult = false;
      print('SUBSCRIPTION REQUEST ERROR: ${e.toString()}');
    }
    return finalResult;
  }

  static Future<bool> atSubscription(String msisdn, bool isDailyPlan) async {
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

  static Future<Map<String, dynamic>> subscriptionCallBack(msisdn) async {
    final requestBody = {'msisdn': msisdn};
    return {'': ''};
  }

  static Future<String> subscriptionStatus(String msisdn) async {
    const String baseUrl = IRepository.apiBaseURL;
    const String endpoint = 'movies/subscriptions';
    final Map<String, dynamic> requestBody = {'msisdn': msisdn};
    String status = '';
    try {
      final response =
          await http.post(Uri.parse('$baseUrl/$endpoint'), body: requestBody);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final Map<String, dynamic> mainData = jsonResponse['data'];
        if (mainData.isNotEmpty) {
          status = mainData['subscription_status'];
          await LocalStorage.updateStoredSubscriber(mainData);
        }
        print('SUBSCRIPTION STATUS HAS BEEN UPDATED IN LOCAL STORAGE');
      }
    } catch (e) {
      print('ATTEMPT TO GET SUBSCRIPTION STATUS === ${e.toString()}');
    }
    return status;
  }

  static Future<bool> unsubscription() async {
    String baseUrl = IRepository.apiBaseURL;
    String endpoint = '';
    bool result = false;
    String outcome = '';
    final storageData = await LocalStorage.getStoredSubscriber();

    try {
      Map<String, dynamic> requestBody = {
        'plan_id': '',
        'msisdn': '',
        'network': '',
      };

      if (storageData != null && storageData['network'] == 'MTN') {
        requestBody['plan_id'] = storageData['plan_id'].toString();
        requestBody['msisdn'] = storageData['msisdn'].toString();
        requestBody['network'] = storageData['network'].toString();
        endpoint = 'mtn/unsubscription';
      }
      if (storageData != null && storageData['network'] == 'AT') {
        requestBody['product_id'] = storageData['product_id'].toString();
        requestBody['msisdn'] = storageData['msisdn'].toString();
        requestBody['network'] = storageData['network'].toString();
        endpoint = 'at/unsubscribe';
      }
      final response = await http.post(
        Uri.parse('$baseUrl/$endpoint'),
        body: requestBody,
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        if (jsonData['success'] == 'true') {
          await LocalStorage.updateStoredSubscriber(jsonData);
          result = true;
          outcome = '==== SUCCESSFUL ====';
        }
        outcome = '==== API success returned FALSE ====';
        print('API RESPONSE DATA: === $jsonData');
      } else {
        outcome = '==== FAILED WITH STATUS CODE: ${response.statusCode} ====';
      }
    } catch (e) {
      // print('UNSCRIPTION ERROR ==== ${e.toString()}');
      outcome = '==== ERROR: ${e.toString()} ====';
    }
    print(outcome);
    return result;
  }
}
