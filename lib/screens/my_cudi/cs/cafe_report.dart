import 'package:CUDI/utils/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../theme.dart';
import '../../../utils/enum.dart';
import '../../../widgets/cudi_buttons.dart';
import '../../../widgets/cudi_checkboxes.dart';
import '../../../widgets/cudi_inputs.dart';
import '../../../widgets/cudi_widgets.dart';
import '../../components/app_bar.dart';
import '../../components/icons/cart_icon.dart';
import '../components/etc.dart';
import 'email_inquiry.dart';
import '../../../constants.dart';

class CafeReport extends StatefulWidget {
  final String title;
  final bool? padding;
  final CartIcon? cartIcon;
  final String? buttonTitle;
  final void Function()? buttonClick;

  const CafeReport(
      {super.key,
        required this.title,
        this.cartIcon,
        this.padding,
        this.buttonTitle,
        this.buttonClick});

  @override
  State<CafeReport> createState() => _CafeReportState();
}

class _CafeReportState extends State<CafeReport> {
  @override
  Widget build(BuildContext context) {
    var u = UserProvider.of(context);
    var p = UtilProvider.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          sliverAppBar(context,
              title: widget.title, iconButton: widget.cartIcon),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 2000.h,
                // MediaQuery.of(context).size.height,
                    // -
                    // MediaQuery.of(context).padding.top -
                    // MediaQuery.of(context).padding.bottom,
                child: Column(
                  children: [
                    Padding(
                      padding:
                      widget.padding == null ? pd24h : EdgeInsets.zero,
                      child: Column(
                        children: [
                          // Text(Provider.of<UtilProvider>(context, listen: true).selectedItem2),
                          SizedBox(
                              height: 1800.h,
                              // MediaQuery.of(context).size.height -
                              //     MediaQuery.of(context).padding.top -
                              //     MediaQuery.of(context).padding.bottom,
                                  //- 166.h,
                              child: listViewWidget()
                          ),
                        ],
                      ),
                    ),
                    // const Spacer(),
                    Padding(
                      padding: pd24202407,
                      child: button1(
                          '제출하기', _sendEmail),
                    )
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }

  List<String> titleList = ['작성자', '카페지역', '카페이름', '신고사유', "신고내용", ""];

  Container bottomBorderContainer(int index) {
    List<Widget> widgetList = [userIdWidget(context), cafeAreaWidget(), cafeNameWidget(), reasonForReportWidget(reasonMap), reportDescWidget(), lastWidget()];
    return Container(
      decoration: index == widgetList.length-1 ? null: bottomBorder,
      child: Padding(padding: pd24all,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleList[index] == "" ? const SizedBox.shrink() : titleWidget(title: titleList[index]),
              titleList[index] == "" ? const SizedBox.shrink() : sbh24,
              widgetList[index]
            ],
          )),
    );
  }

