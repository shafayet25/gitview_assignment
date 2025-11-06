class UserModel {
  final String login;
  final String? name;
  final String avatarUrl;
  final String? bio;
  final int followers;
  final int following;

  UserModel({
    required this.login,
    this.name,
    required this.avatarUrl,
    this.bio,
    required this.followers,
    required this.following,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      login: json['login'],
      name: json['name'],
      avatarUrl: json['avatar_url'],
      bio: json['bio'],
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'name': name,
      'avatar_url': avatarUrl,
      'bio': bio,
      'followers': followers,
      'following': following,
    };
  }
}
