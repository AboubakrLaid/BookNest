import 'package:e_books/util/export.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';


void showCustomSnackBar(BuildContext context, {required Widget content, bool onTop = false, Color? backgroundColor, int widgetLegth = 1}){
  // widgetLegth = 1;
  double offset = 0.92;
  SnackBar snackBar= SnackBar(
    
      content: SingleChildScrollView(child: content),
      backgroundColor:backgroundColor?.withOpacity(0.7) ?? Theme.of(context).primaryColor.withOpacity(0.7),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      dismissDirection: onTop ? DismissDirection.up : DismissDirection.down,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color:backgroundColor ?? Theme.of(context).primaryColor, width: 1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: const EdgeInsets.only(left: 10.0),
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        top: onTop ? 10 : 0,
        bottom: onTop ? kHeight* offset : 10,
      ),
    );
    
    EasyDebounce.debounce('snack_bar', const Duration(milliseconds: 500), () {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
}
