import 'dart:convert';
import 'package:gitview_assignment/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserPreference {
  static const String _keyUser = 'user_data';

  /// Save user data
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert UserModel to JSON string
    final userJson = jsonEncode({
      'login': user.login,
      'avatar_url': user.avatarUrl,
      'name': user.name,
      'bio': user.bio,
    });
    return prefs.setString(_keyUser, userJson);
  }

  /// Get saved user
  Future<UserModel?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyUser);

    if (jsonString == null) return null;

    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return UserModel.fromJson(jsonMap);
  }

  /// Remove user data
  Future<bool> clearUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(_keyUser);
  }
}
