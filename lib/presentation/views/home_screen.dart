import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitview_assignment/data/data_suorce/local/user_preference.dart';
import 'package:gitview_assignment/data/models/user_model.dart';
import 'package:gitview_assignment/presentation/view_models/auth_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController authController = Get.put(AuthController());
  final UserPreferences _prefs = UserPreferences();

  UserModel? user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final savedUser = await _prefs.getUser();
    setState(() {
      user = savedUser;
    });
  }

  @override
  Widget build(BuildContext context) {

    final theme=Theme.of(context);
    
    return Scaffold(
      body: SafeArea(
        child: user == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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

                  //const Divider(),
                  const SizedBox(height: 20),

                  // User Details
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12), 
                          border: Border.all(
                            color: Colors.grey.shade300, 
                            width: 1.5,
                          ),                   
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
                  SizedBox(height: 20),


                  /// Show Repositories
                  Row(
                    children: [
                      Text('Your Repositroy',style: theme.textTheme.bodyLarge),
                    ],
                  )
                  
                ],
              ),
      ),
    );
  }


  Widget _buildListView(){
  return ListView.builder( 
     itemCount: items.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blueAccent.shade100),
          ),
          child: Row(
            children: [
              const Icon(Icons.list, color: Colors.blue),
              const SizedBox(width: 12),
              Text(
                items[index],
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        );
      },
    );
}

}
