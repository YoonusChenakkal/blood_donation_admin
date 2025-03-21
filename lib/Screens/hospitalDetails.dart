import 'package:Life_Connect_admin/Model/hospitalModel.dart';
import 'package:Life_Connect_admin/Providers/hospitalProvider.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HospitalDetails extends StatelessWidget {
  const HospitalDetails({super.key});

  String formatDate(DateTime? date) {
    if (date == null) return 'Unknown Date';
    return DateFormat('MMMM d, yyyy').format(date);
  }

  String formatTime(String? time) {
    if (time == null) return 'Unknown Time';
    try {
      final parsedTime = DateFormat("HH:mm:ss").parse(time);
      return DateFormat("h:mm a").format(parsedTime);
    } catch (e) {
      return 'Invalid Time';
    }
  }

  @override
  Widget build(BuildContext context) {
    final HospitalModel hospital =
        ModalRoute.of(context)!.settings.arguments as HospitalModel;
    final hospitalProvider = Provider.of<HospitalProvider>(context);

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
          'Hospital Details',
          style: GoogleFonts.aBeeZee(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await hospitalProvider.deleteHospital(hospital.id, context);
            },
            icon: const Icon(Icons.delete),
            color: Colors.white,
          )
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Header
            Hero(
              tag: hospital.id,
              child: Container(
                width: 100.w,
                margin: EdgeInsets.all(4.w),
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [Colors.redAccent, Colors.pinkAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 12,
                      color: Colors.black.withOpacity(0.15),
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Text(
                  hospital.name ?? 'No Name',
                  style: GoogleFonts.nunitoSans(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // Details Section

            _buildDetailsCard(
                icon: Icons.email_outlined,
                title: 'Email',
                value: hospital.email,
                context: context),
            _buildDetailsCard(
                icon: Icons.location_on_outlined,
                title: 'Address',
                value: hospital.address,
                context: context),

            _buildDetailsCard(
                icon: Icons.phone_outlined,
                title: 'Phone',
                value: hospital.contactNumber.toString(),
                context: context),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard(
      {required IconData icon,
      required String title,
      required String value,
      required BuildContext context,
      onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: .5.h),
        elevation: 6,
        shadowColor: Colors.black45,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(3.w),
          child: Row(
            children: [
              Icon(icon, size: 6.w, color: Colors.redAccent),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onLongPress: () => {
        Clipboard.setData(ClipboardData(
          text: value,
        )),
        HapticFeedback.vibrate(),
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'Copied',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor:
                Colors.transparent, // Make the background invisible
            elevation: 0, // Remove shadow
            duration: const Duration(milliseconds: 200),
          ),
        )
      },
    );
  }
}
