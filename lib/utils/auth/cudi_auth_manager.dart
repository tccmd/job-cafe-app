import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../routes.dart';
import '../../screens/auth/add_profile_screen.dart';
import '../../widgets/cudi_inputs.dart';
import '../../widgets/cudi_util_widgets.dart';
import '../db/firebase_firestore.dart';

class AuthenticationManager {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  late String _verificationId;
  late String _uid;
  late String _phoneNumber;

  // SMS 코드 검증 처리
  Future<void> verifyCode(BuildContext context, List<bool> checks, {bool? isModify}) async {
    try {
      auth.PhoneAuthCredential credential = auth.PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: certController.text);

      auth.UserCredential authResult = await _auth.signInWithCredential(credential);

      if (authResult.user != null) {
        _uid = authResult.user!.uid;
        print('사용자 인증 성공: $_uid');

        if (isModify != null && isModify) {
          _handleModify(context);
        } else {
          _handleSignUp(context, checks);
        }
      } else {
        print('사용자 인증 실패');
        snackBar(context, '인증에 실패하였습니다.');
      }
    } catch (error) {
      _handleAuthenticationError(context, error);
    }
  }

  // 수정 처리
  void _handleModify(BuildContext context) async {
    await FireStore.userUpdate(context, phoneNumber: phoneController.text);
    _showDialog(context, "연락처 변경완료", "성공적으로 연락처가 변경되었습니다!\n내 정보 페이지로 가시겠습니까?",
        button2Function: () {
          Navigator.pushNamedAndRemoveUntil(context, RouteName.my, (route) => false);
        });
  }

  // 회원가입 처리
  void _handleSignUp(BuildContext context, List<bool> checks) async {
    if (checks.isEmpty) {
      _uid = "인증 완료";
    }

    final CollectionReference usersCollection = FirebaseFirestore.instance.collection("user");
    QuerySnapshot<Object?> secessionUser = await usersCollection.where("user_id", isEqualTo: _uid).get();

    if (secessionUser.docs.isNotEmpty) {
      Map<String, dynamic>? userData = secessionUser.docs[0].data() as Map<String, dynamic>?;
      _handleSecessionUser(context, userData, checks);
    } else {
      _handleNewUser(context, checks);
    }
  }

  // 탈퇴한 사용자 처리
  void _handleSecessionUser(BuildContext context, Map<String, dynamic>? userData, List<bool> checks) {
    if (userData != null) {
      Timestamp? withdrawalTime = userData['secession_time'] as Timestamp?;

      if (withdrawalTime != null) {
        Timestamp now = Timestamp.now();
        Duration difference = now.toDate().difference(withdrawalTime.toDate());

        if (difference.inHours >= 24) {
          _handleRejoin(context, checks);
        } else {
          _handleRejoinUnavailable(context);
        }
      } else {
        _handleRejoinUnavailable(context);
      }
    } else {
      print('오류: userData가 null입니다.');
    }
  }

  // 재가입 처리
  Future<void> _handleRejoin(BuildContext context, List<bool> checks) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('user_phone_number', isEqualTo: _phoneNumber)
        .get();
    bool isExistUser = querySnapshot.docs.isEmpty;

    if (isExistUser) {
      _handleNewUser(context, checks);
    } else {
      _handleExistingUser(context);
    }
  }

  // 재가입 불가 다이얼로그 표시
  void _handleRejoinUnavailable(BuildContext context) {
    _showDialog(context, '재가입 불가', '탈퇴 후 24시간 이내 재가입 불가합니다.',
        button1Text: '닫기', button1Function: () => Navigator.pop(context));
  }

  // 이미 등록된 사용자 다이얼로그 표시
  void _handleExistingUser(BuildContext context) {
    print('이미 등록된 유저');
    _showDialog(context, '회원가입', '이미 등록된 유저입니다.',
        button1Text: '아이디, 비밀번호 찾기', button1Function: () {
          Navigator.pop(context);
          _showSnackBar(context, '준비중입니다.');
        }, button2Text: '닫기');
  }

  // 신규 사용자 처리
  Future<void> _handleNewUser(BuildContext context, List<bool> checks, {bool? isModify}) async {
    print('등록되지 않은 유저');
    if (isModify != null && isModify) {
      await FireStore.userUpdate(context, phoneNumber: _phoneNumber);
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AddProfileScreen(
            checks: checks,
            phoneNumber: _phoneNumber,
            uid: _uid,
          ),
        ),
      );
    }
  }

  // 인증 오류 메시지 표시
  void _handleAuthenticationError(BuildContext context, dynamic error) {
    // 코드 만료
    if (error.code == 'session-expired') {
      _showDialog(
          context, '인증코드 만료', 'SMS 코드가 만료되었습니다. 다시 시도하려면 인증코드를 다시 요청하세요.',
          button1Text: '닫기', button1Function: () => Navigator.pop(context));
      // 인증번호 틀리게 입력했을 때
    } else {
      _showSnackBar(context, '코드를 다시 확인해주세요.');
    }
  }

  // 다이얼로그 표시
  void _showDialog(BuildContext context, String title, String message,
      {String? button1Text, Function? button1Function, String? button2Text, Function? button2Function}) {
    cudiDialog(context, title, message,
        button1Text: button1Text,
        button1Function: () => button1Function,
        button2Text: button2Text,
        button2Function: () => button2Function);
  }

  // 스낵바 표시
  void _showSnackBar(BuildContext context, String message) {
    snackBar(context, message);
  }
}
