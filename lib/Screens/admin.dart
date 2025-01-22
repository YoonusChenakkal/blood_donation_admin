import 'package:Life_Connect_admin/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 11.h,
              height: 11.h,
              padding: const EdgeInsets.all(1),
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 1.5),
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: const AssetImage('assets/man.png'),
                  )),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'Admin',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                height: .25.h,
              ),
            ),
            Text(
              'admin@gmail.com',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                height: .2.h,
              ),
            ),
            SizedBox(
              height: 3.2.h,
            ),
            CustomButton(
                height: 4.2,
                width: 32,
                text: 'Log Out',
                buttonType: ButtonType.Outlined,
                onPressed: () => logout(context))
          ],
        ),
      ),
    );
  }

  logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('admin');
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Loged Out')));
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (route) => false,
    );
  }
}
