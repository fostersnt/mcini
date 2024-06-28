import 'dart:convert';

import 'package:intl/intl.dart';
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

  static Future<bool> updateStoredSubscriber(Map<String, dynamic> data) async {
    bool result = false;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? subscriberJson = prefs.getString('subscriberData');
      if (subscriberJson != null) {
        Map<String, dynamic> jsonMap = jsonDecode(subscriberJson);
        // return SubscriberModel.fromJson(jsonMap);
        jsonMap['subscription_status'] = data[''];
        jsonMap['plan_id'] = data['plan_id'];
        jsonMap['network'] = data['network'];
        jsonMap['created_at'] = data['created_at'];
        jsonMap['updated_at'] = data['updated_at'];
        jsonMap['subscription_id'] = data['subscription_id'];
        jsonMap['plan_type'] = data['plan_type'];
        jsonMap['next_billing_date'] = data['next_billing_date'];
        result = true;
      } else {
        result = false;
      }
    } catch (e) {
      result = false;
    }
    return result;
  }

  static String formatDateString(String dateString) {
    // Parse the input date string
    try {
      DateTime dateTime = DateTime.parse(dateString);

      // Create a DateFormat instance for the desired output format
      DateFormat formatter = DateFormat('d MMMM y hh:mma');

      // Format the DateTime object using the formatter
      String formattedDate = formatter.format(dateTime);

      // Adjust the ordinal for the day of the month (1st, 2nd, 3rd, etc.)
      String dayWithOrdinal = _addOrdinalSuffix(dateTime.day);

      // Replace the day in the formatted string
      formattedDate =
          formattedDate.replaceFirstMapped('d', (match) => dayWithOrdinal);

      return formattedDate;
    } catch (e) {
      return 'N/A';
    }
  }

// Function to add ordinal suffix to day (1st, 2nd, 3rd, 4th, etc.)
  static String _addOrdinalSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return '${day}th';
    }
    switch (day % 10) {
      case 1:
        return '${day}st';
      case 2:
        return '${day}nd';
      case 3:
        return '${day}rd';
      default:
        return '${day}th';
    }
  }
}
