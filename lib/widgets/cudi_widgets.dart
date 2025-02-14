import 'dart:ui';

import 'package:jobCafeApp/screens/store/store_screen.dart';
import 'package:jobCafeApp/utils/provider.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../constants.dart';
import '../models/menu.dart';
import '../routes.dart';
import '../screens/components/icons/svg_icon.dart';

Widget newBadge() {
  return Positioned(
    right: 0,
    top: 0,
    child: CircleAvatar(
      radius: 6.w,
      backgroundColor: heart,
      child: Text('N',
          style: TextStyle(
              fontSize: 8.sp, color: white, fontWeight: FontWeight.w900)),
    ),
  );
}

Widget circleBeany(BuildContext context,
    {required bool isSmaile, required double size}) {
  String? img =
      UserProvider.of(context).currentUser.userImgUrl;
  return img == null
      ? Stack(
        children: [Image.asset(
          'assets/logo/MintChoco-face.png',
            // isSmaile
            //     ? 'assets/images/img-profile-success-96px.png'
            //     : 'assets/images/img-profile-fail-96px.png',
            width: size,
            height: size),
      ])
      : CircleAvatar(
          backgroundColor: black,
          radius: size / 2,
          child: ClipOval(
            child: Selector<UserProvider, String>(
              selector: (context, u) => u.currentUser.userImgUrl ?? "",
              builder: (context, someValue, child) {
                return Image.network(
                  someValue,
                  fit: BoxFit.cover,
                  width: size,
                  height: size,
                );
              },
            ),
          ));
}

Widget cudiBest() {
  return Container(
    width: 81.0,
    height: 20.0,
    color: black,
    child: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Text('MINT BEST',
          style: TextStyle(
              fontSize: 12.0, fontWeight: FontWeight.w600, inherit: false),
          maxLines: 1,
          overflow: TextOverflow.ellipsis),
    ),
  );
}

Widget priceText({required int price, required TextStyle style}) {
  return Text(
    '${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
    style: style,
  );
}

Widget tastingNote(BuildContext context) {
  Menu menu = UserProvider.of(context).currentMenu;
  List dripTaste = ['단맛', '쓴맛', '신맛', '바디'];
  List dripTasteNum = [
    menu.dripSweet,
    menu.dripBitter,
    menu.dripSour,
    menu.dripBody
  ];

  String changePercent = '';

  return Container(
    margin: pd24v,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '테이스팅 노트',
          style: s16w500.copyWith(color: black, height: 1.0),
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: dripTaste.length,
            itemBuilder: (BuildContext context, idx) {
              if (dripTasteNum[idx] == 0 || dripTasteNum[idx] == 1) {
                changePercent = '0';
              } else if (dripTasteNum[idx] == 2) {
                changePercent = '25';
              } else if (dripTasteNum[idx] == 3) {
                changePercent = '50';
              } else if (dripTasteNum[idx] == 4) {
                changePercent = '75';
              } else if (dripTasteNum[idx] == 5) {
                changePercent = '100';
              }

              return Column(
                children: [
                  SizedBox(
                    height: 16.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dripTaste[idx],
                        style: s12.copyWith(color: gray58, height: 1.0),
                      ),
                      Text('${changePercent}%',
                          style: s12.copyWith(color: gray58, height: 1.0))
                    ],
                  ),
                  SizedBox(
                    height: 8.0.h,
                  ),
                  Image.asset(
                      'assets/images/img-tastingnote-${changePercent}.png')
                ],
              );
            })
      ],
    ),
  );
}

class MenuInfo extends StatefulWidget {
  final bool? tasting;
  final bool isOpenSheet;

  const MenuInfo({super.key, this.tasting, required this.isOpenSheet});

  @override
  State<MenuInfo> createState() => _MenuInfoState();
}

class _MenuInfoState extends State<MenuInfo> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {

    Menu menu = UserProvider.of(context).currentMenu;
    bool drip = false;
    if (menu.dripSweet == null) {
      drip = false;
    } else {
      drip = true;
    }

    int maxLine = widget.isOpenSheet && isClicked ? 5 : 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sbh8,
        // cudiBest(),
        // sbh16,
        Text('${menu.menuName}', style: s20w600.copyWith(color: black)),
        sbh8,
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: GestureDetector(
            onTap: () {
              setState(() {
                isClicked = !isClicked;
              });
            },
            child: Text(
                overflow: TextOverflow.ellipsis,
                maxLines: maxLine,
                softWrap: true,
                style: h17.copyWith(color: gray58, fontSize: 14.sp, ),
                // menu.menuDesc != null && menu.menuDesc!.length > 90
                //     ? '${menu.menuDesc?.substring(0, 90)}'
                //     :
                menu.menuDesc ?? ''),
          ),
        ),
        SizedBox(height: drip ? 4.h : 12.h),
        // SizedBox(
        //   height: drip && widget.tasting != null &&  widget.tasting ? 12.h : 0.0,
        // ),
        // drip &&  widget.tasting != null &&  widget.tasting
        //     ? tastingNote(context)
        //     : const SizedBox.shrink(),
        sbh12,
        Text(
          '${menu.menuPrice?.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
          style: s16w500.copyWith(color: black),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            svgIcon('assets/icon/ico-line-notice.svg'),
            SizedBox(
              width: 4.w,
            ),
            Text(' 알레르기: ${menu.menuAllergy}',
                style: const TextStyle(color: gray58, fontSize: 12.0),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ],
        ),
        sbh24
      ],
    );
  }
}

