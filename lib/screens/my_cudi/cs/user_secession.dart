import 'package:CUDI/routes.dart';
import 'package:CUDI/screens/components/screens.dart';
import 'package:CUDI/utils/auth/authentication.dart';
import 'package:CUDI/utils/db/firebase_firestore.dart';
import 'package:CUDI/utils/provider.dart';
import 'package:CUDI/widgets/cudi_checkboxes.dart';
import 'package:CUDI/widgets/cudi_inputs.dart';
import 'package:CUDI/widgets/cudi_util_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../models/coupon.dart';
import '../../../theme.dart';
import '../../../widgets/cudi_buttons.dart';
import '../../../widgets/cudi_widgets.dart';
import '../../components/app_bar.dart';
import '../../../constants.dart';
import '../../components/icons/cart_icon.dart';
import '../components/etc.dart';

class UserSecession extends StatefulWidget {
  final String title;
  final bool? padding;
  final CartIcon? cartIcon;
  final String? buttonTitle;
  final void Function()? buttonClick;

  const UserSecession(
      {super.key,
      required this.title,
      this.cartIcon,
      this.padding,
      this.buttonTitle,
      this.buttonClick});

  @override
  State<UserSecession> createState() => _UserSecessionState();
}

class _UserSecessionState extends State<UserSecession> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            sliverAppBar(context,
                title: widget.title, iconButton: widget.cartIcon),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      88.h -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            widget.padding == null ? pd24h : EdgeInsets.zero,
                        child: Column(
                          children: [
                            SizedBox(height: 670.h, child: listViewWidget()),
                          ],
                        ),
                      ),
                      if (widget.buttonClick != null) const Spacer(),
                      if (widget.buttonClick != null)
                        Padding(
                          padding: pd24202407,
                          child: whiteButton('${widget.buttonTitle}', null,
                              widget.buttonClick),
                        )
                    ],
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    pwCont.clear();
    super.dispose();
  }

  ListView listViewWidget() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: titleList.length,
        itemBuilder: (context, index) {
          return bottomBorderContainer(index);
        });
  }

  List<String> titleList = [
    '',
    '기타',
    '비밀번호 입력',
    '',
  ];

  TextEditingController etcCont = TextEditingController();
  TextEditingController pwCont = TextEditingController();
  String hintText =
      '서비스 이용 중 아쉬웠던 점을 알려주세요.(100자 이하)서비스 이용 중 아쉬웠던 점을 알려주세요.(100자 이하)서비스 이용 중 아쉬웠던 점을 알려주세요.(100자 이하)서비스';

  Container bottomBorderContainer(int index) {
    List<Widget> widgetList = [
      secessionCommonWidget(),
      filledTextField(context,
          controller: etcCont, hintText: hintText, maxLines: 4),
      filledTextField(context,
          controller: pwBeforeController,
          hintText: '',
          onChanged: (value) =>
              UtilProvider.of(context).validatePWBefore(value)),
      secessionButtons(),
    ];
    return Container(
      decoration: index == titleList.length - 1 ? null : bottomBorder,
      child: Padding(
          padding: index != 0
              ? pd24all
              : EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index != 0 && index != 3)
                titleWidget(title: titleList[index]),
              if (index != 0) sbh24,
              widgetList[index],
            ],
          )),
    );
  }

  String textVariable = 'CUDI를 떠나신다니 아쉬워요.\n무엇이 불편하셨나요?';
  List<String> inconvenienceList = [
    '카페 이용을 잘 안 해요.',
    '앱 사용을 잘 안 해요.',
    '혜택(쿠폰, 이벤트)이 너무 적어요.',
    '개인정보보호를 위해 삭제할 정보가 있어요.',
    '다른 계정이 있어요.',
  ];

  Widget secessionCommonWidget() {
    List<bool?> secessionChecks =
        Provider.of<UtilProvider>(context).secessionChecks;
    return Column(
      children: [
        secessionBigText('assets/images/img-cs-out1.png', textVariable),
        ...inconvenienceList.map((e) {
          int index = inconvenienceList.indexOf(e);
          return checkRow(
              text: e,
              value: secessionChecks[index] ?? false,
              onChange: (bool value) {
                if (index >= 0 && index < secessionChecks.length) {
                  // 해당하는 index의 체크박스 상태만 변경
                  secessionChecks[index] = value;
                  Provider.of<UtilProvider>(context, listen: false)
                      .setSecessionChecks(secessionChecks);
                }
              });
        }).toList(),
      ],
    );
  }

  Widget secessionButtons() {
    var p = UtilProvider.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: button1('탈퇴취소', () => Navigator.pop(context))),
        SizedBox(width: 20.w),
        Expanded(
          child: button1(
              '다음으로',
              (p.isPWBeforeValid == true)
                  ? () {
                      if (pwBeforeController.text ==
                          UserProvider.of(context).currentUser.userPassword) {
                        List<String> inconvenienceListText = [];

                        p.secessionChecks.asMap().forEach((index, value) {
                          if (value == true) {
                            String inconvenience = inconvenienceList[index];

                            // Format the checked reason and values
                            String formattedText = inconvenience;
                            inconvenienceListText.add(formattedText);
                          }
                        });

                        Map<String, dynamic> data = {
                          'secession_discomforts':
                              inconvenienceListText.join(', '),
                          'secession_etc': etcCont.text,
                          'secession_time': Timestamp.now(),
                          'user_email': FieldValue.delete(),
                          'user_phone_number': FieldValue.delete(),
                        };
                        p.setSecessionData(data);
                        p.validateUserPW(context, "");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const UserSecession2(title: '회원탈퇴')));
                      } else {
                        snackBar(context, "비밀번호를 확인해주세요.");
                      }
                    }
                  : null),
        ),
      ],
    );
  }
}

