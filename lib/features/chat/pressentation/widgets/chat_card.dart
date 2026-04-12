import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flux_app/core/database/app_database.dart';
import '../pages/chat_page.dart';

class ChatCard extends StatelessWidget {
  final bool isDivider;
  final Chat chatInfo;
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder:(ctx) => ChatScreen(chatId: chatInfo.id)),
              );
            },
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
                        child: Image.file(
                          File(chatInfo.avatarPath),
                          fit: BoxFit.cover,
                        ),
                      )
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text(chatInfo.title),
                          Text(
                            chatInfo.lastMessageContent,
                            style: TextStyle(color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5))
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "${chatInfo.lastMessageCreatedAt.hour < 10 ? 0 : ""}${chatInfo.lastMessageCreatedAt.hour}:${chatInfo.lastMessageCreatedAt.minute < 10 ? 0 : ""}${chatInfo.lastMessageCreatedAt.minute}",
                          style: TextStyle(color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.75))
                        ),
                        SizedBox(height: 4),
                        if (!chatInfo.lastMessageIsReaded) ...[
                          Card(
                            shape: CircleBorder(),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                '●',
                                style: theme.textTheme.labelLarge?.copyWith(fontSize: 10)
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