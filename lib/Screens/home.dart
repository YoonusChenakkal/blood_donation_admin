import 'package:Life_Connect_admin/Providers/campsProvider.dart';
import 'package:Life_Connect_admin/Providers/hospitalProvider.dart';
import 'package:Life_Connect_admin/Providers/userProvider.dart';
import 'package:Life_Connect_admin/widgets/customBanner.dart';
import 'package:Life_Connect_admin/widgets/customCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final hospitaProvider = Provider.of<HospitalProvider>(context);
    final campProvider = Provider.of<Campsprovider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, Admin',
              style: GoogleFonts.archivo(
                fontSize: 19.sp,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'welcome',
              style: GoogleFonts.archivo(
                fontSize: 18.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 9.h,
        actions: [
          Container(
            width: 7.h,
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
        ],
      ),
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              CustomBanner(
                title1: 'Donate If You Can\nSave One Life',
                title2: 'Make them happy',
                textColor: Colors.white,
                buttonText: 'View',
                onPressed: () => showDonationDialog(context),
                imageUrl: 'assets/bg_surgery.jpg',
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.5.w),
                child: Row(
                  children: [
                    CustomCard(
                      title: 'Total\nDonors',
                      count: userProvider.user.length.toString(),
                      image: Image.asset(
                        'assets/donors.png',
                        height: 3.h,
                      ),
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    CustomCard(
                      title: 'Total\nHospitals',
                      count: hospitaProvider.hospitals.length.toString(),
                      image: Image.asset(
                        'assets/hospital-1.png',
                        height: 4.h,
                      ),
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    CustomCard(
                      title: 'Total\nCamps',
                      count: campProvider.camp.length.toString(),
                      image: Image.asset(
                        'assets/camp.png',
                        height: 4.h,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 2.h,
                  left: 3.5.w,
                  bottom: 1.h,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Camps',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              CustomBanner(
                title1: 'Scheduled Camps',
                title2:
                    'Scheduled hospital camps connect donors, allowing them to register  ',
                buttonText: 'View',
                textColor: Colors.black,
                onPressed: () => Navigator.pushNamed(context, '/camps'),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 1.5.h,
                  left: 3.5.w,
                  bottom: 1.h,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Certificates',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              CustomBanner(
                title1: 'Donor Certificate',
                title2: 'Certificates of donors who genarated certificate',
                buttonText: 'View',
                textColor: Colors.black,
                onPressed: () =>
                    Navigator.pushNamed(context, '/userCertificates'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showDonationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Container(
            padding: EdgeInsets.all(4.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Donate If You Can Save One Life',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.h),
                Text(
                  'Every donation can change a life! You have the power to save lives and make a positive impact on the community. Every drop counts!',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.h),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Close',
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.redAccent),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
