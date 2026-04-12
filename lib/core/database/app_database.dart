import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'user_model.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Users, Chats, Messages])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  Stream<List<Chat>> get chatsChan => select(chats).watch();
  Stream<Chat> chatChan(String chatId) => (select(chats)..where((tbl) => tbl.id.equals(chatId))).watchSingle();
  Stream<List<Message>> msgsChan(String chatId) => (select(messages)..where((tbl) => tbl.chatId.equals(chatId))..orderBy([(t) => OrderingTerm.asc(t.createdAt)])).watch();

  Future<List<User>> get getUsers => select(users).get(); 
  Future<Chat?> chatByID(String chatId) => (select(chats)..where((tbl) => tbl.id.equals(chatId))).getSingleOrNull();

  Future<int> createUser(User user) => into(users).insert(user);
  Future<int> createChat(Chat chat) => into(chats).insert(chat);
  Future<Message> createMessage(MessagesCompanion msg) async {
    await (update(chats)..where((tbl) => tbl.id.equals(msg.chatId.value)))
    .write(ChatsCompanion(
      lastMessageContent: msg.content,
      lastMessageCreatedAt: msg.createdAt,
      lastMessageIsReaded: msg.isReaded,
    ));
    final int msgId = await into(messages).insert(msg);
    return (select(messages)..where((tbl) => tbl.id.equals(msgId))).getSingle();
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