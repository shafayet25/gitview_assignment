import 'package:get/get.dart';
import 'package:gitview_assignment/core/routes/app_route.dart';
import 'package:gitview_assignment/data/data_suorce/local/user_preference.dart';
import 'package:gitview_assignment/data/data_suorce/remote/api_response/api_response.dart';
import 'package:gitview_assignment/data/data_suorce/remote/api_response/status.dart';
import 'package:gitview_assignment/data/models/user_model.dart';
import 'package:gitview_assignment/data/repository/login_repositories.dart';


class AuthController extends GetxController{
  final _repo =LoginRepositories();
  final _prefs = UserPreference();

  var apiResponse=ApiResponse<UserModel>.loading().obs;


   /// Login function
  void login(String username) async {
    if (username.isEmpty) {
      apiResponse.value = ApiResponse.error("Please enter a username");
      return;
    }

    apiResponse.value = ApiResponse.loading(); // Loading state

    try {
      final response = await _repo.loginUser(username);

      if (response.status == Status.COMPLETED) {
        // Save user to SharedPreferences
        await _prefs.saveUser(response.data!);
        apiResponse.value = response;
        
        // Navigate to Home Page
        Get.offAllNamed(AppRoute.homeScreen);
      } else {
        apiResponse.value = response;
      }
    } catch (e) {
      apiResponse.value = ApiResponse.error(e.toString());
    }
  }

  Future<UserModel?> loadUserFromPrefs() async {
    return await _prefs.getUser();
  }

  void logout() async {
    await _prefs.clearUser();
    Get.offAllNamed(AppRoute.loginScreen);
  }



}

