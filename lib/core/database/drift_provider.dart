import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flux_app/core/database/user_model.dart';
import 'app_database.dart';
import 'package:uuid/uuid.dart';

class DriftProider extends ChangeNotifier {
  final AppDatabase db; 
  DriftProider({required this.db});
  UserDTO? _user;
  UserDTO? get user => _user; 
  Future<bool> isRegistered() async {
    return (await db.getUsers).isNotEmpty;
  }
  Future<String> createUser(
    String userName,
    String photoPath
  ) async {
    final String userId = Uuid().v4();
    final User user = User(
      id: userId,
      name: userName,
      lastOnline: DateTime.now(),
      avatarPath: photoPath,
    );
    await db.createUser(user);
    _user = UserDTO(
      id: user.id, 
      name: user.name, 
      lastOnline: user.lastOnline, 
      avatarPath: user.avatarPath, 
      chats: List.empty(growable: true)
    );
    return userId;
  }
  Future<String> loadUser() async {
    List<User> users = (await db.getUsers);
    late User userData = users[0];
    List<ChatDTO> chatsData = List.empty(growable: true);
    for(var chat in await db.getChats) {
      final List<Message> messages = await db.getChatMessages(chat.id);
      chatsData.add(
        ChatDTO(
          id: chat.id, 
          userId: chat.userId, 
          title: chat.title, 
          lastOnline: chat.lastOnline, 
          avatarPath: chat.avatarPath, 
          messages: messages
        )
      );
    }
    _user = UserDTO(
      id: userData.id, 
      name: userData.name, 
      lastOnline: userData.lastOnline, 
      avatarPath: userData.avatarPath, 
      chats: chatsData
    );
    notifyListeners();
    return userData.id;
  }
  Future<int?> createNewChat(Chat chat) async {
    int? result;
    try {
      result = await db.createChat(chat);
    } on SqliteException catch(_) {
      result = null;
    }
    return result;
  }
}