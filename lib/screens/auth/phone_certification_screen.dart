import 'package:CUDI/utils/provider.dart';
import 'package:CUDI/widgets/cudi_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../widgets/cudi_inputs.dart';
import '../components/app_bar.dart';
import 'add_profile_screen.dart';

class PhoneCertificationScreen extends StatefulWidget {
  final List<bool> checks;

  const PhoneCertificationScreen({Key? key, required this.checks})
      : super(key: key);

  @override
  State<PhoneCertificationScreen> createState() =>
      _PhoneCertificationScreenState();
}

class _PhoneCertificationScreenState extends State<PhoneCertificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 키보드
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 앱바
            Padding(
              padding: pd24h16v,
              child: cudiAppBar(context, appBarTitle: '회원가입'),
            ),
            // 바디
            Padding(
              padding: pd24h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  phoneInput(context),
                  certInput(context, widget.checks),
                ],
              ),
            ),
            const Spacer(),
            // 버튼
            button(),
          ],
        ),
      ),
    );
  }

  Widget button() {
    var u = UtilProvider.of(context);
    return buttonSpace(
        !UtilProvider.of(context).isSent
            ? button1('인증번호 전송', u.isPhoneValid ?? false ?
            () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProfileScreen(
                    checks: widget.checks,
                    phoneNumber: '',
                    uid: 'web uid',
                  ),
                ),
              );
            }
            : null) // ()=> u.sendSMS(context, widget.checks) : null)
            : button1('인증완료', u.isCertValid ?? false ? ()=> u.verifyCode(context, widget.checks) : null)
    );
  }

  UtilProvider? utilProvider; // 새로운 변수 추가

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 상위 위젯에 대한 참조 저장
    utilProvider ??= Provider.of(context, listen: false);
  }

  @override
  void dispose() {
    // context 대신에 저장한 참조 사용
    if(utilProvider!=null) {
      utilProvider?.validatePhone('');
      utilProvider?.validateCert('');
      utilProvider?.setIsSent(false);
    }
    phoneController.clear();
    certController.clear();
    super.dispose();
  }

}
