import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gitview_assignment/core/constans/api_endpoints/api_endpoint.dart';
import 'package:gitview_assignment/data/data_suorce/remote/api_service.dart';
import 'package:gitview_assignment/data/models/user_model.dart';


class LoginRepositories {

    final ApiService _apiService = ApiService();

  Future<UserModel> fetchUser(String username) async {
    final url = "${ApiEndpoint.loginUrl}$username";
        Get.snackbar(
        "Success",
        "$url",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    final response = await _apiService.getRequest(url);
    print(" ❌ login repositories: $response"); 
     // debug
    return UserModel.fromJson(response);
  }
}