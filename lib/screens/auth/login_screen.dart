import 'package:CUDI/screens/auth/find_pw_screen.dart';
import 'package:CUDI/utils/auth/authentication.dart';
import 'package:CUDI/widgets/cudi_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../utils/provider.dart';
import '../../widgets/cudi_inputs.dart';
import '../components/app_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // state variable
  late UtilProvider utilProvider;
  late bool? isEmailValid;
  late bool? isPasswordValid;
  String emailHintText = '이메일을 입력해주세요';
  String pwHintText = '비밀번호를 입력해주세요';

  // 파이어베이스 인증
  late Authentication auth;

  @override
  void initState() {
    auth = Authentication();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    utilProvider = Provider.of<UtilProvider>(context);
    isEmailValid = utilProvider.isEmailValid;
    isPasswordValid = utilProvider.isPasswordValid;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: pd24h16v,
              child: cudiAppBar(context, appBarTitle: '로그인'),
            ),
            Padding(
              padding: pd24h16v,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    emailInput(context, "E-mail", emailHintText, emailController),
                    sbh24,
                    passwordInput(context, 'Password', pwHintText, passwordController, padding: false),
                    validationMessage(),
                    findPassword(),
                  ],
                ),
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
    bool able = isEmailValid == true && isPasswordValid == true;
    return buttonSpace(
      button1('로그인', able ? submit : null)
    );
  }

  Widget findPassword() {
    return UtilProvider.of(context).message == "아이디, 비밀번호를 확인해 주세요."
        ? GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FindPwScreen())),
        child: Text('비밀번호 찾기', style: s12)) : sb;
  }

  // 로그인 처리 로직
  Future submit() async {
    try {
      await auth.login(context, emailController.text, passwordController.text, true) ?? '';
    } catch (e) {
      if (e is FirebaseAuthException) {
        utilProvider.setMessage("아이디, 비밀번호를 확인해 주세요.");
      } else {
        utilProvider.setMessage("아이디, 비밀번호를 확인해 주세요.");
        debugPrint('Error: $e');
      }
    }
  }
}