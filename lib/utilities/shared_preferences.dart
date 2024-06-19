import 'dart:convert';

import 'package:mcini/data/model/subscriber_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

sealed class LocalStorage {
  static Future<bool> storeSubscriberLocally(SubscriberModel subscriber) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String subscriberJson = jsonEncode(subscriber.toJson());
      await prefs.setString('subscriberData', subscriberJson);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<SubscriberModel?> getStoredSubscriber() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? subscriberJson = prefs.getString('subscriberData');
      if (subscriberJson != null) {
        Map<String, dynamic> jsonMap = jsonDecode(subscriberJson);
        return SubscriberModel.fromJson(jsonMap);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
