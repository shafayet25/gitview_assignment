class UserModel {
  final String login;
  final String avatarUrl;
  final String? name;
  final String? bio;

  UserModel({
    required this.login,
    required this.avatarUrl,
    this.name,
    this.bio,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      login: json['login'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      name: json['name'],
      bio: json['bio'],
    );
  }
}
