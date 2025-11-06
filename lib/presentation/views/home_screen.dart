import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitview_assignment/data/data_suorce/local/user_preference.dart';
import 'package:gitview_assignment/data/data_suorce/remote/api_response/status.dart';
import 'package:gitview_assignment/data/models/repo_model.dart';
import 'package:gitview_assignment/data/models/user_model.dart';
import 'package:gitview_assignment/presentation/view_models/auth_view_model.dart';
import 'package:gitview_assignment/presentation/view_models/repo_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController authController = Get.put(AuthController());
  final RepoController controller = Get.put(RepoController());
  final UserPreferences _prefs = UserPreferences();
  bool isGridView = false;
  UserModel? user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final savedUser = await _prefs.getUser();
    if (savedUser != null) {
      setState(() {
        user = savedUser;
      });
      controller.fetchRepos(savedUser.login);
      print("⚠️ Fetching repos for: ${savedUser.login}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: user == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Info Header
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left side user info
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(user!.avatarUrl),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user!.name ?? "No Name",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  user!.login ?? "No Username",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Logout button
                        IconButton(
                          onPressed: () async {
                            await authController.logout();
                            Get.offAllNamed('/login');
                          },
                          icon: const Icon(Icons.logout),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // User Details Container
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300, width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Bio: ${user!.bio ?? 'No bio'}"),
                        const SizedBox(height: 8),
                        Text("Followers: ${user!.followers ?? 0}"),
                        Text("Following: ${user!.following ?? 0}"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Repository Header with Toggle
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text('Your Repositories',
                            style: theme.textTheme.titleMedium),
                        const Spacer(),
                        IconButton(
                          icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, anim) =>
                                RotationTransition(
                              turns: Tween<double>(begin: 0.75, end: 1)
                                  .animate(anim),
                              child: FadeTransition(opacity: anim, child: child),
                            ),
                            child: isGridView
                                ? const Icon(Icons.grid_view,
                                    key: ValueKey('grid'))
                                : const Icon(Icons.list,
                                    key: ValueKey('list')),
                          ),
                          onPressed: () {
                            setState(() {
                              isGridView = !isGridView;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Repository List/Grid
                  Expanded(
                    child: Obx(() {
                      final response = controller.repoResponse.value;

                      if (response.status == Status.LOADING) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (response.status == Status.ERROR) {
                        return Center(child: Text("Error: ${response.message}"));
                      }

                      final repos = response.data ?? [];
                      if (repos.isEmpty) {
                        return const Center(child: Text("No repositories found"));
                      }

                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: isGridView
                            ? buildGridView(repos, key: const ValueKey('grid'))
                            : buildListView(repos, key: const ValueKey('list')),
                      );
                    }),
                  ),
                ],
              ),
      ),
    );
  }

  // 📋 List View
  Widget buildListView(List<RepoModel> repos, {Key? key}) {
    return ListView.builder(
      key: key,
      padding: const EdgeInsets.all(10),
      itemCount: repos.length,
      itemBuilder: (context, index) {
        final repo = repos[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(repo.name ?? "Unnamed Repo",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text(repo.description ?? "No description"),
            ],
          ),
        );
      },
    );
  }

  // 🟩 Grid View
  Widget buildGridView(List<RepoModel> repos, {Key? key}) {
    return GridView.builder(
      key: key,
      padding: const EdgeInsets.all(10),
      itemCount: repos.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 3 / 2,
      ),
      itemBuilder: (context, index) {
        final repo = repos[index];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green.shade100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(repo.name ?? "Unnamed Repo",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Expanded(
                child: Text(
                  repo.description ?? "No description",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
