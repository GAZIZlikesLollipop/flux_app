import 'package:flutter/material.dart';
import 'package:flux_app/core/database/user_model.dart';
import '../../../core/database/app_database.dart';
import 'package:uuid/uuid.dart';

class DriftProider extends ChangeNotifier {
  final AppDatabase db; 
  DriftProider({required this.db}){
    loadUser();
  }
  UserDTO? _user;
  UserDTO? get user => _user; 
  void loadUser() async {
    final User temp = 
      User(
        id: Uuid().v4(),
        name: 'fine',
        lastOnline: DateTime.now(),
        avatarPath: "https://images.unsplash.com/photo-1481349518771-20055b2a7b24?fm=jpg&q=60&w=3000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fHJhbmRvbXxlbnwwfHwwfHx8MA%3D%3D",
      );
    print(await db.createUser(temp));
    final user = await db.getUser;
    print(await db.createChatMessages(user.id));
    List<ChatDTO> chatsData = List.empty();
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
      id: user.id, 
      name: user.name, 
      lastOnline: user.lastOnline, 
      avatarPath: user.avatarPath, 
      chats: chatsData
    );
    notifyListeners();
  }
}