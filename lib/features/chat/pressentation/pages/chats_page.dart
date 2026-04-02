import 'package:flutter/material.dart';
import 'package:flux_app/core/database/drift_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/chat_card.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final user = context.watch<DriftProider>().user;
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
      body: user != null ? ListView.builder(
        itemCount: user.chats.length,
        itemBuilder: (context, index) {
          return ChatCard(chatInfo: user.chats[index]);
        }
      ): Center(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          color: theme.colorScheme.surfaceContainer.withValues(alpha: 0.5),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text('No chats yet. Add your first one!')
          )
        )
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
    );
  }
}