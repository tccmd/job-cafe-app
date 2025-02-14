import 'package:jobCafeApp/widgets/cudi_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../screens/components/icons/svg_icon.dart';
import '../utils/provider.dart';
import '../constants.dart';

// Form Controllers
final TextEditingController eBeforeController = TextEditingController();
final TextEditingController emailController = TextEditingController(text: 'example@example.com');
final TextEditingController certController = TextEditingController();
final TextEditingController passwordController = TextEditingController(text: 'password');
final TextEditingController pwBeforeController = TextEditingController();
final TextEditingController pwConfirmController = TextEditingController(text: 'password');
final TextEditingController nickNameController = TextEditingController();
final TextEditingController birthController = TextEditingController();
final TextEditingController phoneController = TextEditingController();


TextField filledTextField(BuildContext context, {required TextEditingController controller, required String hintText, int? maxLines, void Function(String)? onChanged}) {
  return TextField(
    controller: controller,
    expands: false,
    cursorColor: gray54,
    maxLines: maxLines ?? 1,
    onTapOutside: (PointerDownEvent event) {
      // Handle tap outside the text field, e.g., hide the keyboard
      FocusScope.of(context).unfocus();
    },
    onChanged: onChanged,
    decoration: InputDecoration(
      filled: true,
      fillColor: gray1C,
      contentPadding: pd20h16v,
      hintText: hintText,
      hintStyle: const TextStyle(color: gray54),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0), // 모서리 둥글기 설정
        borderSide: BorderSide.none, // 밑줄 없애기
      ),
      suffixIcon: controller == pwBeforeController ? Padding(
        padding: const EdgeInsets.only(right: 10),
        child: validationIcon(pwBeforeController),
      ) : null,
    ),
  );
}

TextField basicTextField(BuildContext context,
    {required TextEditingController controller,
    String? hintText,
    TextInputType? keyboardType,
    Widget? suffixIcon,
    void Function(String)? onChanged,
      void Function()? onTap,
    bool? obscureText, List<TextInputFormatter>? formatter, bool? enabledFalse, int? maxLength}) {
  return TextField(
    controller: controller,
    keyboardType: keyboardType,
    onTapOutside: (PointerDownEvent event) {
      // Handle tap outside the text field, e.g., hide the keyboard
      FocusScope.of(context).unfocus();
    },
    maxLength: maxLength,
    obscureText: obscureText ?? false,
    obscuringCharacter: '*',
    inputFormatters: formatter ?? [],
    onChanged: onChanged,
    onTap: onTap,
    cursorColor: white,
    enabled: enabledFalse ?? true,
    decoration: InputDecoration(
      hintText: hintText,
        hintStyle: s16.copyWith(color: gray54),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: white), // 밑줄 색상 설정
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: white), // 선택된 밑줄 색상 설정
        ),
        // constraints: BoxConstraints(minHeight: 56.0, maxHeight: 56.0),
        //focusColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 20.0.h),
        suffixIcon: suffixIcon),
  );
}

Widget validationIcon(TextEditingController controller) {
  return Consumer<UtilProvider>(
    builder: (context, provider, child) {
      bool? isValid;
      if (controller == emailController) {
        isValid = provider.isEmailValid;
      } else if (controller == eBeforeController) {
        isValid = provider.isEBeforeValid;
      } else if (controller == certController) {
        isValid = provider.isCertValid;
      } else if (controller == passwordController) {
        isValid = provider.isPasswordValid;
      } else if (controller == pwBeforeController) {
        isValid = provider.isPWBeforeValid;
      } else if (controller == pwConfirmController) {
        isValid = provider.isPWConfirmValid;
      } else if (controller == nickNameController) {
        isValid = provider.isNicknameValid;
      }  else if (controller == birthController) {
        isValid = provider.isBirthValid;
      } else if (controller == phoneController) {
        isValid = provider.isPhoneValid;
      } else {
        isValid = false;
      }
      return GestureDetector(
        onTap: () {
          if (controller.text.isNotEmpty) {
            controller.clear();
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: isValid != null
              ? svgIcon(isValid
              ? 'assets/icon/ico-line-completed.svg'
              : 'assets/icon/ico-fill-delete.svg')
              : sb, // 크기가 제로라는 사실을 명시적으로 나타냄
        ),
      );
    },
  );
}

Widget emailInput(context, String label, String hintText, TextEditingController _emailController, {bool? join, bool? enabledFalse}) {
  UtilProvider utilProvider = Provider.of<UtilProvider>(context);
  return Padding(
    padding: pd24v,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        join ?? false ? richText('E-mail') : Text(label, style: w500.copyWith(color: white)),
        basicTextField(
          context,
          controller: _emailController,
          hintText: hintText,
          keyboardType: TextInputType.emailAddress,
          enabledFalse: enabledFalse ?? true,
          onChanged: (value) {
            if (_emailController == emailController) {
              utilProvider.validateEmail(value);
            } else if (_emailController == eBeforeController) {
              utilProvider.validateEBefore(value);
            }
          },
          onTap: () {
            utilProvider.validateEmail(_emailController.text);
          },
          suffixIcon: validationIcon(_emailController),
        ),
      ],
    ),
  );
}

