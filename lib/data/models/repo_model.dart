// lib/data/models/repo_model.dart
class RepoModel {
  final int id;
  final String name;
  final String? description;
  final String htmlUrl;
  final int stargazersCount;
  final int forksCount;
  final String? language;
  final String createdAt;
  final String updatedAt;

  RepoModel({
    required this.id,
    required this.name,
    this.description,
    required this.htmlUrl,
    required this.stargazersCount,
    required this.forksCount,
    this.language,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RepoModel.fromJson(Map<String, dynamic> json) {
    return RepoModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      htmlUrl: json['html_url'],
      stargazersCount: json['stargazers_count'] ?? 0,
      forksCount: json['forks_count'] ?? 0,
      language: json['language'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'html_url': htmlUrl,
        'stargazers_count': stargazersCount,
        'forks_count': forksCount,
        'language': language,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