//
// Widget menuInfo(BuildContext context, {bool? tasting, required bool isOpenSheet}) {
//   Menu menu = UserProvider.of(context).currentMenu;
//   bool drip = false;
//   if (menu.dripSweet == null) {
//     drip = false;
//   } else {
//     drip = true;
//   }
//
//   bool isClicked = false;
//   int maxLine = isOpenSheet && isClicked ? : ;
//
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       sbh8,
//       // cudiBest(),
//       // sbh16,
//       Text('${menu.menuName}', style: s20w600.copyWith(color: black)),
//       sbh8,
//       SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Text(
//               overflow: TextOverflow.ellipsis,
//               maxLines: 2,
//               softWrap: true,
//               style: h17.copyWith(color: gray58, fontSize: 14.sp, ),
//               // menu.menuDesc != null && menu.menuDesc!.length > 90
//               //     ? '${menu.menuDesc?.substring(0, 90)}'
//               //     :
//               menu.menuDesc ?? ''),
//       ),
//       SizedBox(height: drip ? 4.h : 12.h),
//       SizedBox(
//         height: drip && tasting != null && tasting ? 12.h : 0.0,
//       ),
//       drip && tasting != null && tasting
//           ? tastingNote(context)
//           : const SizedBox.shrink(),
//       sbh12,
//       Text(
//         '${menu.menuPrice?.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
//         style: s16w500.copyWith(color: black),
//       ),
//       SizedBox(height: 16.h),
//       Row(
//         children: [
//           svgIcon('assets/icon/ico-line-notice.svg'),
//           SizedBox(
//             width: 4.w,
//           ),
//           Text(' 알레르기: ${menu.menuAllergy}',
//               style: const TextStyle(color: gray58, fontSize: 12.0),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis),
//         ],
//       ),
//       sbh24
//     ],
//   );
// }

Widget cudiDetailListItem(String title, String desc, String iconName,
    {VoidCallback? click, Color? color}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          svgIcon(
              'assets/icon/ico-line-${iconName}-default-light-16px.svg'),
          SizedBox(
            width: 4.0,
          ),
          Text(
            title,
            style: cudiCafeDetailDescTit,
            textAlign: TextAlign.start,
          ),
        ],
      ),
      SizedBox(
        height: 8.0.h,
      ),
      InkWell(
        onTap: click,
        child: Text(
          desc == '' ? '-' : desc,
          style: desc == ''
              ? cudiCafeDetailDesc
              : cudiCafeDetailDesc.copyWith(color: color),
          textAlign: TextAlign.start,
        ),
      ),
      SizedBox(
        height: 24.0.h,
      )
    ],
  );
}

Widget cupayCard() {
  return Container(
    // width: MediaQuery.of(context).size.width,
    height: 199.0.w,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: const DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/cudi_card.png'))),
    child: Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('MINTPAY',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w900)),
                  Text('0000 0000 0000 0000',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w700)),
                ],
              ),
              Image.asset(
                'assets/icon/money.png',
                width: 32.0,
                height: 32.0,
              )
            ],
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('잔액'),
                    Text('150,000원',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
                SizedBox(
                  width: 28.0,
                  child: IconButton(
                      onPressed: () {},
                      icon: svgIcon(
                          'assets/icon/ico-line-charge-default-28px.svg')),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget containerTitle(BuildContext context,
    {required String text, required Widget where}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => where));
    },
    child: Padding(
      padding: const EdgeInsets.only(top: 48.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
          svgIcon('assets/icon/ico-line-arrow-right-white-24px.svg'),
        ],
      ),
    ),
  );
}

Widget cupayReserves({EdgeInsets? padding}) {
  return Padding(
    padding: padding ?? EdgeInsets.only(top: 24.h),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: gray1C,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('사용 가능 적립금', style: w500),
              SizedBox(height: 12.h),
              priceText(price: 5600, style: s16w600),
            ],
          ),
          Image.asset(
            'assets/images/img-point.png',
            width: 48.w,
            height: 48.w,
          )
        ],
      ),
    ),
  );
}

Widget customStoreAddress(String? address) {
  return SizedBox(
    width: 272.w,
    child: Text(getSimplifiedAddress(address.toString()).toString(),
        maxLines: 1,
        style: h17.copyWith(
          overflow: TextOverflow.ellipsis,
          shadows: [
            const Shadow(
              color: Colors.black, // 그림자 색상
              offset: Offset(2.0, 2.0), // 그림자 위치 (가로, 세로)
              blurRadius: 3.0, // 그림자 흐림 정도
            ),
          ],
        )),
  );
}

