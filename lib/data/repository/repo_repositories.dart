import 'package:gitview_assignment/core/constans/api_endpoints/api_endpoint.dart';
import 'package:gitview_assignment/data/data_suorce/remote/api_service.dart';
import 'package:gitview_assignment/data/models/repo_model.dart';

class RepoRepositories {

    final ApiService _apiService = ApiService();

  Future<List<RepoModel>> fetchRepos(String username) async {
    final url = '${ApiEndpoint.loginUrl}$username/repos';
    final data = await _apiService.getRequest(url);
    return (data as List).map((json) => RepoModel.fromJson(json)).toList();
  }
}