Widget certInput(context, List<bool> checks, {String? userPhoneNumber, String? email}) {
  return Consumer<UtilProvider>(
    builder: (context, p, child) {
      bool isSent = p.isSent && !p.isEmailSent;
      bool unMatched = p.isEmailCodeMatched ?? false;
      return p.isSent || p.isEmailSent ? Padding(
        padding: pd24T.copyWith(bottom: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('인증 번호', style: w500),
            basicTextField(
              context,
              controller: certController,
              hintText: '인증번호를 입력해 주세요.',
              onChanged: (value) => p.validateCert(value),
              suffixIcon: validationIcon(certController),
              enabledFalse: p.timeText == "0:00" ? false : true,
            ),
            if(isSent) sbh16,
            if(isSent) Text('남은 시간 ${p.timeText}', style: const TextStyle(height:1.0, color: error)),
            if(isSent )Column(
              children: [
                sbh8,
                GestureDetector(
                  onTap: p.resendMessage != "" ? () => p.sendSMS(context, checks, userPhoneNumber) : null,
                  child: Text(p.resendMessage, style: const TextStyle(color: white)),
                ),
              ],
            ),
            if (unMatched) sbh16,
            if (unMatched)
              Text('인증번호를 확인해 주세요.',
                  style: const TextStyle(height: 1.0, color: error)),
            if (unMatched)
              GestureDetector(
                onTap: () => UtilProvider.of(context).sendEmail(context, email??''),
                child: Text("인증번호 재전송", style: const TextStyle(color: white)),
              ),
          ],
        ),
      ) : sb;
    },
  );
}

Widget passwordInput(context, String label, String hintText, TextEditingController _passwordController, {bool? padding}) {
  UtilProvider utilProvider = Provider.of<UtilProvider>(context);
  return Padding(
    padding: padding ?? true ? pd24v : pd24T,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(label != '')Text(label, style: w500),
        basicTextField(
          context,
          controller: _passwordController,
          hintText: hintText,
          obscureText: true,
          onChanged: (value) {
            if (_passwordController == passwordController) {
              utilProvider.validatePassword(value);
            } else if (_passwordController == pwBeforeController) {
              utilProvider.validatePWBefore(value);
            } else if (_passwordController == pwConfirmController) {
              utilProvider.validatePWConfirm(value);
            }
          },
          onTap: () {
            utilProvider.validatePassword(_passwordController.text);
          },
          suffixIcon: validationIcon(_passwordController),
        ),
      ],
    ),
  );
}

Widget nickNameInput(BuildContext context, {bool? join}) {
  UtilProvider utilProvider = Provider.of<UtilProvider>(context);
  UserProvider userProvider = Provider.of<UserProvider>(context);
  return Padding(
    padding: pd24v,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        join ?? false ? richText('닉네임') : Text('닉네임', style: w500),
        basicTextField(
          context,
          maxLength: 15,
          controller: nickNameController,
          hintText: join ?? false ? '최대 15자리로 입력해 주세요.' : userProvider.currentUser.userNickname ?? '최대 15자리로 입력해 주세요.',
          onChanged: (value) => utilProvider.validateNickname(value),
          suffixIcon: validationIcon(nickNameController),
        ),
      ],
    ),
  );
}

