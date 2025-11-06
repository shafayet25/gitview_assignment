class RepoModel {
  final String name;
  final String description;
  final String htmlUrl;

  RepoModel({
    required this.name,
    required this.description,
    required this.htmlUrl,
  });

  factory RepoModel.fromJson(Map<String, dynamic> json) {
    return RepoModel(
      name: json['name'] ?? 'No name',
      description: json['description'] ?? 'No description',
      htmlUrl: json['html_url'] ?? '',
    );
  }
}
