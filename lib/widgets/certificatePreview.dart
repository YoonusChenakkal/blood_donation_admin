import 'package:Life_Connect_admin/Model/certificateModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class CertificatePreview extends StatelessWidget {
  final CertificateModel certificate;
  const CertificatePreview({super.key, required this.certificate});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 31.h,
      width: 90.w,
      margin: EdgeInsets.only(top: 3.h, bottom: 4.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
              image: AssetImage('assets/certificate.png'), fit: BoxFit.cover)),
      child: Stack(
        children: [
          Center(
            child: Text(certificate.username,
                style: GoogleFonts.baskervville(fontSize: 20.sp)),
          ),
          Positioned(
              bottom: 11.h,
              left: 22.w,
              child: Text('Here He/She pledge for Organ Donation',
                  style: TextStyle(fontSize: 11.5.sp))),
          Positioned(
              bottom: 6.h,
              left: 21.w,
              child: Text(
                  DateFormat('dd-MM-yyyy').format(certificate.consentDate),
                  style: GoogleFonts.afacad(fontSize: 14.sp))),
          Positioned(
              bottom: 6.h,
              right: 25.w,
              child: Image.network(
                certificate.signImageUrl,
                height: 4.h,
                width: 10.w,
              ))
        ],
      ),
    );
  }
}
