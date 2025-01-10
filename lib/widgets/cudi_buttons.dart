import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants.dart';
import '../screens/components/icons/svg_icon.dart';
import '../theme.dart';

Padding buttonSpace(FilledButton button) {
  return Padding(
    padding: pd24202407,
    child: button,
  );
}

Padding button3Space(FilledButton button3, FilledButton button3second) {
  return Padding(
    padding: pd24202407,
    child: Row(
      children: [
        button3,
        sbw20,
        button3second,
      ],
    ),
  );
}

FilledButton button1(String text, void Function()? onPressed) {
  return FilledButton(
      style: FilledButton.styleFrom(
          backgroundColor: white,
          disabledBackgroundColor: Colors.transparent,
          padding: pd18v,
          minimumSize: buttonS,
          shape: RoundedRectangleBorder(
            borderRadius: buttonBr,
            side: onPressed != null ? BorderSide.none : buttonBs,
          )),
      onPressed: onPressed,
      child: Text(text,
          style: s16w700.copyWith(color: onPressed != null ? black : gray6F)));
}

FilledButton button2(String text, void Function()? onPressed) {
  return FilledButton(
      style: FilledButton.styleFrom(
          backgroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          padding: pd18v,
          minimumSize: buttonS,
          shape: RoundedRectangleBorder(
            borderRadius: buttonBr,
            side: button2bs,
          )),
      onPressed: onPressed,
      child: Text(text,
          style: s16w700.copyWith(color: onPressed != null ? white : gray6F)));
}

FilledButton button3(String text, void Function()? onPressed, [String? assetPath]) {
  return FilledButton(
      style: FilledButton.styleFrom(
          backgroundColor: white,
          disabledBackgroundColor: Colors.transparent,
          padding: pd24h18v,
          minimumSize: button3S,
          shape: RoundedRectangleBorder(
            borderRadius: buttonBr,
            side: onPressed != null ? BorderSide.none : buttonBs,
          )),
      onPressed: onPressed,
      child:
      Row(
        mainAxisAlignment: assetPath != null
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: [
          Text(text, style: s16w700),
          if(assetPath != null) Image.asset(assetPath, width: 20.w, height: 20.h),
        ],
      )
  );
}

FilledButton button4(String text, void Function()? onPressed, bool isSelected) {
  return FilledButton(
    onPressed: onPressed,
    style: FilledButton.styleFrom(
      backgroundColor: isSelected ? primary : Colors.transparent,
      padding: pd20h12v,
      shape: RoundedRectangleBorder(
        borderRadius: buttonBr2,
        side: BorderSide(
          color: isSelected ? primary : grayEA,
          width: 1.w,
        ),
      ),
    ),
    child: Text(text, style: w500.copyWith(color: isSelected ? white : gray80)),
  );
}



// ElevatedButton outlinedButton({required String text, void Function()? click, required bool isSelected}) {
//   return ElevatedButton(
//     onPressed: click,
//     style: ElevatedButton.styleFrom(
//       elevation: 0.0,
//       backgroundColor: isSelected ? primary : Colors.transparent,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//         side: BorderSide(
//           color: isSelected ? primary : gray80,
//           width: 1,
//         ),
//       ),
//     ),
//     child: Text(text, style: w500.copyWith(color: Colors.white, height: 1.0)),
//   );
// }
//
// Widget launchFillButton(String text, void Function()? click) {
//   return ElevatedButton(
//     style: ElevatedButton.styleFrom(
//       side: const BorderSide(
//         width: 1.0,
//         color: white,
//       ),
//       backgroundColor: white,
//       textStyle: loginStyle,
//       padding: pd24h20v,
//       // 버튼 패딩 설정
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//     ),
//     onPressed: click,
//     child: Text(text,
//         style: TextStyle(color: click != null ? black : gray6F)),
//   );
// }
//
// Widget launchLineButton(String text, void Function()? click) {
//   return ElevatedButton(
//     style: ElevatedButton.styleFrom(
//       side: const BorderSide(
//         width: 1.0,
//         color: white,
//       ),
//       backgroundColor: black,
//       textStyle: loginStyle,
//       padding: pd24h20v,
//       // 버튼 패딩 설정
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.w),
//       ),
//     ),
//     onPressed: click,
//     child: Text(text,
//         style: TextStyle(color: click != null ? white : gray6F)),
//   );
// }
//
// Widget cudiBackgroundButton(String text, void Function()? click) {
//   return ElevatedButton(
//     style: ElevatedButton.styleFrom(
//       backgroundColor: white,
//       disabledBackgroundColor: Colors.transparent,
//       textStyle: loginStyle,
//       padding: const EdgeInsets.symmetric(vertical: 18.0),
//       minimumSize: const Size(400, 56),
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.w),
//           side: const BorderSide(
//             color: Color(0xff3D3D3D),
//           )),
//     ),
//     onPressed: click,
//     child: Text(text,
//         style: TextStyle(
//             color: click != null ? black : gray6F,
//             fontWeight: FontWeight.w700)),
//   );
// }

