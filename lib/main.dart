import 'package:flutter/material.dart';
import 'theme.dart';

void main(){
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatListScreen(),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
    );
  }
}

class Message {
  final String content;
  final DateTime date; 
  const Message({required this.content, required this.date});
}

class Chat {
  final String title;
  final String imageURL;
  final Message lastMessage;
  final int unreadMessages;
  const Chat({
    required this.title,
    required this.imageURL,
    required this.lastMessage,
    required this.unreadMessages
  });
} 

class ChatCard extends StatelessWidget {
  final Chat chatInfo;
  final bool isDivider;
  const ChatCard({
    super.key,
    required this.chatInfo,
    this.isDivider = true,
  });
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      children: [
        SizedBox(
          height: 80,
          child: InkWell(
            onTap: () {},
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              color: theme.colorScheme.onInverseSurface.withValues(alpha: 0.125),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          chatInfo.imageURL,
                          fit: BoxFit.cover,
                        ),
                      )
                    ),
                    Column(
                      children: [
                        Text(chatInfo.title),
                        Text(
                          chatInfo.lastMessage.content,
                          style: TextStyle(color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5))
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "${chatInfo.lastMessage.date.hour < 10 ? 0 : ""}${chatInfo.lastMessage.date.hour}:${chatInfo.lastMessage.date.minute < 10 ? 0 : ""}${chatInfo.lastMessage.date.minute}",
                          style: TextStyle(color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.75))
                        ),
                        SizedBox(height: 4),
                        if (chatInfo.unreadMessages > 0) ...[
                          Card(
                            shape: CircleBorder(),
                            child: Padding(
                              padding: EdgeInsets.all(6),
                              child: Text(
                                chatInfo.unreadMessages.toString(),
                                style: theme.textTheme.labelLarge
                              )
                            )
                          ),
                        ]
                      ],
                    ),
                  ],
                )
              ) 
            )
          )
        )
      ],
    );
  }
}

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Chat> chats = [
      Chat(
        title: 'Алексей Петров',
        imageURL: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBI3CB1cSPBf6LB9BfrwlmQwPoi5axSE6mCwmGhIJFXg&s',
        lastMessage: Message(
          content: 'Окей, завтра в 10 утра',
          date: DateTime(2026, 3, 28, 9, 41),
        ),
        unreadMessages: 2,
      ),
      Chat(
        title: 'Команда проекта',
        imageURL: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPFRl-Ce_UH9hepVEvUj3Xd3LTF9ZQUc7BTw&s',
        lastMessage: Message(
          content: 'Деплой прошёл успешно 🚀',
          date: DateTime(2026, 3, 27, 18, 15),
        ),
        unreadMessages: 0,
      ),
      Chat(
        title: 'Мария',
        imageURL: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJo7n7XXByw40QwFnGILGMq2BxD55PkKl8yA&s',
        lastMessage: Message(
          content: 'Ты видел это видео?',
          date: DateTime(2026, 3, 27, 14, 3),
        ),
        unreadMessages: 5,
      ),
      Chat(
        title: 'Иван Соколов',
        imageURL: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ718nztPNJfCbDJjZG8fOkejBnBAeQw5eAUA&s',
        lastMessage: Message(
          content: 'Скинь файл когда будет готово',
          date: DateTime(2026, 3, 26, 22, 50),
        ),
        unreadMessages: 0,
      ),
      Chat(
        title: 'Дизайн-группа',
        imageURL: 'https://www.thedesigngroup.com/wp-content/uploads/2024/06/DG-UK-Group.jpg',
        lastMessage: Message(
          content: 'Новые макеты уже в Figma',
          date: DateTime(2026, 3, 26, 11, 30),
        ),
        unreadMessages: 12,
      ),
    ];
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your chats'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          return ChatCard(chatInfo: chats[index]);
        }
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
    );
  }
}