  ListView listViewWidget() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: titleList.length, itemBuilder: (context, index) {
      return bottomBorderContainer(index);
    });
  }

  Widget cafeAreaWidget(){
    return DropdownMenu<String>(
      width: 342.w,
      menuHeight: 200.0,
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
      initialSelection: (enumMap.values.first.first.map((tab) => tagFilterLabels[tab] ?? '').join(' / ')),
      onSelected: (String? value) => Provider.of<UtilProvider>(context, listen: false).setSelectedItem2(value!),
      dropdownMenuEntries: enumMap.values.expand((tabList) {
        return tabList.map<DropdownMenuEntry<String>>((tabs) {
          var tabStringList = tabs.map((tab) => tagFilterLabels[tab] ?? '').toList(); // Use the Korean translation, default to an empty string if not found
          return DropdownMenuEntry<String>(
            value: tabStringList.join(' / '),
            label: tabStringList.join(' / '),
          );
        });
      }).toList(),
    );
  }

  String inputHint = '제목을 입력해 주세요.';
  TextEditingController cafeNameCont =  TextEditingController();
  Widget cafeNameWidget() {
    return SizedBox(height:48.0, child: filledTextField(context, controller: cafeNameCont, hintText: inputHint));
  }

  Map<String, List<String>> reasonMap = {
    '허위 정보가 포함되어 있습니다.': [
      '실제와 다른 정보 제공',
    ],
    '혜택을 이용할 수 없습니다.': [
      '쿠폰 사용 불가',
      '이벤트 참여 불가',
    ],
    '불법 정보가 포함되어 있습니다.': [
      '불법 정보 제공',
      '불법 상품 판매 및 유도',
    ],
    '청소년에게 유해한 내용이 포함되어 있습니다.': [
      '청소년에게 부적절한 내용 포함',
    ],
    '차별적/불쾌한 표현이 포함되어 있습니다.': [
      '욕설이나 타인에게 모욕감을 주는 내용 포함',
      '혐오/비하/경멸하는 내용 포함',
    ],
    '개인정보 노출 내용이 포함되어 있습니다.': [
      '타인의 개인정보 노출',
      '당사자의 동의 없이 개인을 특정지어 인지 가능한 부분',
    ],
  };

  Widget reasonForReportWidget(Map<String, List<String>> reasonMap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: reasonMap.entries.expand((entry) {
        return [
          Consumer<UtilProvider>(
            builder: (context, utilProvider, _) {
              List<bool?> checkboxValues = [
                utilProvider.reportCheck1,
                utilProvider.reportCheck2,
                utilProvider.reportCheck3,
                utilProvider.reportCheck4,
                utilProvider.reportCheck5,
                utilProvider.reportCheck6,
              ];

              int index = reasonMap.keys.toList().indexOf(entry.key);

              bool? variableValue;

              if (index >= 0 && index < checkboxValues.length) {
                variableValue = checkboxValues[index];
              }

              return checkRow(
                text: entry.key,
                value: variableValue ?? false,
                onChange: (bool value) {
                  if (index >= 0 && index < checkboxValues.length) {
                    // 해당하는 index의 체크박스 상태만 변경
                    checkboxValues[index] = value;
                    utilProvider.setReportChecks(checkboxValues);
                  }
                },
              );
            },
          ),
          SizedBox(height: 8.0.h,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: entry.value.map((value) {
              return Padding(
                padding: const EdgeInsets.only(left: 36.0),
                child: bulletText(text: value),
              );
            }).toList(),
          ),
        ];
      }).toList(),
    );
  }

  String inputDesc = '신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(500자 이하)신고내용을 입력해 주세요.(50';
  TextEditingController reportDescCont =  TextEditingController();
  Widget reportDescWidget() {
    return filledTextField(context, controller: reportDescCont, hintText: inputDesc, maxLines: 20);
  }

  List<String> noticeTextList = [
    '접수된 신고 내용과 사실 확인 후 절차에 따라 조치 진행됩니다.',
    '보복성, 허위 신고 등 고객 책임으로 확인이 될 경우, 앱 내 이용 제약이 있을 수 있습니다.',
    '접수된 신고 내용은 확인 및 수정이 되지 않습니다. 신중하게 확인하시고 신고 접수부탁드립니다.',
  ];
  Widget lastWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: noticeTextList
          .map(
            (text) => bulletText(
          text: text,
          bullet: '•', // 불릿 문자
        ),
      )
          .toList(),
    );
  }

  // 이메일 보내는 함수
  void _sendEmail() async {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    UtilProvider utilProvider = Provider.of<UtilProvider>(context, listen: false);

    List<String> checkedReasonsText = [];

    utilProvider.reportChecks.asMap().forEach((index, value) {
      if (value == true) {
        String reason = reasonMap.keys.toList()[index];
        List<String> values = reasonMap[reason] ?? [];

        // Format the checked reason and values
        String formattedText = '$reason(${values.join(', ')})';
        checkedReasonsText.add(formattedText);
      }
    });

    final Map<String, dynamic> data = {
      'service_id': dotenv.env['E_SERVICE_ID'],
      'template_id': dotenv.env['E_TEMPLATE_ID'],
      'user_id': dotenv.env['E_USER_ID'],
      'template_params': {
        'mail_prefix': "쿠디 카페 신고",
        'keyName1': "닉네임",
        'keyValue1': userProvider.currentUser.userNickname,
        'keyName2': "이메일",
        'keyValue2': userProvider.currentUser.userEmail,
        'keyName3': "카페지역",
        'keyValue3': Provider.of<UtilProvider>(context, listen: false).selectedItem2,
        'keyName4': "카페이름",
        'keyValue4': cafeNameCont.text,
        'keyName5': "신고사유",
        'keyValue5': checkedReasonsText.join(' / '),
        'keyName6': "신고내용: ",
        'keyValue6': reportDescCont.text,
        'img1': '',
        'img2': '',
        'img3': '',
      },
    };
    Navigator.push(context, MaterialPageRoute(builder: (context) => InAppWebViewExampleScreen(data: data)));
  }
}
