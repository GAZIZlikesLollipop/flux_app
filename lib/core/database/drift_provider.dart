import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flux_app/core/database/user_model.dart';
import 'app_database.dart';
import 'package:uuid/uuid.dart';

class DriftProvider extends ChangeNotifier {
  final AppDatabase db; 
  UserDTO? _user;
  UserDTO? get user => _user; 
  DriftProvider({required this.db}){
    db.chatsChan.listen((dt){
      if(_user != null) {
        _user = _user!.copyWith(chats: dt);
        notifyListeners();
      }
    });
  }
  Stream<Chat> getChatChan(String chatId) => db.chatChan(chatId);
  Stream<List<Message>> getMsgsChan(String chatId) => db.msgsChan(chatId);
  Future<Message> createMessage(MessagesCompanion msg) async => await db.createMessage(msg);
  void updateUser(User userData) {
    if(_user != null) {
      _user = _user!.copyWith(
        name: userData.name,
        lastOnline: userData.lastOnline,
        avatarPath: userData.avatarPath
      );
    } else {
      _user = UserDTO(
        id: userData.id,
        name: userData.name,
        lastOnline: userData.lastOnline,
        avatarPath: userData.avatarPath,
        chats: List.empty(growable: true)
      );
    }
    notifyListeners();
  }
  Future<bool> isRegistered() async {
    List<User> users = await db.getUsers;
    if(users.isNotEmpty){
      updateUser(users[0]);
    }
    return users.isNotEmpty;
  }
  Future<String> createUser(
    String userName,
    String photoPath
  ) async {
    final String userId = Uuid().v4();
    final User userData = User(
      id: userId,
      name: userName,
      lastOnline: DateTime.now(),
      avatarPath: photoPath,
    );
    await db.createUser(userData);
    updateUser(userData);
    return userId;
  }
  Future<Chat?> getChatById(String chatId) async {
    return await db.chatByID(chatId);
  }
  Future<int?> createNewChat(Chat chat) async {
    int? result;
    try {
      result = await db.createChat(chat);
    } on SqliteException catch(_) {
      result = null;
    }
    notifyListeners();
    return result;
  }
}