import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitview_assignment/core/routes/app_route.dart';
import 'package:gitview_assignment/data/data_suorce/local/user_preference.dart';
import 'package:gitview_assignment/data/data_suorce/remote/api_response/api_response.dart';
import 'package:gitview_assignment/data/models/user_model.dart';
import 'package:gitview_assignment/data/repository/login_repositories.dart';


class AuthController extends GetxController{
    final LoginRepositories _repo = LoginRepositories();
  final UserPreferences _prefs = UserPreferences();

  var userResponse = ApiResponse.loading().obs;
  // var userResponse = Rx<ApiResponse<UserModel>>(ApiResponse(null, null, null));
  UserModel? user;

  Future<void> getUser(String username) async {
     if (username.isEmpty) {
      Get.snackbar(
        "Error",
        "Username cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    userResponse.value = ApiResponse.loading();
    try {
      final fetchedUser = await _repo.fetchUser(username);
      await _prefs.saveUser(fetchedUser);
      user = fetchedUser;
      userResponse.value = ApiResponse.completed(fetchedUser);
      print("✅ Login Success: $user"); 
            // Success Snackbar
      Get.snackbar(
        "Success",
        "Login Successful",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.toNamed(AppRoute.homeScreen);
      
    } catch (e) {
      userResponse.value = ApiResponse.error(e.toString());
      print(" ❌ Login Error: $e"); 
       Get.snackbar(
        "error",
        "$e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> loadUser() async {
    final savedUser = await _prefs.getUser();
    if (savedUser != null) {
      user = savedUser;
      userResponse.value = ApiResponse.completed(savedUser);
    }
  }

  Future<void> logout() async {
    await _prefs.clearUser();
    user = null;
  }
}