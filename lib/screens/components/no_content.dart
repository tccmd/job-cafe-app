import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';

class NoContent extends StatelessWidget {
  final String imgUrl;
  final double imgWidth;
  final double imgHeight;
  final String title;
  final String subTitle;
  final String btnText;
  final void Function()? function;

  const NoContent(
      {super.key,
      required this.imgUrl,
      required this.imgWidth,
      required this.imgHeight,
      required this.title,
      required this.subTitle,
      required this.btnText,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 114.0.h,
          ),
          Container(
              height: 160.0,
              alignment: const Alignment(0.0, 1.0),
              child: Image.asset(
                imgUrl,
                width: imgWidth,
                height: imgHeight,
              )),
          SizedBox(
            height: 32.h,
          ),
          Text(
            title,
            style: s16w600.copyWith(height: 1),
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            subTitle,
            style: h17.copyWith(color: grayB5),
          ),
          SizedBox(
            height: 32.h,
          ),
          Container(
              width: 390.w,
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ElevatedButton(
                  onPressed: function,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Padding(
                    padding: pd24h18v,
                    child: Text(
                      btnText,
                      style: s16w700.copyWith(height: 1, color: black),
                    ),
                  ))),
        ],
      ),
    );
  }
}
