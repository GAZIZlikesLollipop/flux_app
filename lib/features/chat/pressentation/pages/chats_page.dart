import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flux_app/core/database/app_database.dart';
import 'package:flux_app/core/database/drift_provider.dart';
import 'package:flux_app/features/chat/data/api_models.dart';
import 'package:flux_app/features/chat/data/websocket_provider.dart';
import 'package:flux_app/features/chat/pressentation/pages/chat_page.dart';
import 'package:flux_app/features/chat/pressentation/widgets/new_chat_card.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/chat_card.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});
  @override
  State<ChatListScreen> createState() => ChatListState();
}

class ChatListState extends State<ChatListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      final user = context.read<DriftProvider>().user;
      if(
        user != null &&
        context.read<WebsocketProvider>().channel == null
      ){
        context.read<WebsocketProvider>().initChannel(
          user.id,
          (dt) async {
            try {
              final ServerResp resp = ServerResp.fromJson(jsonDecode(dt) as Map<String,dynamic>);
              switch(resp.data){
                case NewChatData chatData:
                  if(chatData.type == ServerData.newChatReq) {
                    context.read<WebsocketProvider>().sendData(
                      ServerReq(
                        receiverID: resp.senderID, 
                        data: NewChatData(
                          type: ServerData.newChatResp,
                          chat: Chat(
                            id: user.id, 
                            userId: resp.senderID, 
                            title: user.name, 
                            lastOnline: user.lastOnline, 
                            avatarPath: base64Encode(File(user.avatarPath).readAsBytesSync()),
                            lastMessageContent: 'No messages',
                            lastMessageCreatedAt: DateTime.now(),
                            lastMessageIsReaded: false
                          ), 
                        )
                      ).toJson(),
                    );
                  }
                  Chat newChat = chatData.chat;
                  if(await context.read<DriftProvider>().getChatById(newChat.id) == null) {
                    final dir = await getApplicationDocumentsDirectory();
                    final file = File('${dir.path}/${newChat.id}-avatar.jpg');
                    await file.writeAsBytes(base64Decode(newChat.avatarPath));
                    newChat = newChat.copyWith(avatarPath: file.path);
                    context.read<DriftProvider>().createNewChat(newChat);
                  }
                  if(
                    context.mounted && 
                    resp.data.type == ServerData.newChatResp
                  ) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(chatId: newChat.id)
                      )
                    );
                  }
                case MessageData msgData:
                  print('Poluchil!: $dt');
                  await context.read<DriftProvider>().createMessage(msgData.message.toCompanion(true));
              }
            } on FormatException catch(_) {
              context.read<WebsocketProvider>().changeNewChatError(ServerError(message: dt));
            } on TypeError catch(_) {
              context.read<WebsocketProvider>().changeNewChatError(ServerError(message: dt));
            } finally {
              context.read<WebsocketProvider>().changeClicked(false);
            }
          }
        );
      } else {
        throw Exception("User id is null");
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final user = context.watch<DriftProvider>().user;
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
      body: Stack(
        children: [
          user!.chats.isNotEmpty ? ListView.builder(
            itemCount: user.chats.length,
            itemBuilder: (context, index) {
              return ChatCard(chatInfo: user.chats[index]);
            }
          ): Center(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              color: theme.colorScheme.surfaceContainer.withValues(alpha: 0.5),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: const Text('No chats yet. Add your first one!')
              )
            )
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsetsGeometry.all(16),
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    showDragHandle: true,
                    context: context, 
                    isScrollControlled: true,
                    builder: (BuildContext ctx) {
                      return NewChatCard(user: user);
                    }
                  );
                }, 
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  maximumSize: const Size(48, 48),
                  minimumSize: const Size(48, 48),
                  shape: const CircleBorder(),
                ),
                child: const Icon(Icons.person_add)
              )
            )
          )
        ]
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
    );
  }
}