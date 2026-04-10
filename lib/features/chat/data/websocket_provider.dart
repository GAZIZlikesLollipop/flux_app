
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flux_app/features/chat/data/api_models.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketProvider extends ChangeNotifier {
  WebsocketProvider();
  WebSocketChannel? channel;  
  void initChannel(String userId) {
    channel = IOWebSocketChannel.connect(
      Uri.parse(const String.fromEnvironment('BASE_URL',defaultValue: 'ws://127.0.0.1:8080')),
      headers: { 'User-Id': userId }
    );
  }
  Future<Exception?> sendData(
    String data,
    VoidCallback callback
  ) async {
    Exception? result;
    try {
      await channel?.ready;
      channel!.sink.add(data);
      final dynamic dt = await channel!.stream.first;
      if(dt is String) {
        result = ServerException(message: dt);
      } else {
        callback();
      }
    } on WebSocketChannelException catch(e) {
      return e;  
    } on SocketException catch(e) {
      return e;
    }
    return result;
  }
}