import 'package:flutter/material.dart';
import 'package:flux_app/core/database/app_database.dart';

class MessageCard extends StatelessWidget {
  final Message message;
  final String userId;
  const MessageCard({
    super.key,
    required this.message,
    required this.userId
  });
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textStyle = theme.textTheme;
    return Row(
      mainAxisAlignment: message.senderId == userId ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Card(
          color: message.senderId == userId ? colorScheme.primaryContainer : colorScheme.surfaceContainerHighest,
          child: Padding(
            padding: EdgeInsetsGeometry.all(8),
            child: Row(
              spacing: 6,
              children: [
                Text(message.content), 
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 6),
                    Row(
                      spacing: 2,
                      children: [
                        Text(
                          '${message.createdAt.hour}:${message.createdAt.minute}',
                          style: textStyle.labelSmall
                        ),
                        if(message.senderId == userId)...{
                          Icon(
                            message.isReaded ? Icons.done_all_rounded : Icons.done_rounded,
                            size: 12,
                          )
                        }
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        )
      ]
    );
  }
}