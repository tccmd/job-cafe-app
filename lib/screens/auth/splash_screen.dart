import 'dart:ui';

import 'package:jobCafeApp/routes.dart';
import 'package:jobCafeApp/utils/auth/authentication.dart';
import 'package:jobCafeApp/utils/db/firebase_firestore.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import '../../utils/provider.dart';
import '../../widgets/cudi_util_widgets.dart';
import 'launch_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 비동기 함수
    Future.delayed(const Duration(milliseconds: 2200), () async {

      // 자동 로그인
      Authentication auth = Authentication();
      auth.getUser().then((user) async {
        if (user != null) {
          await FireStore.getUser(user.email ?? "").then((data) async {
            if(data?.userEmail != null){
              debugPrint('회원가입된 유저');
              var u = UserProvider.of(context);
              await u.setUid(data?.uid ??"").then((value) async {
                await u.setCurrentUser().then((value) async {
                  await UtilProvider.getFavorites(context, u.uid);
                  Navigator.pushNamedAndRemoveUntil(context, RouteName.home, (route) => false);
                });
              });
            } else {
              // 유저 문서 없을 때
              navigateToNextScreen(context, const LaunchScreen());
            }
          });
        } else {
          // 자동 로그인 아닐 때
          navigateToNextScreen(context, const LaunchScreen());
        }
      });
      UserProvider.of(context).setSizes(context);
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: SizedBox(
                width: 162,
                child: Image.asset(
                  'assets/images/MintChoco.gif',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SizedBox(height: 270,)
          ],
        ),
      ),
    );

    // return Scaffold(
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         // Text('$user'),
    //         FilledButton(onPressed: () async {
    //           // User user = User(
    //           //   userEmail: "wwerwer",
    //           // );
    //           // String printText = await FireStore.addUser(user).toString();
    //           // dynamic printText =
    //           await FireStore.getUser("tccmd52@gmail.com");
    //           // print('$printText');
    //         }, child: Text('werwer'))
    //       ],
    //     ),
    //   ),
    // );
  }
}
