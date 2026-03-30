import 'package:flutter/material.dart';
import 'package:flux_app/core/database/user_model.dart';
import '../../../core/database/app_database.dart';
import 'package:uuid/uuid.dart';

class DriftProider extends ChangeNotifier {
  final AppDatabase db; 
  DriftProider({required this.db});
  UserDTO? _user;
  UserDTO? get user => _user; 

  void createUser(
    String userName,
    String avatarPath
  ) async {
    final User temp = 
      User(
        id: Uuid().v4(),
        name: userName,
        lastOnline: DateTime.now(),
        avatarPath: avatarPath,
      );
    await db.createUser(temp);
    notifyListeners();
  }
  void loadUser() async {
    final users = await db.allUsers;
    _user = users[0];
    notifyListeners();
  }
}