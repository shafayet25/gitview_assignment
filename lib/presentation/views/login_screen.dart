import 'package:flutter/material.dart';
import 'package:gitview_assignment/core/constans/app_color/color.dart';
import 'package:gitview_assignment/presentation/view_models/auth_view_model.dart';
import 'package:gitview_assignment/presentation/widgets/main_button.dart';
import 'package:gitview_assignment/presentation/widgets/textFiled.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

final usernameController=TextEditingController();
final AuthController authController=AuthController();

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
              SizedBox(height: 100),
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
                    CustomTextField(hintText: 'Enter Your User Name', controller: usernameController,),

                  ],
                ),
              SizedBox(height: 30),


              // SignIn Button
              CustomElevatedButton(text: 'Sign in', 
            
              onPressed: (){
                authController.login(usernameController.text.trim());
               //Get.toNamed(AppRoute.homeScreen);
              }),
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