import 'package:Life_Connect_admin/Providers/userProvider.dart';
import 'package:Life_Connect_admin/widgets/customButton.dart';
import 'package:Life_Connect_admin/widgets/userCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

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
          'User',
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
                  Provider.of<UserProvider>(context, listen: false)
                      .searchUser(query),
              backgroundColor: const WidgetStatePropertyAll(
                  Color.fromARGB(255, 243, 243, 243)),
              leading: const Icon(Icons.search),
              hintText: 'Search',
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6))),
            ),
          ),
          Expanded(
            child: Consumer<UserProvider>(
              builder: (context, userProvider, _) {
                if (userProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (userProvider.errorMessage != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          userProvider.errorMessage!,
                          style: TextStyle(color: Colors.red, fontSize: 16.sp),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        CustomButton(
                            text: 'Refresh',
                            buttonType: ButtonType.Outlined,
                            isLoading: userProvider.isLoading,
                            onPressed: () => userProvider.loadUser())
                      ],
                    ),
                  );
                }

                if (userProvider.user.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No Users Available',
                          style: TextStyle(fontSize: 17.sp),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        CustomButton(
                            text: 'Refresh',
                            buttonType: ButtonType.Outlined,
                            isLoading: userProvider.isLoading,
                            onPressed: () => userProvider.loadUser())
                      ],
                    ),
                  );
                }

                if (userProvider.filteredUser.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No Users match your search.",
                          style: TextStyle(fontSize: 17.sp),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        CustomButton(
                            text: 'Refresh',
                            buttonType: ButtonType.Outlined,
                            isLoading: userProvider.isLoading,
                            onPressed: () => userProvider.loadUser())
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await userProvider.loadUser();
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 2.h),
                    itemCount: userProvider.filteredUser.length,
                    itemBuilder: (context, index) {
                      final user = userProvider.filteredUser[index];
                      return UserCard(user: user);
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
