import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: primary,
        onPrimary: black,
        secondary: Colors.black12,
        onSecondary: Colors.green,
        error: Colors.red,
        onError: Colors.redAccent,
        onBackground: Colors.black12,
        surface: white,
        // 스낵바 글자색
        onSurface: white),
    fontFamily: 'Pretendard',
    scaffoldBackgroundColor: black,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: black
    )
  );
}

// 바텀 시트 버튼
double buttonWidgetSize = 83.h;

// 바텀 시트 모양
BoxDecoration sheetShape = BoxDecoration(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(16.w),
      bottomRight: Radius.circular(16.w),
    ),
    color: white);
BoxDecoration sheetShape2 = BoxDecoration(color: white);

// 마테리얼 스타일
Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return primary.withAlpha(150);
  }
  return white;
}

// Button Theme
Size buttonS = Size(342.w, 56.h);
BorderRadius buttonBr = BorderRadius.circular(12.w);
BorderRadius buttonBr2 = BorderRadius.circular(8.w);
BorderSide buttonBs = BorderSide(color: gray3D);
RoundedRectangleBorder buttonRrb =
    RoundedRectangleBorder(borderRadius: buttonBr);
BorderSide button2bs = BorderSide(color: white);
Size button3S = Size(161.w, 56.h);

// 컨테이너 디자인
BoxDecoration bottomBorder = const BoxDecoration(
  border: Border(
    bottom: BorderSide(color: gray1C),
  ),
);

BoxDecoration bottomBorderMenuItem = const BoxDecoration(
  border: Border(
    bottom: BorderSide(
      color: grayEA,
    ),
  ),
);
// 카트, 오더 스택
BoxDecoration bottomStack = const BoxDecoration(
  color: black,
  border: Border(
    top: BorderSide(
      color: gray3D,
    ),
  ),
);

// 디바이더
Divider divider = Divider(color: grayEA, height: 1.h);
Divider dividerMy = const Divider(color: gray1C, height: 1);
