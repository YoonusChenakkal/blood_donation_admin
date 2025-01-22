import 'package:Life_Connect_admin/widgets/customButton.dart';
import 'package:Life_Connect_admin/widgets/customTextfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    const storedEmail = 'admin@gmail.com';
    const storedPassword = 'admin123';
    String? email;
    String? password;
    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: 100.h,
          width: 100.w,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/bg_angel.jpg',
              ),
              fit: BoxFit.cover,
              opacity: 0.3,
            ),
          ),
          child: SizedBox(
            height: 100.h,
            width: 100.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 23.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CustomTextfield(
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.email,
                  onChanged: (value) {
                    email = value;
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
                CustomTextfield(
                  hintText: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  icon: Icons.lock,
                  onChanged: (value) {
                    password = value;
                  },
                ),
                SizedBox(
                  height: 4.5.h,
                ),
                CustomButton(
                  text: 'Login',
                  onPressed: () async {
                    if (storedEmail == email && storedPassword == password) {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setString('admin', 'logedIn');
                      Navigator.pushNamed(context, '/bottomNavigationBar');
                    } else if (email == null || password == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Enter Email and Password')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Invalid Email or Password')));
                    }
                  },
                  buttonType: ButtonType.Outlined,
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