class UserSecession2 extends StatefulWidget {
  final String title;

  const UserSecession2({super.key, required this.title});

  @override
  State<UserSecession2> createState() => _UserSecession2State();
}

class _UserSecession2State extends State<UserSecession2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Selector<UtilProvider, bool>(
          selector: (context, p) => p.allowButtonCheck,
          builder: (context, allowButtonCheck, child) {
            print(allowButtonCheck);
            return Column(
              children: [
                CudiAppBar(
                    title: widget.title,
                    isWhite: true,
                    isPadding: true,
                    isHeightPadding: true),
                columnWidget(context),
                const Spacer(),
                secessionButtons(),
              ],
            );
          },
        ),
      ),
    );
  }

  // 파이어베이스 데이터
  late List<Coupon> coupons = [];

  // 파이어베이스 데이터
  void _initializeData() async {
    late List<Coupon> data;
    data = await FireStore.getUserCoupons(UserProvider.of(context).uid ?? '');
    setState(() {
      coupons = data;
    });
  }

  @override
  void initState() {
    _initializeData();
    super.initState();
  }

  String textVariable = '계속 진행하시면\n혜택이 완전히 사라져요.';

  Widget columnWidget(BuildContext context) {
    int data1 = 0;
    String? data2;
    int data3 = coupons.length;
    Map<String, List<dynamic>> secessionMap = {
      'CUDIPAY': ['assets/images/img-point.png', data1],
      '등급': ['assets/images/img-membersihp.png', (data2 ?? '???')],
      '쿠폰': ['assets/images/img-cupon.png', '$data3장'],
    };

    List<Widget> secessionWidgets = [];

    secessionMap.forEach((key, value) {
      secessionWidgets
          .add(secessionContainer(key: key, url: value[0], value: value[1]));
    });

    List<String> secessionBulletTextList = [
      '탈퇴 후 회원님의 등급과 쿠폰들은 복구가 불가능합니다.',
      '잔여 CUPAY는 자동 환불되지 않습니다. 탈퇴 전 환불 진행해 주세요.',
      '등록된 리뷰는 자동으로 삭제되지 않습니다. 탈퇴 전 개별적으로 삭제해 주세요.',
      '계정 정보 및 찜 목록 등 서비스 이용정보는 복구가 불가능하며, 동일한 아이디로 24시간 이후 재가입이 가능합니다.',
    ];

    return Padding(
      padding: pd24h,
      child: Column(
        children: [
          secessionBigText('assets/images/img-cs-out2.png', textVariable),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [...secessionWidgets]),
          ),
          sbh24,
          ...secessionBulletTextList.map((e) => bulletText(text: e)),
          sbh24,
          checkboxWithRichTextWidget(context, '위 주의사항을 모두 숙지했으며 탈퇴에 동의합니다.'),
        ],
      ),
    );
  }

  Widget secessionContainer(
      {required String url, required String key, dynamic value}) {
    return Container(
      width: 100.6.w,
      padding: pd16h20v,
      decoration:
          BoxDecoration(color: gray1C, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Image.asset(url, width: 48.w),
          sbh12,
          Text(key, style: w500),
          sbh8,
          Center(
              child: key == "CUDIPAY"
                  ? priceText(price: value, style: s16w600)
                  : Text('$value', style: s16w600))
        ],
      ),
    );
  }

  Widget secessionButtons() {
    return button3Space(
        button3('탈퇴취소', () => Navigator.pop(context)),
        button3(
            '탈퇴하기',
            context.read<UtilProvider>().allowButtonCheck
                ? () {
                    cudiDialog(context, '회원탈퇴',
                        '회원 탈퇴 시 계정 정보 및 보유 중인 쿠폰과 등금, 잔여 금액은 삭제되고 복구가 불가능합니다. 정말 탈퇴하시겠어요?',
                        button2Function: () async {
                      var u = UserProvider.of(context);
                      var p = UtilProvider.of(context);

                      p.showOverlay(context);
                      // 1. auth 이메일 계정 삭제
                      Authentication()
                          .deleteCurrentUser(context)
                          .then((value) async {
                        // 2. 유저 DB 업데이트 (탈퇴일시간, 탈퇴사유), 필드 삭제 (이메일, 폰번호)
                        try {
                          await FirebaseFirestore.instance
                              .collection("user")
                              .doc(u.uid)
                              .update(p.secessionData)
                              .then((value) {
                                p.hideOverlay();
                            // 3. 다음 화면으로 이동
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AppbarScreen(
                                    title: '회원탈퇴',
                                    isNoLeading: true,
                                    column: out3Widget(),
                                    icon: CloseButton(
                                        onPressed: () =>
                                            Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              RouteName.splash,
                                              (route) => false,
                                            )),
                                    buttonTitle: '확인',
                                    buttonClick: () =>
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          RouteName.splash,
                                          (route) => false,
                                        )),
                              ),
                              (route) => false,
                            );
                          });
                          print("유저 DB 업데이트 (탈퇴일시간, 탈퇴사유), 필드 삭제 (이메일, 폰번호)");
                        } catch (error) {
                          print("탈퇴 에러: $error");
                        }
                      });
                    });
                  }
                : null));
  }

  String textVariable2 = '회원탈퇴가 완료되었습니다.\n더 나은 쿠디가 될게요.\n꼭 다시 봐요!';

  Column out3Widget() {
    return Column(
      children: [
        secessionBigText('assets/images/img-cs-out3.png', textVariable2),
      ],
    );
  }
}
