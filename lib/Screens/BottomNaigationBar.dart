import 'package:Life_Connect_admin/Providers/tabIndexNotifier.dart';
import 'package:Life_Connect_admin/Screens/HospitalList.dart';
import 'package:Life_Connect_admin/Screens/home.dart';
import 'package:Life_Connect_admin/Screens/admin.dart';
import 'package:Life_Connect_admin/Screens/userList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (did) {
        return _showExitDialog(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<TabIndexNotifier>(
          builder: (context, tabIndexNotifier, child) {
            final screens = [
              const HomePage(),
              const UserList(),
              const HospitalList(),
              const ProfilePage(),
            ];

            return IndexedStack(
              index: tabIndexNotifier.currentIndex,
              children: screens,
            );
          },
        ),
        bottomNavigationBar: Consumer<TabIndexNotifier>(
          builder: (context, tabIndexNotifier, child) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BottomNavigationBar(
                  currentIndex: tabIndexNotifier.currentIndex,
                  onTap: (index) {
                    tabIndexNotifier.setIndex(index);
                  },
                  elevation: 0,
                  backgroundColor: Colors.red,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: const Color.fromARGB(255, 255, 184, 184),
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home_filled,
                        size: 20.sp,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.supervised_user_circle_outlined,
                        size: 20.sp,
                      ),
                      label: 'Users',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home_work_rounded,
                        size: 20.sp,
                      ),
                      label: 'Hospitals',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person_2_outlined,
                        size: 20.sp,
                      ),
                      label: 'Admin',
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showExitDialog(
    BuildContext context,
  ) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Exit'),
        content: const Text('Are you sure you want to exit?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false); // Close dialog
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ),
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: const Text(
              'Exit',
              style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
