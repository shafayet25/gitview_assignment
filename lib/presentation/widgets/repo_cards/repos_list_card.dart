import 'package:flutter/material.dart';
import 'package:gitview_assignment/data/models/repo_model.dart';

class RepoListCard extends StatelessWidget {
  final RepoModel repo;
  final VoidCallback? onTap;

  const RepoListCard({super.key, required this.repo, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: theme.cardColor, 
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title & Icon Row
              Row(
                children: [
                  Image.asset(
                    'assets/icons/repo_icon.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      repo.name ?? "Unnamed Repo",
                      style: theme.textTheme.bodyLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
      

                ],
              ),
              const SizedBox(height: 6),
              // Description
              Text(
                repo.description ?? "No description",
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}