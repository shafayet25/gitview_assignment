import 'package:flutter/material.dart';
import 'package:gitview_assignment/data/models/repo_model.dart';

class RepoGridCard extends StatelessWidget {
  final RepoModel repo;
  final VoidCallback? onTap;

  const RepoGridCard({super.key, required this.repo, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return GestureDetector(
  onTap: onTap,
  child: Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.blue.shade50),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade50,
          blurRadius: 4,
          offset: const Offset(0, 2),
        )
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name & Icon Row
        Row(
          children: [
             Image.asset(
              'assets/icons/repo_icon.png',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                repo.name ?? "Unnamed Repo",
                style: theme.textTheme.bodyLarge,
                maxLines: 1,              
                overflow: TextOverflow.ellipsis
              ),
            ),
            

          ],
        ),
        const SizedBox(height: 4),
        Text(
          repo.description ?? "No description",
          style: theme.textTheme.bodyMedium,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
      ],
    ),
  ),
);
  }
}