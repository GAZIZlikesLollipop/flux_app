import 'dart:io';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flux_app/core/database/app_database.dart';
import 'package:flux_app/core/database/drift_provider.dart';
import 'package:flux_app/features/chat/data/api_models.dart';
import 'package:flux_app/features/chat/data/websocket_provider.dart';
import 'package:flux_app/features/chat/pressentation/pages/chats_page.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  const ChatScreen({
    super.key,
    required this.chatId
  });
  @override
  State<StatefulWidget> createState() =>  ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final TextTheme textStyle = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return StreamBuilder(
      stream: context.read<DriftProvider>().getChatChan(widget.chatId),
      builder:(context, snapshot) {
        final Chat chatInfo = snapshot.data!;
        return Padding(
          padding: EdgeInsetsGeometry.directional(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
              leading: IconButton(
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (_) => ChatListScreen()));
                },
                icon: Icon(Icons.arrow_back)
              ),
              title: Row(
                children: [
                  SizedBox(
                    height: 36,
                    width: 36,
                    child:
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        File(chatInfo.avatarPath),
                        fit: BoxFit.cover,
                      ),
                    )
                  ),
                  SizedBox(width: 16),
                  Column(
                    children: [
                      Text(
                        chatInfo.title,
                        style: textStyle.bodyLarge
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: colorScheme.onSurface.withValues(alpha: 0.7)
                          ),
                          SizedBox(width: 4,),
                          Text(
                            "${DateTime.now().difference(chatInfo.lastOnline).inMinutes}",
                            style: textStyle.titleMedium?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.7))
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.call_outlined)
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_vert)
                ),
              ],
            ),
            body: StreamBuilder(
              stream: context.read<DriftProvider>().getMsgsChan(widget.chatId),
              builder: (context, snapshot) {
                final List<Message>? messages = snapshot.data;
                return messages != null ? 
                  messages.isNotEmpty ?
                  ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (ctx,ind) {
                      return Text(messages[ind].content);
                    }
                  ) :
                  Center(child: Text('No messages yet, send the first one!')): 
                  Center(child: Text('No messages yet, send the first one!'));
              },
            ),
            bottomNavigationBar: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.emoji_emotions_outlined)
                  ),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: messageController,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        labelText: "Write a message..."
                      ),
                    )
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.attach_file)
                  ),
                  messageController.text.isNotEmpty ? ElevatedButton(
                    onPressed: () async {
                      final MessagesCompanion message = MessagesCompanion(
                        chatId: Value(widget.chatId), 
                        content: Value(messageController.text), 
                        isReaded: Value(false), 
                        createdAt: Value(DateTime.now())
                      );
                      messageController.clear();
                      final Message msg = await context.read<DriftProvider>().createMessage(message);
                      if(context.mounted) {
                        context.read<WebsocketProvider>().sendData(
                          ServerReq(
                            receiverID: chatInfo.id, 
                            data: MessageData(
                              type: ServerData.sendMessage,
                              message: msg
                            )
                          ).toJson()
                        );
                      }
                    },
                    child: Icon(Icons.send)
                  ) : IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.mic_outlined)
                  ),
                ]
              )
            ),
          )
        );
      },
    );
  }
}