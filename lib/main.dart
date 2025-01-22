import 'dart:async';
import 'package:Life_Connect_admin/Providers/campsProvider.dart';
import 'package:Life_Connect_admin/Providers/certificateProvider%20.dart';
import 'package:Life_Connect_admin/Providers/hospitalProvider.dart';
import 'package:Life_Connect_admin/Providers/tabIndexNotifier.dart';
import 'package:Life_Connect_admin/Providers/userProvider.dart';
import 'package:Life_Connect_admin/Screens/BottomNaigationBar.dart';
import 'package:Life_Connect_admin/Screens/CampDetails.dart';
import 'package:Life_Connect_admin/Screens/Splash%20Screen/splashScreen.dart';
import 'package:Life_Connect_admin/Screens/Certificates.dart';
import 'package:Life_Connect_admin/Screens/certificateDetails.dart';
import 'package:Life_Connect_admin/Screens/hospitalDetails.dart';
import 'package:Life_Connect_admin/Screens/login.dart';
import 'package:Life_Connect_admin/Screens/userDetails.dart';
import 'package:Life_Connect_admin/Screens/home.dart';
import 'package:Life_Connect_admin/Screens/scheduledCamps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => TabIndexNotifier()),
            ChangeNotifierProvider(create: (_) => UserProvider()..loadUser()),
            ChangeNotifierProvider(
                create: (_) => HospitalProvider()..fetchHospitals()),
            ChangeNotifierProvider(
                create: (_) => Campsprovider()..fetchCamps(context)),
            ChangeNotifierProvider(
                create: (_) => CertificateProvider()..fetchCertificates()),
          ],
          child: MainApp(),
        );
      },
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
  });

  Future<String> checkInitialRoute() async {
    final prefs = await SharedPreferences.getInstance();
    String? admin = prefs.getString('admin');
    return admin != null && admin.isNotEmpty ? '/splashScreen' : '/login';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/splashScreen': (context) => SplashScreen(),
        '/login': (context) => const Login(),
        '/home': (context) => const HomePage(),
        '/bottomNavigationBar': (context) => const CustomBottomNavigationBar(),
        '/camps': (context) => const Scheduledcamps(),
        '/campDetails': (context) => const CampDetails(),
        '/userDetails': (context) => const UserDetails(),
        '/hospitalDetails': (context) => const HospitalDetails(),
        '/userCertificates': (context) => const DonorCertificates(),
        '/certificateDetails': (context) => const CertificateDetails(),
      },
      builder: (context, child) {
        return FutureBuilder<String>(
          future: checkInitialRoute(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return MaterialApp(
                initialRoute: snapshot.data,
                routes: {
                  '/splashScreen': (context) => SplashScreen(),
                  '/login': (context) => const Login(),
                  '/home': (context) => const HomePage(),
                  '/bottomNavigationBar': (context) =>
                      const CustomBottomNavigationBar(),
                  '/camps': (context) => const Scheduledcamps(),
                  '/campDetails': (context) => const CampDetails(),
                  '/userDetails': (context) => const UserDetails(),
                  '/hospitalDetails': (context) => const HospitalDetails(),
                  '/userCertificates': (context) => const DonorCertificates(),
                  '/certificateDetails': (context) =>
                      const CertificateDetails(),
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }
}


// void main() async {
//   WidgetsFlutterBinding
//       .ensureInitialized(); // Ensures the Flutter engine is initialized
//   final prefs = await SharedPreferences.getInstance();
//   final isLoggedIn = prefs.getString('admin') == 'loggedIn';

//   runApp(
//     Sizer(
//       builder: (context, orientation, deviceType) {
//         return MultiProvider(
//           providers: [
//             ChangeNotifierProvider(create: (_) => TabIndexNotifier()),
//             ChangeNotifierProvider(create: (_) => UserProvider()..loadUser()),
//             ChangeNotifierProvider(
//                 create: (_) => HospitalProvider()..fetchHospitals()),
//             ChangeNotifierProvider(
//                 create: (_) => Campsprovider()..fetchCamps(context)),
//             ChangeNotifierProvider(
//                 create: (_) => CertificateProvider()..fetchCertificates()),
//           ],
//           child: MainApp(
//               isLoggedIn: isLoggedIn), // Pass the login state to MainApp
//         );
//       },
//     ),
//   );
// }

// class MainApp extends StatelessWidget {
//   final bool isLoggedIn;

//   const MainApp({super.key, required this.isLoggedIn});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       initialRoute: isLoggedIn
//           ? '/splashScreen'
//           : '/login', // Set based on login state
//       routes: {
//         '/splashScreen': (context) => SplashScreen(), 
//         '/login': (context) => const Login(),
//         '/home': (context) => const HomePage(),
//         '/bottomNavigationBar': (context) => const CustomBottomNavigationBar(),
//         '/camps': (context) => const Scheduledcamps(),
//         '/campDetails': (context) => const CampDetails(),
//         '/userDetails': (context) => const UserDetails(),
//         '/hospitalDetails': (context) => const HospitalDetails(),
//         '/userCertificates': (context) => const DonorCertificates(),
//         '/certificateDetails': (context) => const CertificateDetails(),
//       },
//     );
//   }
// }
