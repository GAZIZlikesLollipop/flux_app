import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flux_app/features/chat/data/api_models.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketProvider extends ChangeNotifier {
  WebsocketProvider();
  WebSocketChannel? channel;  
  ConnectionError? _newChatError;
  bool _isClicked = false;
  bool get isClicked => _isClicked;
  void changeClicked(bool data){
    _isClicked = data;
    notifyListeners(); 
  }
  ConnectionError? get newChatError => _newChatError;
  void changeNewChatError(ConnectionError? cnnErr) {
    _newChatError = cnnErr;
    notifyListeners();
  }

  void initChannel(
    String userId,
    Function(dynamic data) callback
  ) async {
    channel = IOWebSocketChannel.connect(
      Uri.parse(const String.fromEnvironment('BASE_URL',defaultValue: 'ws://127.0.0.1:8080')),
      headers: { 'User-Id': userId }
    );
    await channel!.ready;
    channel!.stream.listen( (dt) => callback(dt) );
    notifyListeners();
  }

  void sendData(String data) async {
    try {
      await channel?.ready;
      channel!.sink.add(data);
    } on WebSocketChannelException catch(_) {
      _newChatError = NetworkError();
    } on SocketException catch(_) {
      _newChatError = NetworkError();
    }
    notifyListeners();
  }

}