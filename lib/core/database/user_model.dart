import 'package:drift/drift.dart';
import 'package:flux_app/core/database/app_database.dart';

@DataClassName('User')
class Users extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  DateTimeColumn get lastOnline => dateTime()();
  TextColumn get avatarPath => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Member')
class Members extends Table {
  TextColumn get id => text()();
  IntColumn get chatId => integer().references(Chats, #id).unique()();
  TextColumn get name => text()();
  DateTimeColumn get lastOnline => dateTime()();
  TextColumn get avatarPath => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Chat')
class Chats extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().references(Users, #id)(); 
}

@DataClassName('Message')
class Messages extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get chatId => integer().references(Chats, #id)(); 
  TextColumn get content => text()();
  BoolColumn get isReaded => boolean()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class UserDTO {
  final String id;
  final String name;
  final DateTime lastOnline;
  final String avatarPath;
  final List<ChatDTO> chats;
  const UserDTO({
    required this.id,
    required this.name,
    required this.lastOnline,
    required this.avatarPath,
    required this.chats
  });
}

class ChatDTO {
  final int id;
  final int userId;
  final Member member;
  final List<Message> messages;
  const ChatDTO({
    required this.id,
    required this.userId,
    required this.messages,
    required this.member,
  });
  String get avatarPath => member.avatarPath;
  String get title => member.name;
}
