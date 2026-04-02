import 'package:flutter/material.dart';
import 'package:flux_app/features/auth/pressentation/auth_page.dart';
import 'theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthPage(),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
    );
  }
}