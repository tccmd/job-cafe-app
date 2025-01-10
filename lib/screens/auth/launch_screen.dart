import 'dart:ui';

import 'package:CUDI/screens/auth/login_screen.dart';
import 'package:CUDI/screens/auth/terms_screen.dart';
import 'package:CUDI/widgets/cudi_buttons.dart';
import 'package:CUDI/widgets/cudi_logos.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 3),
              launchLogo(),
              const Spacer(flex: 1),
              launchText(),
              const Spacer(flex: 2),
              Stack(children: [launchBeeni(),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // 블러 강도 설정
                    child: Container(
                      color: Colors.black.withOpacity(0.1), // 선택사항: 블러 위에 반투명 레이어 추가
                    ),
                  ),
                ),
              ]),
              const Spacer(flex: 2),
              launchButtons(),
              // const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }

  double _opacity = 0.0; // 초기 투명도 설정
  double _delay = 0.0; // 초기 딜레이 설정

  Widget launchLogo() {
    return AnimatedOpacity(
      opacity: _opacity, // 투명도를 변경하여 나타나게 함
      duration: const Duration(milliseconds: 500), // 애니메이션 지속 시간 설정
      child: textLineWhiteStart(),
    );
  }

  Widget launchText() {
    return AnimatedOpacity(
      opacity: _delay >= 1.0 ? 1.0 : 0.0, // 딜레이를 기반으로 투명도 설정
      duration: const Duration(milliseconds: 500), // 애니메이션 지속 시간 설정
      child: Text(
        '궁금했던 카페를 3D 공간으로',
        style: s20,
      ),
    );
  }

  Widget launchBeeni() {
    return AnimatedOpacity(
      opacity: _delay >= 2.0 ? 1.0 : 0.0, // 딜레이를 기반으로 투명도 설정
      duration: const Duration(milliseconds: 500), // 애니메이션 지속 시간 설정
      child: symbolCoffee(),
    );
  }

  //         height: 56.h + 56.h +20.h,
  Widget launchButtons() {
    return AnimatedOpacity(
      opacity: _delay >= 3.0 ? 1.0 : 0.0, // 딜레이를 기반으로 투명도 설정
      duration: const Duration(milliseconds: 500), // 애니메이션 지속 시간 설정
      child: Padding(
        padding: pd24202407,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            button1('로그인', () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            }),
            sbh20,
            button2('회원가입', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TermsScreen()));
            })
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _animateWidgets(); // 각 위젯을 서서히 나타나게 하는 함수
  }

  // 각 위젯을 서서히 나타나게 하는 함수
  Future<void> _animateWidgets() async {
    await Future.delayed(const Duration(milliseconds: 500)); // 첫 번째 위젯 딜레이
    setState(() {
      _opacity = 1.0; // 투명도를 변경하여 첫 번째 위젯을 나타나게 함
    });

    await Future.delayed(const Duration(milliseconds: 500)); // 두 번째 위젯 딜레이
    setState(() {
      _delay = 1.0; // 딜레이를 변경하여 두 번째 위젯을 나타나게 함
    });

    await Future.delayed(const Duration(milliseconds: 500)); // 세 번째 위젯 딜레이
    setState(() {
      _delay = 2.0; // 딜레이를 변경하여 세 번째 위젯을 나타나게 함
    });

    await Future.delayed(const Duration(milliseconds: 500)); // 네 번째 위젯 딜레이
    setState(() {
      _delay = 3.0; // 딜레이를 변경하여 세 번째 위젯을 나타나게 함
    });
  }
}
