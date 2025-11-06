import 'dart:convert';
import 'package:gitview_assignment/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserPreferences {
  static const _keyUser = 'userData';

  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUser, jsonEncode(user.toJson()));
  }

  Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(_keyUser);
    if (userString != null) {
      final json = jsonDecode(userString);
      return UserModel.fromJson(json);
    }
    return null;
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUser);
  }
}
