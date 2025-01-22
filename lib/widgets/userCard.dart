import 'package:Life_Connect_admin/Model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 1.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.red, width: 1.4),
        boxShadow: const [
          BoxShadow(
            blurRadius: 3,
            color: Color.fromARGB(90, 0, 0, 0),
            offset: Offset(2, 1),
          ),
        ],
      ),
      child: ListTile(
        onTap: () =>
            Navigator.pushNamed(context, '/userDetails', arguments: user),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 23,
          backgroundImage: user.image != null
              ? NetworkImage(user.image ?? '')
              : const AssetImage('assets/man.png'),
        ),
        title: Text(
          user.name,
          style: GoogleFonts.nunitoSans(
            fontSize: 17.sp,
            color: Colors.red,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          user.address,
          style: GoogleFonts.roboto(),
        ),
      ),
    );
  }
}
