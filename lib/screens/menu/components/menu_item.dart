import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants.dart';
import '../../../models/menu.dart';
import '../../../theme.dart';
import '../../components/icons/svg_icon.dart';

class MenuItem extends StatelessWidget {
  final Menu menu;
  final VoidCallback goToMenu;

  const MenuItem({super.key, required this.menu, required this.goToMenu});

  @override
  Widget build(BuildContext context) {
    String menuAsset;
    if (menu.menuCategory == "시그니처") {
      menuAsset = "./images/americano.jpg";
    } else if (menu.menuCategory == "커피") {
      menuAsset = "./images/latte.jpg";
    } else {
      menuAsset = "./images/juice.jpeg";
    }

    return InkWell(
      onTap: goToMenu,
      child: Container(
        height: 232.h,
        padding: pd24h.copyWith(bottom: 24.h),
        alignment: Alignment.topCenter,
        decoration: bottomBorderMenuItem,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.network(
            //   menu.menuImgList?[0] ?? '', // 유효하지 않은 URL일 경우의 처리
            //   height: 184.h,
            //   width: 104.w,
            //   fit: BoxFit.cover,
            //   errorBuilder: (context, error, stackTrace) {
            //     return Container(
            //       width: 104.w,
            //       color: grayEA, // 에러 발생 시 대체할 색 또는 위젯 설정
            //     );
            //   },
            // ),
            Image.asset(
              menuAsset,
              height: 184.h,
              width: 104.w,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 104.w,
                  color: grayEA, // 에러 발생 시 대체할 색 또는 위젯 설정
                );
              },
            ),
            SizedBox(width: 16.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // if(menu.isBest) cudiBest(),
                // if(menu.isBest) sbh16,
                SizedBox(
                  width: 200.w,
                  child: Text(
                    '${menu.menuName}',
                    style: s16w600.copyWith(color: black),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                sbh8,
                SizedBox(
                  width: 200.w,
                  child: Text(
                    '${menu.menuDesc}',
                    style: h19.copyWith(fontSize: 12.sp, color: gray58),
                    maxLines: 2,
                    // 원하는 최대 줄 수를 설정
                    overflow: TextOverflow.ellipsis,
                    // 일정 너비 이상의 텍스트는 '...'으로 줄임
                    softWrap: true, // 텍스트가 너비를 넘어갈 때 자동으로 줄 바꿈을 활성화
                  ),
                ),
                sbh12,
                Text(
                  '${menu.menuPrice?.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                  style: w500.copyWith(color: black),
                ),
                sbh16,
                Row(
                  children: [
                    svgIcon('assets/icon/ico-line-notice.svg'),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text('${menu.menuAllergy}',
                        style: s12.copyWith(color: gray58),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    // Text(' 알레르기: '+ (for (int i = 0; i < allergyList.length; i++) allergyList[i] +', ')),
                    // ' 알레르기: '
                    // '${allergyList[0]}, ${allergyList[1]}, ${allergyList[2]}',
                    // style: TextStyle(color: gray58, fontSize: 12.0)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
