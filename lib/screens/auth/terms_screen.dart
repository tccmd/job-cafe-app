import 'package:CUDI/screens/auth/phone_certification_screen.dart';
import 'package:CUDI/screens/auth/term_screen.dart';
import 'package:CUDI/widgets/cudi_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme.dart';
import '../../widgets/cudi_logos.dart';
import '../components/app_bar.dart';
import '../../constants.dart';
import '../components/icons/svg_icon.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: pd24h16v,
              child: cudiAppBar(context, appBarTitle: '회원가입'),
            ),
            Padding(
              padding: pd24h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  termText(),
                  termAgrees(),
                ],
              ),
            ),
            const Spacer(),
            button(),
          ],
        ),
      ),
    );
  }

  Widget button() {
    void function() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PhoneCertificationScreen(checks: checks.sublist(4, 6))));
    }
    bool able = checks.length >= 3 && checks[0] && checks[1] && checks[2];
    return buttonSpace(
        button1('다음', able
            ? function
            : null)
    );
  }

  bool checkAll = false;
  List<String> agreementTitles = [
    '서비스 이용약관에 동의',
    '만 14세 이상입니다',
    '개인정보 수집 및 이용동의',
    '마케팅 알림 수신동의',
    '위치기반 서비스 이용약관 동의',
  ];
  List<String> terms = [serviceTerm,'',personalInfo,personalConsent,positionService];

  List<bool> checks = [
    false,
    false,
    false,
    false,
    false,
    false
  ]; // 각 체크박스의 초기 상태

  Widget termLogo() {
    return Padding(
      padding: EdgeInsets.fromLTRB(80.w, 0, 80.w, 20.h),
      child: textLineWhiteStart(),
    );
  }

  Widget termText() {
    return Padding(
      padding: EdgeInsets.only(top: 32.h, bottom: 16.h),
      child: Text(
        '환영합니다!\n약관내용에 동의해주세요',
        style: TextStyle(
            fontSize: 28.sp, fontWeight: FontWeight.w600, height: 1.42),
      ),
    );
  }

  Widget termAgrees() {
    return SizedBox(
      height: MediaQuery.of(context).size.height -
          (MediaQuery.of(context).padding.bottom + MediaQuery.of(context).padding.top + 88.h + 83.h + 128.h + 27.h + 56.h),
      // 바텀 패딩,탑패딩, 앱바, 하단 버튼, 환영텍스트
      child: Column(
        children: [
          Container(
            height: 68.h,
            decoration: bottomBorder,
            child: Row(
              children: [
                SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: Checkbox(
                    value: checkAll,
                    onChanged: (bool? value) {
                      setState(() {
                        checkAll = !checkAll;
                        // 전체 동의 체크박스 상태가 변경되면 다른 체크박스도 일괄적으로 변경
                        checks = List<bool>.generate(
                            checks.length, (index) => checkAll);
                      });
                    },
                    checkColor: Colors.white,
                    side: const BorderSide(color: gray58, width: 1.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text('전체 동의하기', style: s16w500.copyWith(height: 1.sp)),
              ],
            ),
          ),
          Column(
            children: generateListTiles(),
          )
        ],
      ),
    );
  }

  List<Widget> generateListTiles() {
    List<Widget> listTiles = [];
    for (int i = 0; i < agreementTitles.length; i++) {
      listTiles.add(
        Container(
          padding: EdgeInsets.only(top: 24.h),
          child: Row(
            children: [
              SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: checks[i] == false
                      ? GestureDetector(
                      onTap: () {
                        setState(() {
                          checks[i] = true;
                          if (checks.every((value) => value)) {
                            setState(() {
                              // 모든 체크박스가 true 인 경우 check_all도 true로 설정
                              checkAll = true;
                            });
                          }
                        });
                      },
                      child: svgIcon(
                        'assets/icon/ico-line-check-20px.svg',
                      ))
                      : GestureDetector(
                      onTap: () {
                        setState(() {
                          checks[i] = false;
                          if (checks.every((value) => value)) {
                            setState(() {
                              // 모든 체크박스가 true 인 경우 check_all도 true로 설정
                              checkAll = true;
                            });
                          }
                        });
                      },
                      child: svgIcon(
                          'assets/icon/ico-line-check-on-20px.svg'))),
              SizedBox(
                width: 8.w,
              ),
              GestureDetector(
                onTap: () {
                  i == 1 ? null : Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                          TermScreen(title: agreementTitles[i],
                              term: terms[i],
                              bgColor: black)));
                },
                child: Row(
                  children: [
                    Text(i == 3 || i == 4 ? '[선택]' : '[필수]',
                        style: s12w500.copyWith(color: i == 3 || i == 4 ? white : error, decorationColor: i == 3 || i == 4 ? white : error)),
                    Text(agreementTitles[i],
                        style: s12w500),
                    Text('(자세히)',
                        style: s12w500),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return listTiles;
  }
}