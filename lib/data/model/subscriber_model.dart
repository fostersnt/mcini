import 'dart:convert';

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
}
