import 'package:Life_Connect_admin/Providers/certificateProvider%20.dart';
import 'package:Life_Connect_admin/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class DonorCertificates extends StatelessWidget {
  const DonorCertificates({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 8.h,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Certificates',
          style:
              GoogleFonts.aBeeZee(fontSize: 23.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5.h,
            width: 90.w,
            child: SearchBar(
              onChanged: (query) =>
                  Provider.of<CertificateProvider>(context, listen: false)
                      .searchcertificates(query),
              backgroundColor: const WidgetStatePropertyAll(
                  Color.fromARGB(255, 243, 243, 243)),
              leading: const Icon(Icons.search),
              hintText: 'Search',
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6))),
            ),
          ),
          Expanded(
            child: Consumer<CertificateProvider>(
              builder: (context, certificateProvider, _) {
                if (certificateProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (certificateProvider.errorMessage != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          certificateProvider.errorMessage!,
                          style: TextStyle(color: Colors.red, fontSize: 16.sp),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        CustomButton(
                            text: 'Refresh',
                            buttonType: ButtonType.Outlined,
                            isLoading: certificateProvider.isLoading,
                            onPressed: () =>
                                certificateProvider.fetchCertificates())
                      ],
                    ),
                  );
                }

                if (certificateProvider.certificates.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No Certificates Available',
                          style: TextStyle(fontSize: 17.sp),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        CustomButton(
                            text: 'Refresh',
                            buttonType: ButtonType.Outlined,
                            isLoading: certificateProvider.isLoading,
                            onPressed: () =>
                                certificateProvider.fetchCertificates())
                      ],
                    ),
                  );
                }

                if (certificateProvider.filteredCertificates.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No Certificate match your search.",
                          style: TextStyle(fontSize: 17.sp),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        CustomButton(
                            text: 'Refresh',
                            buttonType: ButtonType.Outlined,
                            isLoading: certificateProvider.isLoading,
                            onPressed: () =>
                                certificateProvider.fetchCertificates())
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await certificateProvider.fetchCertificates();
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 2.h),
                    itemCount: certificateProvider.filteredCertificates.length,
                    itemBuilder: (context, index) {
                      final certificate =
                          certificateProvider.filteredCertificates[index];
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 3.5.w, vertical: 1.h),
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
                          onTap: () => Navigator.pushNamed(
                              context, '/certificateDetails',
                              arguments: certificate),
                          title: Text(
                            certificate.username,
                            style: GoogleFonts.nunitoSans(
                              fontSize: 17.sp,
                              color: Colors.red,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          subtitle: Text(
                            DateFormat('MMMM dd/yy')
                                .format(certificate.consentDate),
                            style: GoogleFonts.roboto(),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
