import 'package:flutter/material.dart';
import 'package:flux_app/core/database/drift_provider.dart';
import 'package:flux_app/features/chat/data/websocket_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/chat_card.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});
  @override
  State<ChatListScreen> createState() => ChatListState();
}

class ChatListState extends State<ChatListScreen> {
  final userIdController = TextEditingController();
  final FocusNode userIdFocuseNode = FocusNode();
  bool isClicked = false;
  @override
  void initState() {
    super.initState();
    final userId = context.read<DriftProider>().user!.id;
    context.read<WebsocketProvider>().initChannel(userId);
  }
  @override
  void dispose() {
    userIdController.dispose();
    userIdFocuseNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final user = context.watch<DriftProider>().user;
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textStyle = theme.textTheme;
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
          user != null ? ListView.builder(
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
                    builder: (BuildContext ctx) {
                      return Padding(
                        padding: EdgeInsetsGeometry.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 8,
                              children: [
                                Text(
                                  'New chat',
                                  style: textStyle.titleLarge
                                ),
                                Text(
                                  'Enter the user ID to start a conversation',
                                  style: textStyle.bodyLarge?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.5))
                                ),
                              ]
                            ),
                            SizedBox(height: 30),
                            TextField(
                              autofocus: true,
                              decoration: InputDecoration(
                                hint: Text(
                                  'User ID',
                                  style: textStyle.bodyLarge?.copyWith(
                                    color: userIdFocuseNode.hasFocus ? colorScheme.primary : colorScheme.onSurface.withValues(alpha: 0.75)
                                  )
                                ),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: userIdFocuseNode.hasFocus ? colorScheme.primary : colorScheme.onSurface.withValues(alpha: 0.75)
                                ),
                              ),
                              focusNode: userIdFocuseNode,
                              controller: userIdController,
                            ),
                            SizedBox(height: 20),
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                spacing: 6,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: !isClicked ? () async {
                                            isClicked = true;

                                            isClicked = false;
                                            Navigator.pop(ctx);
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
                                          onPressed: () => Navigator.pop(ctx), 
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