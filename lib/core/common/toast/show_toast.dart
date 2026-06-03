import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../theme/app_colors.dart';

class ShowToast {
  const ShowToast._();

  static void showToastErrorTop({required String message, int seconds = 3}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: seconds,
      backgroundColor: MyColors.error,
      textColor: Colors.white,
      fontSize: 14.sp,
    );
  }

  static void showToastSuccessTop({required String message, int seconds = 2}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: seconds,
      backgroundColor: MyColors.success,
      textColor: Colors.white,
      fontSize: 14.sp,
    );
  }

  static void showToastInfoTop({required String message, int seconds = 2}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: seconds,
      backgroundColor: MyColors.info,
      textColor: Colors.white,
      fontSize: 14.sp,
    );
  }
}
