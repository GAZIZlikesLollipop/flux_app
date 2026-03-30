import 'package:flutter/material.dart';
import '../../../../core/database/app_database.dart';

class ChatScreen extends StatelessWidget {
  final Chat chatInfo ;
  const ChatScreen({
    super.key,
    required this.chatInfo
  });
  @override
  Widget build(BuildContext context) {
    final TextTheme textStyle = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
                child: Image.network(
                  chatInfo.imageURL,
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
                decoration: InputDecoration(
                  labelText: "Write a message..."
                ),
              )
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.attach_file)
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.mic_outlined)
            ),
          ]
        )
      ),
    );
  }
}