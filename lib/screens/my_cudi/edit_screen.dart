import 'package:jobCafeApp/screens/components/app_bar.dart';
import 'package:jobCafeApp/screens/my_cudi/components/profile.dart';
import 'package:jobCafeApp/widgets/cudi_util_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';
import '../../theme.dart';
import '../../utils/auth/authentication.dart';
import '../../utils/db/firebase_firestore.dart';
import '../../utils/provider.dart';
import '../../widgets/cudi_inputs.dart';
import '../components/icons/svg_icon.dart';
import '../components/screens.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var p = UtilProvider.of(context);
    List<String> myList = ['기본 정보 수정', '연락처 변경', '이메일 변경', '비밀번호 변경'];

    void modificationsCompleted(BuildContext context) {
      var u = UserProvider.of(context);
      var p = UtilProvider.of(context);
      FireStore.userUpdate(context,
          nickName: (nickNameController.text == "")
              ? u.currentUser.userNickname
              : nickNameController.text,
          birth: (birthController.text == "")
              ? u.currentUser.userBirth
              : birthController.text,
          gender: p.gender);
      p.validateNickname('');
      p.validateBirth('');
      nickNameController.clear();
      birthController.clear();
      u.setCurrentUser().then((value) {
        Navigator.pop(context);
      });
    }

    void passwordChange(BuildContext context) async {
      var u = UserProvider.of(context);
      if (pwBeforeController.text == u.currentUser.userPassword) {
        Authentication().updatePassword(context,
            email: u.currentUser.userEmail ?? '',
            pw: pwBeforeController.text,
            newPassword: pwConfirmController.text,
            isNav: true);
      } else {
        snackBar(context, "기존의 비밀번호를 다시 확인해주세요.");
      }
    }

    Column editBasicInformation(BuildContext context) {
      return Column(
        children: [
          nickNameInput(context),
          birthInput(context),
          genderInput(context),
        ],
      );
    }

// 연락처 변경
    Column changePhone(BuildContext context) {
      return Column(
        children: [
          phoneInput(context),
          certInput(context, []),
        ],
      );
    }

// 이메일 변경
    Column changeEmail(BuildContext context) {
      return Column(
        children: [
          emailInput(context, '기존 이메일', '기존 이메일을 입력하세요.', eBeforeController,
              enabledFalse: false),
          emailInput(context, '변경 이메일', '변경할 이메일을 입력하세요.', emailController),
          certInput(context, []),
        ],
      );
    }

// 비밀번호 변경
    Column changePassword(BuildContext context) {
      return Column(
        children: [
          passwordInput(context, '기존 비밀번호', '비밀번호를 입력해주세요', pwBeforeController),
          passwordInput(
              context, '새 비밀번호', '새 비밀번호를 입력해주세요', passwordController),
          passwordInput(
              context, '새 비밀번호 확인', '한 번 더 입력해주세요', pwConfirmController,
              padding: false),
          validationMessage()
        ],
      );
    }

    InkWell myRowItem(BuildContext context, String title, Column column,
        String buttonTitle, buttonFunction) {
      return InkWell(
        onTap: () {
          var p = UtilProvider.of(context);
          pwBeforeController.clear();
          passwordController.clear();
          pwConfirmController.clear();
          eBeforeController.text =
              UserProvider.of(context).currentUser.userEmail ?? '';
          emailController.clear();
          p.setIsSent(false);
          p.setIsEmailSent(false);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AppbarScreen(
                      title: title,
                      column: column,
                      buttonTitle: buttonTitle,
                      buttonClick: buttonFunction)));
        },
        child: SizedBox(
          height: 56.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: s16w500),
              svgIcon('assets/icon/ico-line-arrow-right-white-24px.svg')
            ],
          ),
        ),
      );
    }

    List<Column> myColumnList = [
      editBasicInformation(context),
      changePhone(context),
      changeEmail(context),
      changePassword(context)
    ];
    List<String> buttonTitleList = ['수정완료', "프로바이더 변수", "프로바이더 변수", '변경완료'];
    List<void Function()?> buttonFunctionList = [
          () => modificationsCompleted(context),
          () =>
      (p.isSent) ? p.verifyCode(context, [], isModify: true) : p.sendSMS(
          context, []),
          () =>
      (p.isEmailSent)
          ? p.verifiedEmailCode(context)
          : p.sendEmail(context, emailController.text, isCode: true),
          () => passwordChange(context)
    ];

    return Scaffold(
      body: Padding(
        padding: pd24h,
        child: Column(
          children: [
            CudiAppBar(title: "내 정보 수정", isWhite: true),
            profile(context),
            Padding(
              padding: pd24v,
              child: dividerMy,
            ),
            ListView(
              shrinkWrap: true,
              children: List.generate(myList.length, (index) {
                return myRowItem(context, myList[index], myColumnList[index],
                    buttonTitleList[index], buttonFunctionList[index]);
              }),
            ),
          ],
        ),
      ),
    );
  }
}