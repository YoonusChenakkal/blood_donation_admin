import 'package:Life_Connect_admin/Providers/hospitalProvider.dart';
import 'package:Life_Connect_admin/widgets/customButton.dart';
import 'package:Life_Connect_admin/widgets/hospitalCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HospitalList extends StatelessWidget {
  const HospitalList({super.key});

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
          'Hospitals',
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
                  Provider.of<HospitalProvider>(context, listen: false)
                      .searchhospitals(query),
              backgroundColor: const WidgetStatePropertyAll(
                  Color.fromARGB(255, 243, 243, 243)),
              leading: const Icon(Icons.search),
              hintText: 'Search',
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6))),
            ),
          ),
          Expanded(
            child: Consumer<HospitalProvider>(
              builder: (context, hospitalProvider, _) {
                if (hospitalProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (hospitalProvider.errorMessage != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          hospitalProvider.errorMessage!,
                          style: TextStyle(color: Colors.red, fontSize: 16.sp),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        CustomButton(
                            text: 'Refresh',
                            buttonType: ButtonType.Outlined,
                            isLoading: hospitalProvider.isLoading,
                            onPressed: () => hospitalProvider.fetchHospitals())
                      ],
                    ),
                  );
                }

                if (hospitalProvider.hospitals.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No Hospitals Available',
                          style: TextStyle(fontSize: 17.sp),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        CustomButton(
                            text: 'Refresh',
                            buttonType: ButtonType.Outlined,
                            isLoading: hospitalProvider.isLoading,
                            onPressed: () => hospitalProvider.fetchHospitals())
                      ],
                    ),
                  );
                }

                if (hospitalProvider.filteredhospitals.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No Hospitals match your search.",
                          style: TextStyle(fontSize: 17.sp),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        CustomButton(
                            text: 'Refresh',
                            buttonType: ButtonType.Outlined,
                            isLoading: hospitalProvider.isLoading,
                            onPressed: () => hospitalProvider.fetchHospitals())
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await hospitalProvider.fetchHospitals();
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 2.h),
                    itemCount: hospitalProvider.filteredhospitals.length,
                    itemBuilder: (context, index) {
                      final hospital =
                          hospitalProvider.filteredhospitals[index];
                      return HospitalCard(hospital: hospital);
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
