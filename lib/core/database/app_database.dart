import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
import 'user_model.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Users, Chats, Messages])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  Future<User> get getUser => select(users).getSingle(); 
  Future<List<Chat>> get getChats => select(chats).get(); 
  Future<List<Message>> getChatMessages(String chatId) => (select(messages)..where((tbl) => tbl.chatId.equals(chatId))).get(); 
  Future<int> createUser(User user) => into(users).insert(user);
  Future<int> createChatMessages(String userId) async {
    final chatId = Uuid().v4();
    Message message = Message(
      id: 0, 
      chatId: chatId, 
      content: 'Hello!', 
      isReaded: false, 
      createdAt: DateTime.now()
    );
    Chat chat = Chat(
      id: chatId, 
      userId: userId, 
      title: 'first', 
      lastOnline: DateTime.now().subtract(Duration(minutes: 30)), 
      avatarPath: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6nWrDmTZ5-h_wOryw8-CnXnOjuitgTOaHFg&s', 
    );
    await into(chats).insert(chat);
    return into(messages).insert(message);
  }
  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'chat_db.sqlite'));
    return NativeDatabase(file);
  });
}