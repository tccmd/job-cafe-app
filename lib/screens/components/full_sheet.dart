import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';
import 'icons/svg_icon.dart';
import '../../theme.dart';

class FullSheet extends StatefulWidget {
  final String title;
  final Widget body;
  final Widget button;

  const FullSheet(
      {Key? key, required this.title, required this.body, required this.button})
      : super(key: key);

  @override
  State<FullSheet> createState() =>
      _FullWithButtonSheetState();
}

class _FullWithButtonSheetState extends State<FullSheet> {
  @override
  Widget build(BuildContext context) {
    double androidStatus = MediaQuery.of(context).systemGestureInsets.top; // 안드로이드 상태바 사이즈
    double iosStatus = MediaQuery.of(context).padding.bottom + MediaQuery.of(context).viewPadding.bottom;
    double sheetHeight = MediaQuery.of(context).size.height - (iosStatus + androidStatus);
    return Container(
      height: sheetHeight,
      color: black,
      child: Column(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height - 83.h - MediaQuery.of(context).padding.bottom - 5.5,
            decoration: sheetShape,
            child: Column(
              children: [
                SizedBox(height: h54),
                top(),
                widget.body,
              ],
            ),
          ),
          widget.button,
        ],
      ),
    );
  }

  Widget top() {
    return Padding(
      padding: pd24h16v,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 20.w),
          Text(widget.title, style: s20w600.copyWith(color: black)),
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            shape: const CircleBorder(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const EdgeInsets.all(0),
            minWidth: 20.w,
            height: 20.h,
            child: svgIcon(
                'assets/icon/ico-line-close-default-light-20px.svg'),
          ),
        ],
      ),
    );
  }
}
