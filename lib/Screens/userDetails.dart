import 'package:Life_Connect_admin/Model/UserModel.dart';
import 'package:Life_Connect_admin/Providers/userProvider.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key});

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
    final UserModel user =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    final userProvider = Provider.of<UserProvider>(context);

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
          'user Details',
          style: GoogleFonts.aBeeZee(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await userProvider.deleteUser(user.id, context);
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
              tag: user.id,
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
                  user.name,
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
                icon: Icons.bloodtype_outlined,
                title: 'Blood Group',
                value: user.bloodGroup,
                context: context),
            _buildDetailsCard(
                icon: Icons.email_outlined,
                title: 'Email',
                value: user.email,
                context: context),
            _buildDetailsCard(
                icon: Icons.location_on_outlined,
                title: 'Address',
                value: user.address,
                context: context),

            _buildDetailsCard(
                icon: Icons.phone_outlined,
                title: 'Phone',
                value: user.contactNumber.toString(),
                context: context),
            if (user.organsToDonate != null &&
                user.organsToDonate is List &&
                user.organsToDonate.isNotEmpty)
              _buildOrganList('Organs To Donate', Icons.local_hospital_outlined,
                  user.organsToDonate),
            _buildDetailsCard(
                icon: user.willingToDonateBlood
                    ? Icons.check_box_outlined
                    : Icons.check_box_outline_blank,
                title: 'Willing To Donate Blood',
                value: user.willingToDonateBlood ? 'Yes' : 'No',
                context: context),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard({
    required IconData icon,
    required String title,
    required String value,
    required BuildContext context,
    onTap,
  }) {
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

  Widget _buildOrganList(String title, IconData icon, List<dynamic> organList) {
    return Card(
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
                  Wrap(
                    spacing: 7.0,
                    children: organList.map<Widget>((organ) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          organ.toString(),
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.red,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
