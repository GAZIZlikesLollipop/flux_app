import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flux_app/core/database/user_model.dart';

abstract class RequestData{
  final String type;
  RequestData({required this.type});
}

class NewChatData extends RequestData {
  final ChatDTO chat;
  NewChatData({required super.type,required this.chat});
}

class Request {
  final String receiverID;
  final RequestData data;
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

class ServerException implements Exception {
  final String message;
  ServerException({required this.message});
}

sealed class ConnectionError {}
class NetworkError extends ConnectionError {}
class ServerError extends ConnectionError {
  final String message;
  ServerError({required this.message});
}