

import 'package:get/get.dart';
import 'package:gitview_assignment/data/data_suorce/remote/api_response/api_response.dart';
import 'package:gitview_assignment/data/data_suorce/remote/api_response/status.dart';
import 'package:gitview_assignment/data/models/repo_model.dart';
import 'package:gitview_assignment/data/repository/repo_repositories.dart';

class RepoController extends GetxController{
 final RepoRepositories _repoRepository = RepoRepositories();
  // var repoResponse = ApiResponse<List<RepoModel>>.loading().obs;
 

  // void fetchRepos(String username) async {
  //   try {
  //     repoResponse.value = ApiResponse.loading();
  //     final repos = await _repoRepository.fetchRepos(username);
  //     repoResponse.value = ApiResponse.completed(repos);
  //   } catch (e) {
  //     repoResponse.value = ApiResponse.error(e.toString());
  //   }
  // }
  // Observable repo list
  // Observable for API response
  var repoResponse = ApiResponse<List<RepoModel>>.loading().obs;

  // Fetch repositories
  void fetchRepos(String username) async {
    try {
      repoResponse.value = ApiResponse.loading();

      final repos = await _repoRepository.fetchRepos(username);

      // Update response with completed state
      repoResponse.value = ApiResponse.completed(repos);
    } catch (e) {
      // Update response with error state
      repoResponse.value = ApiResponse.error(e.toString());
      print("❌ Error fetching repos: $e");
    }
  }

  // Getter for easy access in HomeScreen
  List<RepoModel> get repoList =>
      repoResponse.value.data ?? []; // Return empty list if null

  bool get isLoading =>
      repoResponse.value.status == Status.LOADING; // check loading state
}

  
