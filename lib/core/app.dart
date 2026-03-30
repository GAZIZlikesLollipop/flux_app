import 'package:flutter/material.dart';
import '../features/chat/pressentation/pages/chats_page.dart';
import 'theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatListScreen(),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
    );
  }
}