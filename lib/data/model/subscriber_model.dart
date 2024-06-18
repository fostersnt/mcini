import 'dart:convert';

class SubscriberModel {
  final int id;

  SubscriberModel({required this.id});

  factory SubscriberModel.fromJson(Map<String, dynamic> json) {
    return SubscriberModel(id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
