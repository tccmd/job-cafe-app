import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants.dart';

class ThreeDIcon extends StatelessWidget {
  final String? storeThreeDUrl;

  const ThreeDIcon({Key? key, required this.storeThreeDUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32.w,
      height: 32.h,
      child: IconButton(
        onPressed: () => Navigator.pushNamed(context, "/web_view",
            arguments: {"threeDUrl": storeThreeDUrl}),
        icon: Image.asset('assets/icon/view_3d.png'),
        constraints: const BoxConstraints(), // 아이콘 패딩 제거
        padding: pd0,
      ),
    );
  }
}