import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flux_app/core/database/drift_provider.dart';
import 'package:flux_app/features/auth/data/auth_provider.dart';
import 'package:flux_app/features/chat/pressentation/pages/chats_page.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  @override
  State<AuthPage> createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  final usernameController = TextEditingController();
  bool isNextClicked = false;
  @override
  void initState(){
    super.initState();
    context.read<DriftProider>().isRegistered().then((val) {
      if(val) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => ChatListScreen()));
      }
    });
  }
  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final photoPath = context.watch<AuthProvider>().photoPath;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme; 
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome!'),
      ),
      body: Column(
        spacing: 12,
        children: [
          InkWell(
            onTap: () => context.read<AuthProvider>().pickPhoto(),
            child: Container(
              height: 100,
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: colorScheme.secondaryContainer,
              ),
              child: photoPath != null 
              ? 
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: 
                  Image.file(
                    File(photoPath),
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                  )
              )
              : Icon(Icons.add_a_photo_outlined),
            )
          ),
          Text(
            'Profile info',
            style: textTheme.titleLarge
          ),
          Text(
            'Enter your name and picture',
            style: textTheme.titleMedium?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.5))
          ),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
            child: TextField(
              controller: usernameController,
              onChanged: (_) {
                setState(() {});
              },
              decoration: InputDecoration(
                labelText: "User name",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colorScheme.onSurface, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
                ),
              ),
            )
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.directional(bottom: 16,start: 12,end: 12),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: usernameController.text.isNotEmpty && photoPath != null ? WidgetStatePropertyAll(colorScheme.primary) : WidgetStatePropertyAll(colorScheme.primary.withValues(alpha: 0.25)), 
              foregroundColor: usernameController.text.isNotEmpty && photoPath != null ? WidgetStatePropertyAll(colorScheme.onPrimary) : WidgetStatePropertyAll(colorScheme.secondary)
            ),
            onPressed: () async {
              if(usernameController.text.isNotEmpty && photoPath != null && !isNextClicked) {
                isNextClicked = true;
                await context.read<DriftProider>().createUser(usernameController.text, photoPath);
                if(context.mounted) {
                  Navigator.push(context,MaterialPageRoute(builder: (ctx) => ChatListScreen()));
                }
                isNextClicked = false;
              }
            }, 
            child: Text('Next')
          )
        ),
      )
    );
  }
}