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

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Message')
class Messages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get chatId => text().references(Chats, #id)(); 
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
  final String id;
  final String userId;
  final String title;
  final DateTime lastOnline;
  final String avatarPath;
  final List<Message> messages;
  const ChatDTO({
    required this.id,
    required this.userId,
    required this.title,
    required this.lastOnline,
    required this.avatarPath,
    required this.messages
  });

  Message get lastMessage => 
    messages.isEmpty ? Message(
        id: 0, 
        chatId: id, 
        content: 'No messages yet', 
        isReaded: false, 
        createdAt: DateTime.now()
      ) 
      : messages[messages.length-1];

  int get unreadMessages { 
    int readed = 0;
    if(messages.isNotEmpty){
      for(final msg in messages){
        if(msg.isReaded) readed++;
      }
    }
    return readed;
  }
}