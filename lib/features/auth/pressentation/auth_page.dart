import 'dart:io';

import 'package:flutter/material.dart';
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
              decoration: InputDecoration(
                labelText: "User name",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colorScheme.onSurface, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colorScheme.primary, width: 2.0), // Сделаем рамку толще при фокусе
                ),
              ),
            )
          ),
        ],
      ),
      bottomNavigationBar: AnimatedSlide(
        offset: usernameController.text.isNotEmpty ? Offset.zero : Offset(0,1),
        curve: Curves.easeInOutQuart,
        duration: Duration(milliseconds: 500),
        child: Padding(
          padding: EdgeInsetsGeometry.directional(bottom: 16,start: 12,end: 12),
          child: ElevatedButton(
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (ctx) => ChatListScreen()));
            }, 
            child: Text('next')
          )
        ),
      )
    );
  }
}