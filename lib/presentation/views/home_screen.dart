import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitview_assignment/presentation/view_models/auth_view_model.dart';



class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final user = controller.apiResponse.value.data;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: controller.logout,
          ),
        ],
      ),
      body: user == null
          ? const Center(child: Text("No user found"))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 50, backgroundImage: NetworkImage(user.avatarUrl)),
                  const SizedBox(height: 10),
                  Text(user.name ?? '', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Text('@${user.login}', style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 10),
                  Text(user.bio ?? '', textAlign: TextAlign.center),
                ],
              ),
            ),
    );
  }
}
