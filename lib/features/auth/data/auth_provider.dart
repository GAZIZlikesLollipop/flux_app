import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider extends ChangeNotifier {
  String? _photoPath;
  String? get photoPath => _photoPath;
  void pickPhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    _photoPath = image?.path;
    notifyListeners();
  }
}