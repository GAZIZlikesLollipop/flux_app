
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketProvider extends ChangeNotifier {
  WebsocketProvider();
  WebSocketChannel? channel;  
  void initChannel(String userId) {
    channel = IOWebSocketChannel.connect(
      Uri.parse(String.fromEnvironment('BASE_URL',defaultValue: 'ws://localhost:8080')),
      headers: { 'User-Id': userId }
    );
  }
  Future<bool> sendData(String data) async {
    await channel?.ready;
    channel?.sink.add(data);
    return false;
  }
}