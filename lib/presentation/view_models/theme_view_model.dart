import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeViewModel extends GetxController {
  // true হলে dark theme
  var isDarkMode = false.obs;

  ThemeMode get themeMode => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
