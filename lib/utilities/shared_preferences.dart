import 'dart:convert';

import 'package:mcini/data/model/subscriber_model.dart';
import 'package:mcini/utilities/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

sealed class LocalStorage {
  static Future<bool> storeSubscriberLocally(
      Map<String, dynamic> subscriber) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String subscriberJson = jsonEncode(subscriber);
      await prefs.setString('subscriberData', subscriberJson);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<Map<String, dynamic>?> getStoredSubscriber() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? subscriberJson = prefs.getString('subscriberData');
      if (subscriberJson != null) {
        Map<String, dynamic> jsonMap = jsonDecode(subscriberJson);
        // return SubscriberModel.fromJson(jsonMap);
        return jsonMap;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<bool> updateStoredSubscriber(String status) async {
    bool result = false;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? subscriberJson = prefs.getString('subscriberData');
      if (subscriberJson != null) {
        Map<String, dynamic> jsonMap = jsonDecode(subscriberJson);
        // return SubscriberModel.fromJson(jsonMap);
        jsonMap['subscription_status'] = status;
        result = true;
      } else {
        result = false;
      }
    } catch (e) {
      result = false;
    }
    return result;
  }
}
