import 'package:gitview_assignment/core/constans/api_endpoints/api_endpoint.dart';
import 'package:gitview_assignment/data/data_suorce/remote/api_response/api_response.dart';
import 'package:gitview_assignment/data/data_suorce/remote/api_service.dart';
import 'package:gitview_assignment/data/models/user_model.dart';


class LoginRepositories {
  final ApiService _api=ApiService();
  Future<ApiResponse<UserModel>> loginUser(String username) async{
    try {
      final data = await _api.getRequest("${ApiEndpoint.loginUrl}/$username");
      final user = UserModel.fromJson(data);
      return ApiResponse.completed(user);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}