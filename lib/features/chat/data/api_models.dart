import 'dart:convert';
import 'package:flutter/foundation.dart';

class Request {
  final String receiverID;
  final Uint8List data;
  const Request({
    required this.receiverID,
    required this.data
  });
  String toJson() {
    return jsonEncode({'receiver_id': receiverID,'data': data});
  }
}

class Response {
  final String senderID;
  final Uint8List data;
  const Response({
    required this.senderID,
    required this.data
  });
  Response.fromJson(Map<String, dynamic> json)
  : senderID = json['sender_id'] as String,
    data = json['data'] as Uint8List;
}