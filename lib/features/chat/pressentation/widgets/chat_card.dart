import 'package:flutter/material.dart';
import '../../../../core/database/user_model.dart';
import '../pages/chat_page.dart';

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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder:(ctx) => ChatScreen(chatInfo: chatInfo)),
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
                        child: Image.network(
                          chatInfo.imageURL,
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
                            chatInfo.lastMessage.content,
                            style: TextStyle(color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5))
                          ),
                        ],
                      ),
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