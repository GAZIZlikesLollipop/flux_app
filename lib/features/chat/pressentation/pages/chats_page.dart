import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_){
      final userId = context.read<DriftProider>().user?.id;
      if(userId != null){
        context.read<WebsocketProvider>().initChannel(userId);
      } else {
        throw Exception("User id = null");
      }
    });
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
                      return Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
                        child: Column(
                          spacing: 12,
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
                              decoration: InputDecoration(
                                hint: Text(
                                  'Paste ID here…',
                                  style: textStyle.labelLarge?.copyWith(
                                    color: userIdFocuseNode.hasFocus ? colorScheme.primary : colorScheme.onSurface.withValues(alpha: 0.75)
                                  )
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: userIdFocuseNode.hasFocus ? colorScheme.primary : colorScheme.onSurface.withValues(alpha: 0.75)
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
                                Text(
                                  user.id,
                                  overflow: TextOverflow.ellipsis,
                                  style: textStyle.bodyLarge?.copyWith(
                                    color: colorScheme.onSurface.withValues(alpha: 0.4)
                                  )
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
                                          onPressed: !isClicked ? () {

                                            setState(() => isClicked = true);
                                            try{
                                              ctx.read<WebsocketProvider>().channel?.stream.listen(
                                                (data){
                                                  print(data);
                                                  setState(() => isClicked = false);
                                                  if(ctx.mounted) {
                                                    Navigator.pop(ctx);
                                                  }
                                                } 
                                              ); 
                                              print("Все прошло успешно");
                                            } catch (e, stackTrace) {
                                              throw Exception("$e: $stackTrace");
                                            } 

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