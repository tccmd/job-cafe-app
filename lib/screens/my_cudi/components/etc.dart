import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants.dart';
import '../../components/big_text.dart';

Widget titleWidget({required String title}) {
  return Text(title, style: s16w500);
}

Widget secessionBigText(String imgURL, String bigString) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sbh24,
      Image.asset(imgURL, width: 56.w),
      bigText(bigString),
    ],
  );
}