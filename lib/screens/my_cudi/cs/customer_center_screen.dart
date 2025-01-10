import 'package:CUDI/screens/my_cudi/cs/app_setting.dart';
import 'package:CUDI/screens/my_cudi/cs/cudi_info.dart';
import 'package:CUDI/screens/components/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../components/app_bar.dart';
import '../../components/icons/svg_icon.dart';
import 'cafe_report.dart';
import 'email_inquiry.dart';
import '../../../constants.dart';

class CustomerCenterScreen extends StatefulWidget {
  final String title;
  const CustomerCenterScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<CustomerCenterScreen> createState() => _CustomerCenterScreenState();
}

class _CustomerCenterScreenState extends State<CustomerCenterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            sliverAppBar(context, title: widget.title),
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  children: [
                    beanyCs(),
                    Container(
                      height: 1,
                      padding: pd24h,
                      child: const Divider(color: gray1C),
                    ),
                    noticeBox(),
                    csVerticalList()
                  ],
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget beanyCs(){
    return Padding(
        padding: pd24v,
      child: Column(
        children: [
          Image.asset('assets/images/img-cs.png', width: 109.w,height: 96.h),
          sbh24,
          Text('무엇을 도와드릴까요?', style: s20w600),
        ],
      ),
    );
  }

  Widget noticeBox(){
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AppbarScreen(title: appbarTitleList[0], column: columnList[0]))),
      child: Padding(
          padding: pd24all,
          child: Container(
            height: 48.h,
            padding: pd24h,
            decoration: BoxDecoration(
                color: primary,
              borderRadius: BorderRadius.circular(8.w)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/images/img-cs-notice.png', width: 24.w,),
                    sbh12,
                    Text('[공지]서비스 점검 안내', style: TextStyle(height: 1.sp),)
                  ],
                ),
                Text('전체보기', style: TextStyle(height: 1.sp),)
              ],
            ),
      ),
      ),
    );
  }

  Widget csVerticalList(){
    List<String> myColumnListList = ['이메일 문의', '카페 신고', '앱설정', 'CUDI 정보'];
    return Padding(
      padding: pd24h,
      child: SizedBox(
      height: 220.h,
      child: ListView.builder(
          itemCount: myColumnListList.length,
          itemBuilder: (context, index) {
            void navigator() {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                if(index == 0) {
                  return EmailInquiryScreen(title: appbarTitleList[index+1], padding: false, buttonTitle: '문의하기');
                  // return EmailSender();
                } else if (index == 1) {
                  return CafeReport(title: myColumnListList[index], padding: false);
                } else if (index == 2) {
                  return AppSetting(title: myColumnListList[index], padding: false);
                } else if (index == 3) {
                  return CUDIInfo(title: myColumnListList[index], padding: false);
                } else {
                  return AppbarScreen(title: appbarTitleList[index+1], column: columnList[index+1]);
                }
              }));
            }
            return SizedBox(
              height: 56.h,
              child: ListTile(
                onTap: navigator,
                  contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.h),
                  title: Text(myColumnListList[index], style: s16w500),
                  trailing: SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: IconButton(
                  onPressed: navigator,
                  padding: EdgeInsets.zero,
                  icon: svgIcon(
                            'assets/icon/ico-line-arrow-right-white-24px.svg'))),
              ),
            );
          }),
    )
    );
  }
}

/// 고객센터
List<String> appbarTitleList = ['고객센터', '이메일 문의', '카페 신고', '앱설정', 'CUDI 정보', '회원탈퇴'];
List<Column> columnList = [customerServiceCenter(), Column(), Column(), Column(), Column(), Column()];
DateTime time = DateTime.now();
Column customerServiceCenter() {
  return Column(
    children: [
      SizedBox(
        height: 668.h,
        child: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            return ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: const Text('[공지] 서비스 점검 안내'),
              subtitle: Text('${time.year}년 ${time.month}월 ${time.day}일', style: s12.copyWith(color: gray79)),
                children: [
                  Text("-", // lorem,
                  style: h17.copyWith(color: grayB5)),
                ]
            );
          },),
      ),
    ],
  );
}