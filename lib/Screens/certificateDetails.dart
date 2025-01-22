import 'package:Life_Connect_admin/Model/certificateModel.dart';
import 'package:Life_Connect_admin/widgets/certificatePreview.dart';
import 'package:Life_Connect_admin/widgets/customButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class CertificateDetails extends StatelessWidget {
  const CertificateDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final CertificateModel certificate =
        ModalRoute.of(context)!.settings.arguments as CertificateModel;

    openCertificate() async {
      if (certificate.certificateUrl.isNotEmpty) {
        await launchUrl(Uri.parse(certificate.certificateUrl));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Unable to Open Map')));
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.redAccent,
          ),
        ),
        toolbarHeight: 8.h,
        title: Text(
          'certificate Details',
          style: GoogleFonts.aBeeZee(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            CertificatePreview(
              certificate: certificate,
            ),
            CustomButton(
                text: 'Download',
                buttonType: ButtonType.Elevated,
                onPressed: () => openCertificate()),
          ],
        ),
      ),
    );
  }
}
