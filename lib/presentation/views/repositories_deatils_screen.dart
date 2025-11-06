import 'package:flutter/material.dart';
import 'package:gitview_assignment/data/models/repo_model.dart';

class RepositoriesDeatilsScreen extends StatelessWidget {
 final RepoModel repo;
  const RepositoriesDeatilsScreen({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
        title: Text(repo.name ?? "Repository Details"),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Text(
              repo.name ?? "No Name",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              repo.description ?? "No description",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(" Stars: ${repo.stargazersCount ?? 0}"),
            Text(" Forks: ${repo.forksCount ?? 0}"),
            Text(" Created at: ${repo.createdAt ?? 'Unknown'}"),
            Text(" Language: ${repo.language ?? 'Unknown'}"),
          ],
        ),
      ),
    );
  }
}