Widget birthInput(BuildContext context, {bool? join}) {
  UtilProvider utilProvider = Provider.of<UtilProvider>(context);
  UserProvider userProvider = Provider.of<UserProvider>(context);
  return Padding(
    padding: pd24v,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('생년월일', style: w500),
        basicTextField(
            context,
          controller: birthController,
          hintText: join ?? false ? "YYYY-MM-DD" : userProvider.currentUser.userBirth ?? "YYYY-MM-DD",
          onChanged: (value) => utilProvider.validateBirth(value),
          suffixIcon: validationIcon(birthController),
          formatter: [
              LengthLimitingTextInputFormatter(10), // 최대 길이 제한 (0000-00-00)
              // FilteringTextInputFormatter.digitsOnly, // 숫자만 허용
              BirthTextInputFormatter(), // 생일 형식 적용
          ]
        ),
      ],
    ),
  );
}

Widget phoneInput(BuildContext context, {TextEditingController? phBeforeController}) {
  UtilProvider utilProvider = Provider.of<UtilProvider>(context);
  return Padding(
    padding: pd24v,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('휴대폰 번호', style: w500),
        basicTextField(
            context,
            controller: phBeforeController ?? phoneController,
            hintText: '휴대폰 번호를 입력해 주세요.',
            onChanged: (value) => utilProvider.validatePhone(value),
            suffixIcon: validationIcon(phoneController),
            formatter: [
              // LengthLimitingTextInputFormatter(11), // 최대 길이 제한 (00000000000)
              // FilteringTextInputFormatter.digitsOnly, // 숫자만 허용
              LengthLimitingTextInputFormatter(17), // 최대 길이 제한 (000 - 0000 - 0000)
              FilteringTextInputFormatter.digitsOnly, // 숫자만 허용
              PhoneNumberTextInputFormatter(), // 전화번호 형식 적용
            ]
        ),
      ],
    ),
  );
}

// 번호에서 - 빼는 함수
class PhoneNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // 입력된 값에서 숫자만 추출
    final newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    String formattedText = '';
    for (var i = 0; i < newText.length; i++) {
      if (i == 3 || i == 7) {
        formattedText += ' - ';
      }
      formattedText += newText[i];
    }

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class BirthTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // 입력된 값에서 숫자만 추출
    final newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    String formattedText = '';
    for (var i = 0; i < newText.length; i++) {
      if (i == 4 || i == 6) {
        formattedText += '-';
      }
      formattedText += newText[i];
    }

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

Widget genderBtn (context){
  return Consumer<UtilProvider>(builder: (context, utilProvider, child) {
      return Row(
        children: [
          Expanded(
              child: SizedBox(
                height: 48.0.h,
                child: button4('남성', (){
                    utilProvider.setGender('남성');
                  }, utilProvider.gender == '남성',
                ),
              )
          ),
          SizedBox(width: 20.w),
          Expanded(
              child: SizedBox(
                height: 48.0.h,
                child: button4('여성', (){
                    utilProvider.setGender('여성');
                  }, utilProvider.gender == '여성',
                ),
              )
          ),
        ],
      );
    },
  );
}

Widget genderInput(BuildContext context, {bool? join}) {
  return Padding(
    padding: pd24v,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('성별', style: w500),
        sbh24,
        genderBtn(context),
      ],
    ),
  );
}

Widget validationMessage() {
  return Consumer<UtilProvider>(
    builder: (context, utilProvider, child) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
          child: Text(
            utilProvider.message,
            style: s12.copyWith(color: error),
          ),
        ),
      );
    },
  );
}

Widget filledDropDownMenu(BuildContext context, String initialSelection, List<String> dropDownItems) {
  UtilProvider utilProvider = context.read<UtilProvider>();
  return DropdownMenu<String>(
    width: 342.w,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: gray1C,
      filled: true,
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(width: 0)),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0)
    ),
    textStyle: const TextStyle(color: grayC1),
    menuStyle: MenuStyle(
      backgroundColor: MaterialStateProperty.all(gray1C),
      surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
      shadowColor: MaterialStateProperty.all(black),
      elevation: MaterialStateProperty.all(5.0),
    ),
    initialSelection: initialSelection,
    onSelected: (String? value) => utilProvider.setSelectedItem(value!),
    dropdownMenuEntries: dropDownItems.map<DropdownMenuEntry<String>>((String value) {
      return DropdownMenuEntry<String>(value: value, label: value);
    }).toList(),
  );
}

Widget richText(String richTit) {
  return RichText(
      text: TextSpan(
          text: richTit,
          style: w500.copyWith(color: white),
          children: const [
            TextSpan(
              text: '*',
              style:
              TextStyle(fontWeight: FontWeight.w500, height: 1.0, color: error),
            )
          ]));
}