import 'package:jobCafeApp/utils/db/firebase_firestore.dart';
import 'package:jobCafeApp/utils/provider.dart';
import 'package:jobCafeApp/widgets/cudi_inputs.dart';
import 'package:jobCafeApp/widgets/cudi_util_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../routes.dart';

class Authentication {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  Future<String?> login(BuildContext context, String email, String password, [bool isNav = false]) async {
    // 파이어베이스 auth 이메일, pw 로그인
    auth.UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    // 변수
    auth.User? user = userCredential.user;

    if(isNav) {
      UserProvider u = UserProvider.of(context);

      // 유저 set
      await FireStore.getUser(email).then((user) async {
        await u.setUid(user?.uid ?? "").then((value) async {
          await u.setCurrentUser().then((value) async {
            // 찜 set
            await UtilProvider.getFavorites(context, u.uid).then((value) {
              // 이동
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteName.home, (route) => false);
            });
          });
        });
      });
    }
    return user?.uid;
  }

  Future<String?> signUp(String emailAddress, String password) async {
    auth.UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: emailAddress, password: password);
    auth.User? user = userCredential.user;
    print("signUp: user?.uid: ${user?.uid}");
    return user?.uid;
  }

  Future<void> signOut(BuildContext context, {bool? isGoSplash}) async {
    _firebaseAuth.signOut();
    debugPrint('로그아웃');
    if (isGoSplash != null && !isGoSplash) {
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, RouteName.splash, (route) => false);
    }
  }

  Future<auth.User?> getUser() async {
    auth.User? user = _firebaseAuth.currentUser;
    print("getUser: $user");
    return user;
  }

  Future updatePassword(
      BuildContext context, {required String email, required String pw, required String newPassword, bool isNav = false}) async {
      await login(context, email, pw).then((value) async {
      print('유저pw로그인: $value');
      await getUser().then((user) async {
        await FireStore.userUpdate(context, newUserPw: newPassword).then((value) async {
          await UserProvider.of(context).setCurrentUser().then((value) async {
            await user?.updatePassword(newPassword).then((value) {
              if (isNav) {
                String title = '비밀번호 변경완료';
                String desc = '성공적으로 비밀번호가 변경되었습니다!\n내 정보 페이지로 가시겠습니까?';
                cudiDialog(context, title, desc, button2Function: () {
                  Navigator.pushNamedAndRemoveUntil(context, RouteName.my, (route) => false);
                });
              } else {
                String title = '비밀번호 설정완료';
                String desc = '새 비밀번호 설정이 완료되었습니다!\n지금 로그인 하시겠습니까?';
                cudiDialog(context, title, desc, button1Text: "로그인",
                    button1Function: () async {
                      await login(context, emailController.text, newPassword);
                    });
              }
            }).catchError((e) {
              print('비밀번호 업데이트 에러: $e');
            });
          });
        });
      });
    }).catchError((e) {
      print('유져pw에러: $e');
    });
  }

  // Future<void> updateEmail(BuildContext context, String newEmail) async {
  //   var u = UserProvider.of(context);
  //   final credential = await _firebaseAuth.signInWithEmailAndPassword(
  //       email: u.currentUser.userEmail ?? '', password: u.currentUser.userPassword ?? '');
  //   auth.User? user = credential.user;
  //   await user?.reauthenticateWithCredential(credential);
  //   await getUser().then((auth.User? user) async {
  //
  //     await user?.updateEmail(newEmail);
  //   });
  // }

  Future<void> updateEmail(BuildContext context, String newEmail) async {
    // 인증해야 함
    try {
      var u = UserProvider.of(context);

      // 이메일과 비밀번호로 AuthCredential 생성
      auth.AuthCredential credential = auth.EmailAuthProvider.credential(
        email: u.currentUser.userEmail ?? '',
        password: u.currentUser.userPassword ?? '',
      );

      // 사용자를 다시 인증
      auth.User? user = (await _firebaseAuth.signInWithEmailAndPassword(
        email: u.currentUser.userEmail ?? '',
        password: u.currentUser.userPassword ?? '',
      )).user;

      await user?.reauthenticateWithCredential(credential);

      // 사용자의 이메일 업데이트
      await user?.updateEmail(newEmail);

      // 이메일 업데이트 성공 시의 추가 로직
      print('이메일 업데이트 성공');
    } catch (e) {
      if (e is auth.FirebaseAuthException) {
        print('Firebase Auth Exception - Code: ${e.code}, Message: ${e.message}');
        // 여기에서 에러 코드에 따른 처리 수행
        // 예: 에러 코드에 따른 사용자에게 알림, 특정 동작 등
      } else {
        print('Unexpected Error: $e');
      }
    }
  }

  Future<void> deleteCurrentUser(BuildContext context, {auth.AuthCredential? authCredential}) async {
    try {
      // 현재 로그인된 사용자 가져오기
      auth.User? user = auth.FirebaseAuth.instance.currentUser;

      if (authCredential != null) {
        // 외부에서 전달된 사용자 자격 증명 사용
        await user?.reauthenticateWithCredential(authCredential);
      } else {
        // 사용자 다시 인증 (이메일/비밀번호로)
        auth.AuthCredential credential = auth.EmailAuthProvider.credential(
          email: context.read<UserProvider>().currentUser.userEmail ?? '',
          password: context.read<UserProvider>().currentUser.userPassword ?? '',
        );
        await user?.reauthenticateWithCredential(credential);
      }

      // 사용자 삭제
      await user?.delete();
      print('사용자 삭제 성공');
    } catch (error) {
      print('사용자 삭제 중 오류 발생: $error');
    }
  }
}