import 'package:CUDI/utils/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../../constants.dart';
import '../../utils/auth/authentication.dart';
import '../../widgets/cudi_buttons.dart';
import '../../widgets/cudi_inputs.dart';
import '../../widgets/cudi_util_widgets.dart';
import '../components/app_bar.dart';

class FindPwScreen extends StatefulWidget {
  final int? initialBodyIndex;

  const FindPwScreen({super.key, this.initialBodyIndex});

  @override
  State<FindPwScreen> createState() => _FindPwScreenState();
}

class _FindPwScreenState extends State<FindPwScreen> {
  int bodyIndex = 0;
  String userEmail = "";
  String userPhoneNumber = "";
  String userPassword = "";
  String groupValue = "phone";

  @override
  void initState() {
    bodyIndex = widget.initialBodyIndex ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var p = UserProvider.of(context);

    Widget selectedBody;
    Widget selectedButton;

    switch (bodyIndex) {
      case 0:
        selectedBody = body0();
        selectedButton = _button0();
        break;
      case 1:
        selectedBody = body1();
        selectedButton = _button1();
        break;
      case 2:
        selectedBody = body2();
        selectedButton = _button2();
        break;
      case 3:
        selectedBody = body3();
        selectedButton = _button3();
        break;
      default:
        selectedBody = body0(); // Default to body0 or handle appropriately
        selectedButton = _button0();
        break;
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          sliverAppBar(context,
              title: "비밀번호 찾기", leadingFunction: leadingFunction),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: p.bodyHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: pd24h,
                      child: selectedBody,
                    ),
                    const Spacer(),
                    selectedButton,
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }

  void leadingFunction() {
    if (bodyIndex != 0) {
      setBodyIndex(bodyIndex - 1);
    } else {
      Navigator.pop(context);
    }
  }

  void setBodyIndex(int index) {
    setState(() {
      bodyIndex = index;
    });
  }

  void setGroupValue(String value) {
    setState(() {
      groupValue = value;
    });
    print(groupValue);
  }

  Widget _button0() {
    var p = UtilProvider.of(context);
    return buttonSpace(
        button1('다음으로', p.isEmailValid ?? false ? getUserInfo : null));
  }

  Widget _button1() {
    var p = UtilProvider.of(context);
    return buttonSpace(button1('인증 번호 전송', () {
      if (groupValue == "phone") {
        p.sendSMS(context, [], userPhoneNumber);
        if (p.isSent) {
          setBodyIndex(2);
        }
      } else {
        p.sendEmail(context, userEmail);
        if (p.isEmailSent) {
          setBodyIndex(2);
        }
      }
    }));
  }

  Widget _button2() {
    var p = UtilProvider.of(context);
    return buttonSpace(button1('인증완료', () {
      passwordController.clear();
      pwConfirmController.clear();
      if (p.isSent) {
        if (p.timeText != "0:00") {
          p.verifyCode(context, []);
          if (p.uid == '인증 완료') {
            setBodyIndex(3);
            passwordController.clear();
            pwConfirmController.clear();
            p.setMessage('');
          }
        }
      } else {
        if (certController.text == p.emailCode) {
          print('이메일 인증 코드 일치함');
          setBodyIndex(3);
        }
      }
    }));
  }

  Widget _button3() {
    var p = UtilProvider.of(context);
    return buttonSpace(button1(
        '설정완료',
        ((p.isPasswordValid ?? false) && (p.isPWConfirmValid ?? false))
            ? () {
                getUserInfo;
                Authentication().updatePassword(context,
                    email: userEmail,
                    pw: userPassword,
                    newPassword: pwConfirmController.text);
              }
            : null));
  }

  Widget body0() {
    return Column(
      children: [
        emailInput(context, 'E-mail', '이메일을 입력해주세요.', emailController),
      ],
    );
  }

  Widget body1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sbh24,
        Text('인증 수단 선택', style: w500),
        sbh24,
        Row(
          children: [
            Text('등록된 휴대폰 번호로 인증하기', style: w500),
            Radio(
                value: "phone",
                groupValue: groupValue,
                onChanged: (value) => setGroupValue("phone")),
          ],
        ),
        Text(userPhoneNumber ?? '', style: s12h19.copyWith(color: grayB5)),
        sbh24,
        Row(
          children: [
            Text('등록된 이메일 주소로 인증하기', style: w500),
            Radio(
                value: "email",
                groupValue: groupValue,
                onChanged: (value) => setGroupValue("email")),
          ],
        ),
        Text(userEmail ?? '', style: s12h19.copyWith(color: grayB5)),
      ],
    );
  }

  Widget body2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        certInput(context, [], userPhoneNumber: userPhoneNumber),
      ],
    );
  }

  Widget body3() {
    return Column(
      children: [
        passwordInput(context, '새 비밀번호', '새 비밀번호를 입력해주세요', passwordController),
        passwordInput(
            context, '새 비밀번호 확인', '한 번 더 입력해주세요', pwConfirmController),
        validationMessage(),
      ],
    );
  }

  Future<void> getUserInfo() async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection("user")
        .where("user_email", isEqualTo: emailController.text)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      var data = querySnapshot.docs[0].data();
      userEmail = data["user_email"];
      userPhoneNumber = formatPhoneNumber(data["user_phone_number"]);
      userPassword = data["user_password"];
      setBodyIndex(1);
    } else {
      userEmail = '이메일을 찾을 수 없습니다.';
      userPhoneNumber = '휴대폰 번호를 찾을 수 없습니다.';
      snackBar(context, "회원정보를 찾을 수 없습니다.");
    }
    print('userpw: $userPassword');
  }

  String formatPhoneNumber(String phoneNumber) {
    // 숫자만 추출
    String digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // 국가 코드 "82" 제거
    if (digitsOnly.startsWith('82')) {
      digitsOnly = digitsOnly.substring(2);
    }

    // 포맷 적용
    String formattedNumber = '';
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i == 3 || i == 7) {
        formattedNumber += '-';
      }
      formattedNumber += digitsOnly[i];
    }

    return formattedNumber;
  }

  Future<void> resetPassword() async {
    await auth.FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text)
        .then((value) {
      snackBar(context, "비밀번호 재설정 이메일이 전송되었습니다.");
    });
  }

  @override
  void dispose() {
    Authentication().signOut(context, isGoSplash: false);
    super.dispose();
  }
}

// Widget body() {
//   return Column(
//     children: [
//       outlinedButton(text: '다음으로', isSelected: true, click: () {}),
//       // launchFillButton('다음으로', () {}),
//       // launchLineButton('다음으로', () {}),
//       // cudiBackgroundButton('다음으로', () {}),
//       // popButton(context),
//       // cudiHorizonListButton(
//       //     '다음으로', 'assets/icon/ico-line-cart-white-24px.svg', () {}, true),
//       menuHorizonListButton('다음으로', () {}, true),
//       cudiNotifiHorizonListButton('다음으로', () {}, true),
//       viewCafeHorizonListButton('다음으로'),
//       orderHotOrIcedButton('다음으로', () {}, true),
//       smallButton(
//           text: '다음으로',
//           click: () {},
//           iconAsset: 'assets/icon/ico-line-cart-white-24px.svg'),
//       primaryButton('다음으로', () {}),
//       Divider(),
//       buttonSpace(button1('다음으로', (){})),
//       buttonSpace(button2('다음으로', (){})),
//       button3Space(button3('메뉴담기', (){}), button3('메뉴담기', (){})),
//     ],
//   );
// }
