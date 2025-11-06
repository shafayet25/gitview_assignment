class ApiEndpoint {
  //base url 
  static const baseUrl='https://api.github.com/';

  // Login url for user data fatch
  static const loginUrl='${baseUrl}users/';

    // User repo data fatch
  static const repoUrl='users/{username}/repo';
}