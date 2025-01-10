import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';
import '../../theme.dart';
import 'closed_sheet.dart';

class BottomSheetOpened extends StatelessWidget {
  final Widget body;
  final List<BottomSheetItem>? bottomSheetItems;
  final EdgeInsets? pd0;
  const BottomSheetOpened({super.key, required this.body, this.bottomSheetItems, this.pd0});

  @override
  Widget build(BuildContext context) {
    double androidStatus = MediaQuery.of(context).systemGestureInsets.top; // 안드로이드 상태바 사이즈
    double iosStatus = MediaQuery.of(context).padding.bottom + MediaQuery.of(context).viewPadding.bottom;
    double sheetHeight = MediaQuery.of(context).size.height - (iosStatus + androidStatus); // + homeIndicator);
    double sheetHeightWithButton = sheetHeight - buttonWidgetSize - homeIndicator;
    double sheetBodyHeight = sheetHeight - dividerSize;
    double sheetBodyHeightWithButton = sheetHeightWithButton - dividerSize;

    return Container(
      color: black,
      height: sheetHeight, // 시트 전체 크기
      child: Column(
        children: [
          Container(
            height: bottomSheetItems != null ? sheetHeightWithButton : sheetHeight, // 버튼 부분을 뺀 하얀 부분
            decoration: bottomSheetItems != null ? sheetShape : sheetShape2,
            child: Column(
              children: [
                sheetDivider(),
                Padding(
                  padding: pd0 ?? pd24h,
                  child: SizedBox(
                    height: bottomSheetItems != null ? sheetBodyHeightWithButton : sheetBodyHeight - homeIndicator, // SE에서 에러나서 5 추가 함
                    child: body
                  ),
                ),
              ],
            ),
          ),
          if(bottomSheetItems != null) SheetButton(bottomSheetItems: bottomSheetItems!)
        ],
      ),
    );
  }
}