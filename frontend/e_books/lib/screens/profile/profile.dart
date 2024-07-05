import 'package:e_books/screens/profile/components/categories.dart';
import 'package:e_books/screens/profile/components/complete_register_button.dart';
import 'package:e_books/screens/profile/components/profile_text_field.dart';
import 'package:e_books/screens/profile/image/image.dart';
import 'package:e_books/screens/profile/profile_provider.dart';
import 'package:e_books/util/export.dart';
import 'package:e_books/widgets/book_nest_logo.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void dispose() {
        final ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
        profileProvider.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppThemeProvider.darkTheme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: kHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0.w),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 31.w),
                      child: const BookNestLogo(),
                    ),
                    Text(
                      "Please complete your\n personal Information",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0.w),
                child: const SizedBox(
                  width: double.maxFinite,
                  child: RegistrationImage(),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0.w),
                child: Form(
                  key: profileProvider.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //  Gap(20.h),
                      ProfileTextField(
                        hintText: "First Name",
                        controller: profileProvider.firstNameController,
                      ),

                      Gap(40.h),
                      ProfileTextField(
                        hintText: "Last Name",
                        controller: profileProvider.lastNameController,
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Categories(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 70.w),
                child: const CompleteRegisterButton(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