// Widget viewCafeButtonDark(String text, void Function()? click) {
//   return Container(
//     padding: EdgeInsets.all(5.0),
//     height: 42.5,
//     child: ElevatedButton(
//       onPressed: click,
//       style: ElevatedButton.styleFrom(
//         padding: EdgeInsets.all(0.0),
//         backgroundColor: cudiDark,
//         textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0),
//         minimumSize: Size(100.0, 42.5),
//         // 최소 크기를 설정
//         maximumSize: Size(100.0, 42.5),
//         // 최대 크기를 설정 (최소 크기와 동일하게 설정하여 크기를 고정)
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0), // 모서리를 둥근 직사각형으로 설정
//         ),
//         elevation: 0.0,
//       ),
//       child: Text(text),
//     ),
//   );
// }

// Widget viewCafeButtonDarkLarge(String text, void Function()? click) {
//   return Container(
//     // padding: EdgeInsets.all(5.0),
//     height: 45.0,
//     child: ElevatedButton(
//       onPressed: click,
//       style: ElevatedButton.styleFrom(
//         padding: EdgeInsets.symmetric(horizontal: 15.0),
//         backgroundColor: cudiDark,
//         textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
//         // minimumSize: Size(50.0, 42.5),
//         // // 최소 크기를 설정
//         maximumSize: Size(125.0, 45.0),
//         // 최대 크기를 설정 (최소 크기와 동일하게 설정하여 크기를 고정)
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.0), // 모서리를 둥근 직사각형으로 설정
//         ),
//         elevation: 0.0,
//       ),
//       child: Text(text),
//     ),
//   );
// }

// Widget viewCafeIconButtonDark(Icon icon, void Function()? click) {
//   return Container(
//     height: 30.0,
//     width: 30.0,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(5.0),
//       color: cudiDark,
//     ),
//     child: IconButton(onPressed: click, icon: icon, padding: EdgeInsets.zero),
//   );
// }

// Widget popButton(BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.fromLTRB(10, 60, 0, 0),
//     child: InkWell(
//       onTap: () => Navigator.pop(context),
//       child: Container(
//         width: 30,
//         height: 30,
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.white),
//           borderRadius: BorderRadius.circular(5.0),
//         ),
//         child: const Icon(
//           Icons.arrow_back_ios_new,
//           size: 16.0,
//           color: Colors.white,
//         ),
//       ),
//     ),
//   );
// }

Widget cudiHorizonListButton(
    String text, String icon, void Function()? click, bool isSelected) {
  return Padding(
    padding: const EdgeInsets.only(right: 6.0),
    child: ElevatedButton(
      onPressed: click,
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        backgroundColor: isSelected ? white : gray2E,
        // 기본 배경 색상을 흰색으로 설정하고 select되면 흰색
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          // side: BorderSide(
          //   color: isSelected ? primary : Colors.white, // 테두리 컬러 조정
          // ),
        ), // 모서리를 둥근 직사각형으로 설정
      ),
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 14.0,
            height: 14.0,
          ),
          const SizedBox(width: 4.0),
          Text(
            text,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: isSelected ? gray2E : gray79,
            ),
          ),
        ],
      ),
    ),
  );
}

