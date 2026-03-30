import 'package:flutter/material.dart';
import '../widgets/chat_card.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Flux'),
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