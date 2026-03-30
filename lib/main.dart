import 'package:flutter/material.dart';
import 'package:flux_app/core/database/app_database.dart';
import 'package:flux_app/features/chat/domain/drift_provider.dart';
import 'package:provider/provider.dart';
import 'core/app.dart';

void main(){
  final database = AppDatabase();
  runApp(
    ChangeNotifierProvider(
      create: (context) => DriftProider(db: database), 
      child: const MainApp()
    )
  );
}