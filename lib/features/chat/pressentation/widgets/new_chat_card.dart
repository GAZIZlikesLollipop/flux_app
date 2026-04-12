import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flux_app/core/database/app_database.dart';
import 'package:flux_app/core/database/user_model.dart';
import 'package:flux_app/features/chat/data/api_models.dart';
import 'package:flux_app/features/chat/data/websocket_provider.dart';
import 'package:provider/provider.dart';

class NewChatCard extends StatefulWidget {
  final UserDTO user;
  const NewChatCard({
    super.key,
    required this.user,
  });
  @override
  State<StatefulWidget> createState() => NewChatCardState();
}

class NewChatCardState extends State<NewChatCard> {
  final userIdController = TextEditingController();
  final FocusNode userIdFocuseNode = FocusNode();
  @override
  void dispose() {
    userIdController.dispose();
    userIdFocuseNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final bool isClicked = context.read<WebsocketProvider>().isClicked;
    final UserDTO user = widget.user;
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textStyle = theme.textTheme;
    final ConnectionError? newChatError = context.watch<WebsocketProvider>().newChatError;
    userIdFocuseNode.addListener((){
      if(!context.mounted){
        userIdFocuseNode.removeListener((){});
      }
      setState((){});
    });
    return Padding(
      padding: EdgeInsetsGeometry.directional(
        start: 24,
        end:  24,
        bottom: MediaQuery.of(context).viewInsets.bottom+16
      ),
      child: Column(
        spacing: 12,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'New chat',
                style: textStyle.titleMedium
              ),
              Text(
                'Paste or type the person\'s ID below',
                style: textStyle.labelLarge?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.5))
              ),
            ]
          ),
          TextField(
            autofocus: true,
            onChanged: (_) => setState((){}),
            decoration: InputDecoration(
              error: newChatError != null ? Row(
                spacing: 5,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: colorScheme.error,
                    size: 14,
                  ),
                  Text(
                    switch(newChatError) {
                      NetworkError _ => "Network exception, please try again",
                      ServerError e => e.message,
                    }
                  ),
                ],
              ) : null,
              hint: Text(
                'Paste ID here…',
                style: textStyle.labelLarge?.copyWith(
                  color: userIdFocuseNode.hasFocus && newChatError == null ? colorScheme.primary : colorScheme.onSurface.withValues(alpha: 0.75)
                )
              ),
              prefixIcon: Icon(
                Icons.search,
                color: userIdFocuseNode.hasFocus && newChatError == null ? colorScheme.primary : colorScheme.onSurface.withValues(alpha: 0.75)
              ),
            ),
            focusNode: userIdFocuseNode,
            controller: userIdController,
          ),
          const Divider(),
          Text(
            'Your ID — share this with others so they can find you',
            style: textStyle.labelLarge?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.75)
            )
          ),
          Row(
            children: [
              CircleAvatar(
                maxRadius: 16,
                backgroundColor: colorScheme.tertiaryContainer,
                foregroundColor: colorScheme.onTertiaryContainer.withValues(alpha: 0.75),
                child: Icon(
                  Icons.person_outline,
                  size: 20
                )
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: size.width > size.height ? size.height/2 : size.width/2,
                child: Text(
                  user.id,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle.bodyLarge?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.4)
                  ),
                ),
              ),
              Spacer(),
              OutlinedButton(
                onPressed: () => Clipboard.setData(ClipboardData(text: user.id)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: colorScheme.onSurface.withValues(alpha: 0.5),
                  textStyle:  textStyle.labelSmall,
                  padding: EdgeInsets.zero
                ),
                child: Row(
                  spacing: 3,
                  children: [
                    Icon(
                      Icons.copy,
                      size: 14,
                    ),
                    Text('Copy')
                  ]
                )
              )
            ],
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              spacing: 6,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: !isClicked && userIdController.text.isNotEmpty ? () async {
                          context.read<WebsocketProvider>().changeClicked(true);
                          context.read<WebsocketProvider>().sendData(
                            ServerReq(
                              receiverID: userIdController.text, 
                              data: NewChatData(
                                type: ServerData.newChatReq,
                                chat: Chat(
                                  id: user.id, 
                                  userId: userIdController.text, 
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
                        } : null, 
                        child: Text('Start chat')
                      ),
                    ),
                  ]
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context), 
                        child: Text('Cancel')
                      )
                    )
                  ]
                )
              ]
            )
          )
        ],
      )
    );
  }
}