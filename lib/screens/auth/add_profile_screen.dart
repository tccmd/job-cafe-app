import 'package:CUDI/screens/components/screens.dart';
import 'package:CUDI/utils/db/firebase_firestore.dart';
import 'package:CUDI/widgets/cudi_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/user.dart';
import '../../utils/auth/authentication.dart';
import '../../utils/provider.dart';
import '../../widgets/cudi_inputs.dart';
import '../../widgets/cudi_logos.dart';
import '../../widgets/cudi_util_widgets.dart';
import '../../widgets/cudi_widgets.dart';
import '../components/app_bar.dart';
import '../components/icons/svg_icon.dart';
import '../main_screens.dart';
import '../../constants.dart';

class AddProfileScreen extends StatefulWidget {
  final List<bool> checks;
  final String phoneNumber;
  final String uid;

  const AddProfileScreen(
      {Key? key,
      required this.checks,
      required this.phoneNumber,
      required this.uid})
      : super(key: key);

  @override
  State<AddProfileScreen> createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  bool firstProfile = true;

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 키보드
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: pd24h16v,
              child: firstProfile
                  ? cudiAppBar(context, appBarTitle: '회원가입')
                  : removeFirstProfileAppBar(),
            ),
            Padding(
              padding: pd24all,
              child: firstProfile ? addProfile01() : addProfile02(),
            ),
            const Spacer(),
            button(),
          ],
        ),
      ),
    );
  }

  Widget button() {
    var p = UtilProvider.of(context);
    bool isValidate = p.isEmailValid == true &&
        p.isPasswordValid == true &&
        p.isPWConfirmValid == true;
    bool isValidate2 = (p.isNicknameValid ?? false);
    return buttonSpace(firstProfile
        ? button1('다음', isValidate ? setSecondProfile : null)
        : button1('가입완료', isValidate2 ? cudiSignup : null));
  }

  void setFirstProfile() {
    setState(() => firstProfile = true);
  }

  void setSecondProfile() {
    setState(() => firstProfile = false);
  }

  Widget removeFirstProfileAppBar() {
    return cudiAppBar(context,
        appBarTitle: '회원가입', leadingFunction: setFirstProfile);
  }

  Widget addProfile01() {
    return SizedBox(
      height: 390.h + 50.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          emailInput(context, 'E-mail', '이메일을 입력해주세요.', emailController,
              join: true),
          passwordInput(context, 'Password', '비밀번호를 입력해 주세요.(최소 6자리 이상)',
              passwordController,
              padding: false),
          passwordInput(context, '', '비밀번호를 확인해 주세요.', pwConfirmController,
              padding: false),
          validationMessage()
        ],
      ),
    );
  }

  Widget addProfile02() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        nickNameInput(context, join: true),
        birthInput(context, join: true),
        genderInput(context, join: true),
      ],
    );
  }

  Future<void> cudiSignup() async {
    try {
      // 이미 가입된 이메일인지 확인
      List<String> providers = await auth.FirebaseAuth.instance.fetchSignInMethodsForEmail(emailController.text);

      if (providers.contains('password')) {
        // 해당 이메일로 이미 가입된 사용자가 있음
        snackBar(context, "이미 가입된 이메일입니다.");
        return;
      }

      // 가입되지 않은 경우, 회원가입 진행
      String? uid = await Authentication().signUp(emailController.text, pwConfirmController.text);
      if (uid != null) {
        completeJoin(uid);
      }
    } catch (e) {
      if (e is auth.FirebaseAuthException) {
        print('Firebase Auth Exception - Code: ${e.code}, Message: ${e.message}');
        // 여기에서 에러 코드에 따른 처리 수행
        // 예: 에러 코드에 따른 사용자에게 알림, 특정 동작 등
        if (e.code == "email-already-in-use") {
          snackBar(context, "이미 가입된 이메일입니다.");
        }
      } else {
        print('Unexpected Error: $e');
      }
    }
  }

  Future<void> completeJoin(String uid) async {
    var u = UserProvider.of(context);
    var p = UtilProvider.of(context);
      User user = User(
        userPhoneNumber: widget.phoneNumber,
        userPhoneId: widget.uid,
        userEmail: emailController.text,
        userEmailId: uid,
        userPassword: pwConfirmController.text,
        userBirth: birthController.text,
        userGender: p.gender,
        userNickname: nickNameController.text,
        pushNotificationConsent: widget.checks[0],
        locationServiceConsent: widget.checks[1],
        cupayNotificationsConsent: false,
        promotionEventNotificationsConsent: false,
      );
      await FireStore.addUser(user).then((userDocId) async {
        await u.setUid(userDocId).then((value) async {
          await u.setCurrentUser();
        });
      });
      completeJoin;

    Column column() {
      return Column(
        children: [
          SizedBox(height: 72.h + 32.h),
          SizedBox(height: 32.h, child: textLineWhiteStart()),
          sbh24,
          circleBeany(context, size: 111, isSmaile: true),
          SizedBox(height: 34.h),
          Text('회원가입 완료!', style: s20w600),
          sbh12,
          Text('지금 바로 다양한 카페를 3D로 구경해보세요!', style: h17.copyWith(color: grayB5))
        ],
      );
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AppbarScreen(
                  title: '',
                  column: column(),
                  isNoLeading: true,
                  icon: GestureDetector(
                      onTap: () {
                        navigateToNextScreen(context, const MainScreens(),
                            duration: 1000);
                      }, //=> Navigator.pushNamed(context, RouteName.home),
                      child: svgIcon(
                          'assets/icon/ico-line-close-default-dark-20px.svg')),
                )));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
