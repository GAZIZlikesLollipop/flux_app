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

@DataClassName('Chat')
class Chats extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().references(Users, #id)(); 
  TextColumn get title => text()();
  DateTimeColumn get lastOnline => dateTime()();
  TextColumn get avatarPath => text()();

  TextColumn get lastMessageContent => text()();
  BoolColumn get lastMessageIsReaded => boolean()();
  DateTimeColumn get lastMessageCreatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Message')
class Messages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get chatId => text().references(Chats, #id)(); 
  TextColumn get senderId => text()();
  TextColumn get content => text()();
  BoolColumn get isReaded => boolean()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class UserDTO {
  final String id;
  final String name;
  final DateTime lastOnline;
  final String avatarPath;
  final List<Chat> chats;
  const UserDTO({
    required this.id,
    required this.name,
    required this.lastOnline,
    required this.avatarPath,
    required this.chats
  });
  UserDTO copyWith({
    String? name,
    DateTime? lastOnline,
    String? avatarPath,
    List<Chat>? chats
  }) => UserDTO(
    id: id, 
    name: name ?? this.name, 
    lastOnline: lastOnline ?? this.lastOnline, 
    avatarPath: avatarPath ?? this.avatarPath, 
    chats: chats ?? this.chats
  ); 
}