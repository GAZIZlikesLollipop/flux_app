import 'dart:convert';
import 'package:flux_app/core/database/app_database.dart';

abstract class ServerData{
  static const String newChatReq = 'newChatReq';
  static const String newChatResp = 'newChatResp';
  final String type;
  ServerData({required this.type});
  ServerData.fromJson(Map<String,dynamic> json): type = json['type'];
  Map<String, dynamic> toJson() {
    return {'type': type};
  }
}

class NewChatData extends ServerData {
  final Chat chat;
  NewChatData({
    required super.type,
    required this.chat,
  });
  NewChatData.fromJson(super.json): chat = Chat.fromJson(json['chat'] as Map<String, dynamic>), super.fromJson();
  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'chat': chat.toJson()
    };
  }
}

class ServerReq {
  final String receiverID;
  final ServerData data;
  const ServerReq({
    required this.receiverID,
    required this.data
  });
  String toJson() {
    final Map<String,dynamic> jsonMap = {
      'receiver_id': receiverID,
      'data': utf8.encode(json.encode(data.toJson()))
    };
    return jsonEncode(jsonMap);
  }
}

class ServerResp {
  final String senderID;
  final ServerData data;
  const ServerResp({
    required this.senderID,
    required this.data
  });
  static ServerData _parseData(Map<String, dynamic> json) {
    final jsonData = jsonDecode(utf8.decode(base64.decode(json['data'] as String))) as Map<String, dynamic>;
    return switch(jsonData['type']){
      ServerData.newChatReq || ServerData.newChatResp => NewChatData.fromJson(jsonData), 
      _ => throw UnimplementedError()
    };
  }
  ServerResp.fromJson(Map<String, dynamic> json)
    : senderID = json['sender_id'] as String,
    data = _parseData(json);
}

sealed class ConnectionError {}
class NetworkError extends ConnectionError {}
class ServerError extends ConnectionError {
  final String message;
  ServerError({required this.message});
}