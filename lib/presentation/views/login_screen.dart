import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitview_assignment/core/constans/api_endpoints/api_endpoint.dart';
import 'package:gitview_assignment/core/constans/app_color/color.dart';
import 'package:gitview_assignment/presentation/view_models/auth_view_model.dart';
import 'package:gitview_assignment/presentation/view_models/theme_view_model.dart';
import 'package:gitview_assignment/presentation/widgets/main_button.dart';
import 'package:gitview_assignment/presentation/widgets/text_filed.dart';


class LoginScreen extends StatelessWidget {

final usernameController=TextEditingController();
final AuthController authController=AuthController();
final ThemeViewModel themeController = Get.find<ThemeViewModel>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return  Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              /// Theme Toggle
              Align(
                alignment: Alignment.topRight,
                child: Obx(() => Switch(
                      value: themeController.isDarkMode.value,
                      activeThumbColor: AppColor.lightPrimary,
                      onChanged: (value) => themeController.toggleTheme(),
                    )),
              ),
              SizedBox(height: 80),


              // Logo
              Image.asset('assets/github.png'),
              SizedBox(height: 30),

              //Title
              Text('SignIn with Username',style: theme.textTheme.bodyLarge),
              SizedBox(height: 10),

              //SubTitle
              Text('Enter your GitHub username to access your repositories',style: theme.textTheme.bodyMedium),
              SizedBox(height: 70),

              // Text Filed For Input User Name
              Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    Text('Username',style: theme.textTheme.bodyLarge),
                    SizedBox(height: 10),
                    CustomTextField(hintText: 'Enter Your User Name', controller: usernameController),

                  ],
                ),
              SizedBox(height: 30),
          
                  CustomElevatedButton(
                    text: 'Sign in',
                    onPressed: () async {
                      String username = usernameController.text.trim();
                        await authController.getUser(username);
                    //print("✅ Login Success:${ApiEndpoint.loginUrl}$username"); 
                    },
                  ),
                
            

              SizedBox(height: 50),

              // End Text
             Text('By signing in, you accept our ',style: theme.textTheme.bodyMedium),
             SizedBox(height: 5),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){

                    },
                    child: Text('Terms of Use ',style: TextStyle(color: AppColor.lightPrimary))),
                  Text('and ',style: theme.textTheme.bodyMedium),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Text('Privacy Policy',style:TextStyle(color: AppColor.lightPrimary))),
                ],
              )
              
            ],
          ),
        )
        ),
    );
  }

}