String? getSimplifiedAddress(String fullAddress) {
  RegExp regExp = RegExp(r'(\S+?[시|도])\s*(\S+?[구|군])');

  Match? match = regExp.firstMatch(fullAddress);

  return "${match?.group(1) ?? ""} ${match?.group(2) ?? ""}" == " "
      ? "주소를 찾을 수 없습니다."
      : "${match?.group(1)} ${match?.group(2)}";
}

// Future<void> handleDynamicLinks0() async {
//   // 앱이 실행될 때 실행되는 부분
//   FirebaseDynamicLinks.instance.onLink.listen((PendingDynamicLinkData dynamicLinkData) {
//     if (dynamicLinkData.link.queryParameters.containsKey("storeId")) {
//       // StoreScreen, storeId
//   }
//   }).onError((error) {
//     debugPrint(error);
//   });
// }

// Future<String> getShortLink(String screenName, String storeId) async {
//   String dynamicLinkPrefix = 'https://cuudi.page.link';
//   final dynamicLinkParams = DynamicLinkParameters(
//     uriPrefix: dynamicLinkPrefix,
//     link: Uri.parse('$dynamicLinkPrefix/$screenName?storeId=$storeId'),
//     androidParameters: const AndroidParameters(
//       packageName: "com.allrounder.cudi",
//       minimumVersion: 0,
//     ),
//     iosParameters: const IOSParameters(
//       bundleId: "com.allrounder.cudi",
//       appStoreId: "6467719845",
//       minimumVersion: "0",
//     ),
//     socialMetaTagParameters: SocialMetaTagParameters(
//       title: "Example of a Dynamic Link",
//       imageUrl: Uri.parse("https://lh3.googleusercontent.com/5yVIv0KLveUkGJCzJIKZGp3sPM_3w6ZAFNpXEbS1sdo-w4cpxkW_aQGLu54ur9RR2w"),
//     ),
//   );
//   final dynamicLink =
//   await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
//
//   return dynamicLink.shortUrl.toString();
// }

Widget shareIcon(String screenName, String storeId) {
  // Uri playStore = Uri.parse("https://play.google.com/store/apps/details?id=com.allrounder.cudi");
  // Uri appStore = Uri.parse("https://apps.apple.com/kr/app/cudi/id6467719845");
  // Future<void> shareFunction() async {
  //   final dynamicLinkParams = DynamicLinkParameters(
  //     link: Uri.parse("https://play.google.com/store/apps/details?id=com.allrounder.cudi"),
  //     uriPrefix: "https://cuudi.page.link",
  //
  //     androidParameters: AndroidParameters(
  //       fallbackUrl: playStore,
  //       packageName: "com.allrounder.cudi",
  //       minimumVersion: 21,
  //     ),
  //
  //     // iosParameters: IOSParameters(
  //     //   fallbackUrl: appStore,
  //     //   bundleId: "com.allrounder.cudi",
  //     //   appStoreId: "6467719845",
  //     //   minimumVersion: "1.0.7",
  //     // ),
  //
  //     // socialMetaTagParameters: SocialMetaTagParameters(
  //     //   title: "Example of a Dynamic Link",
  //     //   imageUrl: Uri.parse("https://example.com/image.png"),
  //     // ),
  //   );
  //
  //   final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
  //   Share.share(dynamicLink.toString());

    // Share.share("https://cuudi.page.link");
  // }
  return InkWell(
    // onTap: shareFunction,
  //   onTap: () async => Share.share(
  //     await getShortLink(screenName, storeId),
  // ),
    onTap: (){},
    child: Container(
        width: 24.w,
        height: 24.h,
        child: svgIcon('assets/icon/ico-line-share.svg')),
  );
}

Container noticeContainer(List<String> noticesTextList) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), color: grayF6),
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: noticesTextList.length,
        itemBuilder: (context, index) {
          return Text(noticesTextList[index], style: noticeContainerText);
        },
      ));
}

Widget bulletText({required String text, String? bullet, Color? textColor}) {
  var style =
      h19.copyWith(fontSize: 12.sp, color: textColor ?? gray79, height: 1.6.h);
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(bullet ?? '•', style: style),
      SizedBox(width: 8.w), // 불릿과 텍스트 간격 조절
      Expanded(
        child: Text(
          text,
          style: style,
        ),
      ),
    ],
  );
}

Widget userIdWidget(BuildContext context) {
  UserProvider userProvider = Provider.of<UserProvider>(context);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('${userProvider.currentUser.userNickname}님', style: w500),
      Text('${userProvider.currentUser.userEmail}',
          style: h19.copyWith(color: grayB5, fontSize: 12.sp)),
    ],
  );
}

Widget sumPriceText({required int price, String? text}) {
  var style = s24w700.copyWith(color: text == null ? black : white);
  return Padding(
      padding: pd24h12v,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text ?? '총', style: style),
          priceText(price: price, style: style),
        ],
      ));
}

Widget notice(
    {required List<String> noticeTextList,
    Color? containerColor,
    Color? textColor}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: noticeTextList
        .map(
          (text) => bulletText(
            text: text,
            bullet: '•', // 불릿 문자
          ),
        )
        .toList(),
  );
}