import 'package:jobCafeApp/screens/auth/term_screen.dart';
import 'package:jobCafeApp/screens/my_cudi/cs/user_secession.dart';
import 'package:jobCafeApp/utils/auth/authentication.dart';
import 'package:jobCafeApp/utils/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../theme.dart';
import '../../../widgets/cudi_buttons.dart';
import '../../../widgets/cudi_checkboxes.dart';
import '../../components/app_bar.dart';
import '../../components/icons/cart_icon.dart';

class AppSetting extends StatefulWidget {
  final String title;
  final bool? padding;
  final CartIcon? cartIcon;
  final String? buttonTitle;
  final void Function()? buttonClick;

  const AppSetting(
      {super.key,
        required this.title,
        this.cartIcon,
        this.padding,
        this.buttonTitle,
        this.buttonClick});

  @override
  State<AppSetting> createState() => _AppSettingState();
}

class _AppSettingState extends State<AppSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            sliverAppBar(context,
                title: widget.title, iconButton: widget.cartIcon),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      88.h -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                        widget.padding == null ? pd24h : EdgeInsets.zero,
                        child: Column(
                          children: [
                            SizedBox(height: 668.h, child: listViewWidget()),
                          ],
                        ),
                      ),
                      if(widget.buttonClick != null) const Spacer(),
                      if(widget.buttonClick != null) Padding(
                        padding: pd24202407,
                        child: whiteButton(
                            '${widget.buttonTitle}', null, widget.buttonClick),
                      )
                    ],
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }

@override
  void initState() {
  UtilProvider.of(context).initSwitches(context);
  super.initState();
  }

  ListView listViewWidget() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: titleList.length, itemBuilder: (context, index) {
      return bottomBorderContainer(index);
    });
  }

  List<String> titleList = [
    '푸쉬알림',
    '프로모션 / 이벤트 알림 수신',
    '위치기반 정보서비스 이용약관 동의',
    'MINTPAY 알림',
    '이용약관',
    '개인정보처리방침',
    '버전정보',
    '로그아웃',
    '회원탈퇴',
  ];
  void goTermScreen(String title, String term){
    Navigator.push(context, MaterialPageRoute(builder: (context) => TermScreen(title: title, term: term, bgColor: black)));
  }

  Container bottomBorderContainer(int index) {
    UtilProvider utilProvider = Provider.of<UtilProvider>(context);
    List<Widget> widgetList = [
      primarySwitch(
        value: utilProvider.pushNotificationConsent,
        onChanged: (bool value) {
          utilProvider.setSwitch(context, 'pushNotificationConsent');
        },
      ),
      primarySwitch(
        value: utilProvider.promotionEventNotificationsConsent,
        onChanged: (bool value) {
          utilProvider.setSwitch(context, 'promotionEventNotificationsConsent');
        },
      ),
      primarySwitch(
        value: utilProvider.locationServiceConsent,
        onChanged: (bool value) {
          utilProvider.setSwitch(context, 'locationServiceConsent');
        },
      ),
      primarySwitch(
        value: utilProvider.cupayNotificationsConsent,
        onChanged: (bool value) {
          utilProvider.setSwitch(context, 'cupayNotificationsConsent');
        },
      ),
      IconButton(onPressed: () => goTermScreen('이용약관', serviceTerm), icon: const Icon(Icons.navigate_next), visualDensity: VisualDensity.compact),
      IconButton(onPressed: () => goTermScreen('개인정보처리방침', personalInfo), icon: const Icon(Icons.navigate_next), visualDensity: VisualDensity.compact),
      Text('v1.11.0', style: s16w500),
      IconButton(onPressed: () => Authentication().signOut(context), icon: const Icon(Icons.navigate_next), visualDensity: VisualDensity.compact),
      const SizedBox.shrink(),
    ];
    return Container(
      decoration: index == titleList.length-1 ? null: bottomBorder,
      child: Container(
          padding: pd24h,
          height: 72.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: index == titleList.length-1 ? (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const UserSecession(title: '회원탈퇴', padding: false,)));
                } : null,
                  child: Text(titleList[index], style: index == titleList.length-1 ? s16w500.copyWith(color: gray79) : s16w500)),
              widgetList[index]
            ],
          )),
    );
  }
}
