import 'package:flutter/material.dart';
import 'package:flux_app/core/database/app_database.dart';
import 'package:flux_app/core/database/drift_provider.dart';
import 'package:flux_app/features/auth/data/auth_provider.dart';
import 'package:flux_app/features/chat/data/websocket_provider.dart';
import 'package:provider/provider.dart';
import 'core/app.dart';

void main(){
  final database = AppDatabase();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DriftProvider(db: database)),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => WebsocketProvider())
      ],
      child: const MainApp()
    )
  );
}