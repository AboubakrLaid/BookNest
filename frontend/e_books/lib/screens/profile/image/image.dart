// ignore_for_file: use_build_context_synchronously

import 'package:dotted_border/dotted_border.dart';
import 'package:e_books/screens/profile/profile_provider.dart';
import 'package:e_books/util/export.dart';
import 'package:e_books/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationImage extends StatelessWidget {
  const RegistrationImage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget getText(String text) {
      return Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          color: const Color(0xFFFFFFFF),
        ),
      );
    }

    return Consumer<ProfileProvider>(
      builder: (context, state, child) => InkWell(
        onTap: () async {
          final bool? isImagePicked =
              await state.pickImage(source: ImageSource.gallery);
          if (isImagePicked == null) {
            showCustomSnackBar(
              context,
              content: getText("error occured when picking image"),
              backgroundColor: const Color(0xFFF44336),
            );
          } else if (isImagePicked == false) {
            showCustomSnackBar(
              context,
              content: getText("please pick an image"),
              backgroundColor: const Color(0xFFF44336),

            );
          } else {
            // showCustomSnackBar(context, content: const Text("image picked successfully"));}
            print("image picked successfully");
          }
        },
        child: DottedBorder(
          borderType: BorderType.RRect,
          color:state.image == null ? const Color(0xFFFFFFFF) : context.theme.primaryColor,
          dashPattern: const [6.5, 6.5],
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 21.h),
            child: Column(
              children: [
                 state.image == null ? Icon(
                  Icons.add_a_photo,
                  size: 100.dm,
                  color: const Color(0xFFFFFFFF),
                ) : ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: Image.file(
                    state.image!,
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  state.image == null ? "Add profile Photo" : "Change profile Photo",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFFFFFFF),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