// Widget menuHorizonListButton(
//     String text, void Function()? click, bool isSelected) {
//   return Padding(
//     padding: EdgeInsets.only(right: 8.w),
//     child: FilledButton(
//       onPressed: click,
//       style: ElevatedButton.styleFrom(
//         elevation: 0.0,
//         backgroundColor: isSelected ? primary : white,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8.0),
//             side: BorderSide(
//               color: isSelected ? Colors.white : grayEA,
//               width: 1,
//             )),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           fontSize: 16.0,
//           fontWeight: FontWeight.w500,
//           color: isSelected ? white : gray80,
//         ),
//       ),
//     ),
//   );
// }

Widget cudiNotifiHorizonListButton(
    String text, void Function()? click, bool isSelected) {
  return Container(
    height: 32.0,
    padding: const EdgeInsets.only(right: 8.0),
    child: ElevatedButton(
      onPressed: click,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        elevation: 0.0,
        backgroundColor: isSelected ? primary : Colors.transparent,
        // 배경 색상을 흰색으로 설정
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: isSelected ? primary : gray80, // 테두리 컬러 조정
          ),
        ), // 모서리를 둥근 직사각형으로 설정
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          height: 1,
          color: isSelected?Colors.white : grayEA, // 텍스트 색상을 검정색으로 설정
        ),
      ),
    ),
  );
}

Widget viewCafeHorizonListButton(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6.0),
    child: ElevatedButton(
      onPressed: null,
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        // textStyle: TextStyle(fontWeight: ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: primary, // 테두리 컬러 조정
            width: 1.2,
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: primary, // 텍스트 색상을 검정색으로 설정
        ),
      ),
    ),
  );
}

FilledButton whiteButton(String text, dynamic icon, void Function()? click) {
  final MaterialStateProperty<Color?> back =
  MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return primary;
      }
      return gray3D;
    },
  );
  return FilledButton(
    style: ButtonStyle(
      minimumSize: MaterialStatePropertyAll(Size(0,56.h)),
      backgroundColor: const MaterialStatePropertyAll(white),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.w)))
    ),
    onPressed: click,
    child: Row(
      mainAxisAlignment: icon != null
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.center,
      children: [
        Text(text, style: s16w700),
        icon != null ? Image.asset(icon, width: 20.w, height: 20.h) : const SizedBox(),
      ],
    ),
  );
}

Widget cupButton(
    String text, void Function()? click, bool isSelected) {
  return Container(
    // padding: const EdgeInsets.only(right: 20.0),
    child: ElevatedButton(
      onPressed: click,
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        backgroundColor: isSelected ? primary : white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
              color: isSelected ? white : Color(0xffEAEAEA),
              width: 1,
            )),
        // padding: EdgeInsets.zero,
        //   maximumSize: Size(161.0, 40.0),
        // minimumSize: Size(161.0, 40.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: isSelected ? white : Color(0xff808285),
        ),
      ),
    ),
  );
}

Widget smallButton({required String text, void Function()? click, String? iconAsset}) {
  return Padding(
    padding: const EdgeInsets.only(right: 8.0),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        textStyle: const TextStyle(color: grayEA, fontSize: 12.0),
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),
        // 버튼 패딩 설정
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1.0,
            color: gray80,
          ),
          borderRadius: BorderRadius.circular(8.0), // 모서리를 둥근 직사각형으로 설정
        ),
      ),
      onPressed: click,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
        child:
            Row(
              children: [
                svgIcon(iconAsset ?? ''),
                SizedBox(width: 4.0,),
                Text(text, style: TextStyle(color: click != null ? white : gray6F)),
              ],
            ),
      ),
    ),
  );
}

Widget primaryButton(String text, VoidCallback click) {
  return FilledButton(
      onPressed: click,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(const Size(100.0, 48.0)),
        // 버튼 높이 설정
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        // 글자색
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // 모서리 둥글기 설정
          ),
        ),
      ),
      child: Text(text, style: w500));
}
