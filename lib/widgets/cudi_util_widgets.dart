import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';
import '../screens/components/icons/svg_icon.dart';

Future cudiDialog(BuildContext context, String title, String desc,
    {String? button1Text,
      String? button2Text,
    void Function()? button1Function,
    void Function()? button2Function}) {
  return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        var padding = EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h);
        var padding2 = EdgeInsets.symmetric(horizontal: 48.w, vertical: 20.h);
        // 배경 흐리게
        return Container(
          decoration: BoxDecoration(
            color: gray1C.withOpacity(0.48),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: AlertDialog(
                  contentPadding: pd0,
                elevation: 0,
              content: Container(
                color: Colors.black,
                constraints: const BoxConstraints.tightForFinite(), // Set constraints to expand
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
                  children: [
                    Container(
                      padding: padding,
                      child: Column(
                        children: [
                          Text(title, style: s16w600),
                          sbh12,
                          Text(desc,
                            textAlign: TextAlign.center,
                            style: h17.copyWith(color: grayB5),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: gray3D, height: 1.h),
                    Container(
                      padding: padding2,
                      child: Container(
                        //color: Colors.blue,
                        child: Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Container(
                                  child: GestureDetector(
                                    onTap: button1Function ??
                                            () => Navigator.pop(context),
                                    child: Text(button1Text ?? '아니오',
                                        style: s16w700),
                                  ),
                                ),
                              ),
                            ),
                            if (button1Text == null && button2Text == null)
                              Expanded(
                                child: Center(
                                  child: Container(
                                    //color: Colors.yellow,
                                    child: GestureDetector(
                                      onTap: button2Function ??
                                              () => Navigator.pop(context),
                                      child: Text(button2Text ?? '예',
                                          style: s16w700.copyWith(
                                              color: primary)),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // title: Text(title, style: s16w600),
              // content: Text(desc,
              //       textAlign: TextAlign.center,
              //       style: h17.copyWith(color: grayB5)),
            ),
          ),
        );
      });
}

// void snackBar(BuildContext context, String message,
//     {String? label, void Function()? click, double? margin}) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       backgroundColor: const Color.fromRGBO(0, 0, 0, 0.72),
//       content: GestureDetector(
//           onTap: click ?? () {},
//           child:
//               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             Text(message, style: TextStyle(fontSize: 14.sp), maxLines: 1, softWrap: true, overflow: TextOverflow.ellipsis),
//             if (click != null)
//               Row(
//                 children: [
//                   Text(label ?? ''),
//                   svgIcon(
//                     'assets/icon/ico-line-arrow-right-white-24px.svg',
//                     width: 16,
//                   )
//                 ],
//               )
//           ])),
//       duration: const Duration(milliseconds: 2000),
//       padding: pd20h10w,
//       behavior: SnackBarBehavior.floating,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.h),
//       ),
//       margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: margin ?? 100),
//     ),
//   );
// }

void snackBar(BuildContext context, String message,
    {String? label, void Function()? onClick, double? margin}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0.72),
      content: GestureDetector(
        onTap: onClick ?? () {},
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: TextStyle(fontSize: 14.sp),
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.fade, // 텍스트가 너무 길면 페이딩 처리
              ),
              if (onClick != null)
                Row(
                  children: [
                    Text(label ?? ''),
                    svgIcon(
                      'assets/icon/ico-line-arrow-right-white-24px.svg')
                  ],
                )
            ],
          ),
        ),
      ),
      duration: const Duration(milliseconds: 2000),
      padding: pd20h10w,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.h),
      ),
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: margin ?? 100),
    ),
  );
}


void showError(BuildContext context, [dynamic e]) {
  snackBar(context, "$e" ?? "error");
}

void navigateToNextScreen(BuildContext context, Widget screen,
    {int? duration}) {
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: duration ?? 700),
      pageBuilder: (_, __, ___) => screen,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    ),
  );
}