import 'package:get/get.dart';
import 'package:gitview_assignment/core/routes/app_route.dart';
import 'package:gitview_assignment/presentation/views/home_screen.dart';
import 'package:gitview_assignment/presentation/views/login_screen.dart';


class AppPages {
  static appPages() =>[
    GetPage(name: AppRoute.loginScreen, page: ()=> LoginScreen()),
    GetPage(name: AppRoute.homeScreen, page: ()=> HomeScreen()),
  ];
}