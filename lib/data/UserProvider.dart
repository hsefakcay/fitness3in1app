import 'package:flutter/material.dart';
import 'model/user.dart';

class UserProvider extends ChangeNotifier {
  String? userId;
  User? user;

  void setUserId(String? id) {
    userId = id;
    notifyListeners();
  }

  void setUser(User newUser) {
    user = newUser;
    notifyListeners();
  }
}
