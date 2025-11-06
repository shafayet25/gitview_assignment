import 'package:flutter/material.dart';
import 'package:gitview_assignment/core/constans/app_color/color.dart';


class AppTheme{
  
  static final lightTheme=ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColor.lightPrimary,
      useMaterial3: true,
       scaffoldBackgroundColor: AppColor.lightBackground,
       cardColor: Colors.blue.shade50,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColor.lightBackground
      ),
      textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColor.lightText, fontSize: 18),
          bodyMedium: TextStyle(color: AppColor.lightSubText),       
      )
  );


    static final darkTheme=ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColor.darkPrimary,
      useMaterial3: true,
       scaffoldBackgroundColor: AppColor.darkBackground,
       cardColor: AppColor.darkCard,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColor.darkBackground
      ),
      textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColor.darkText, fontSize: 18),
          bodyMedium: TextStyle(color: AppColor.darkSubText),       
      )
  );
}