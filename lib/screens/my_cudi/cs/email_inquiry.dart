import 'package:CUDI/widgets/cudi_util_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../routes.dart';
import '../../../theme.dart';
import '../../../utils/provider.dart';
import '../../../widgets/cudi_buttons.dart';
import '../../../widgets/cudi_checkboxes.dart';
import '../../../widgets/cudi_inputs.dart';
import '../../components/image_picker.dart';
import '../../components/app_bar.dart';
import '../../components/icons/cart_icon.dart';
import '../components/etc.dart';
import '../../../constants.dart';

class EmailInquiryScreen extends StatefulWidget {
  final String title;
  final bool? padding;
  final CartIcon? cartIcon;
  final String? buttonTitle;
  final void Function()? buttonClick;

  const EmailInquiryScreen(
      {super.key,
      required this.title,
      this.cartIcon,
      this.padding,
      this.buttonTitle,
      this.buttonClick});

  @override
  State<EmailInquiryScreen> createState() => _EmailInquiryScreenState();
}

class _EmailInquiryScreenState extends State<EmailInquiryScreen> {
  @override
  Widget build(BuildContext context) {
    var p = UtilProvider.of(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            sliverAppBar(context,
                title: widget.title, iconButton: widget.cartIcon),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height
                      - 88.h -
                      MediaQuery
                          .of(context)
                          .padding
                          .top -
                      MediaQuery
                          .of(context)
                          .padding
                          .bottom,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                        widget.padding == null ? pd24h : EdgeInsets.zero,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 584.h,
                              // // height: 662.h - 78.h,
                              //   height:MediaQuery.of(context).size.height - 88.h -
                              //       MediaQuery.of(context).padding.top -
                              //       MediaQuery.of(context).padding.bottom -
                              //       83.h,
                                child: listViewWidget()
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: pd24202407,
                        // padding: EdgeInsets.zero,
                        child: button1(
                            '${widget.buttonTitle}', p.allowButtonCheck ? _sendEmail : null),
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

  List<String> titleList = ['문의유형', '문의내용', '사진첨부(최대 3장)', '답변 받으실 정보', ""];

  Container bottomBorderContainer(int index) {
    List<Widget> widgetList = [
      inquiryTypeWidget(),
      inquiryDetailsWidget(),
      attachPicturesWidget(),
      informationToReceiveResponse(),
      lastWidget()
    ];
    return Container(
      decoration: index == widgetList.length - 1 ? null : bottomBorder,
      child: Padding(padding: pd24all,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleList[index] == "" ? const SizedBox.shrink() : titleWidget(
                  title: titleList[index]),
              titleList[index] == "" ? const SizedBox.shrink() : sbh24,
              widgetList[index]
            ],
          )),
    );
  }

  ListView listViewWidget() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: titleList.length, itemBuilder: (context, index) {
      return bottomBorderContainer(index);
    });
  }

  Widget inquiryTypeWidget() {
    UtilProvider utilProvider = context.read<UtilProvider>();
    return filledDropDownMenu(
        context, utilProvider.selectedItem, utilProvider.dropdownItems);
  }

  String inputHint = '제목을 입력해 주세요.';
  String inputDesc = '내용을 입력해 주세요.(200자 이내)내용을 입력해 주세요.(200자 이내)내용을 입력해 주세요.(200자 이내)내용을 입력해 주세요.(200자 이내)내용을 입력해 주세요.(200자 이내)내용을 입력해 주세요.(200자 이내)내용을 입력해 주세요.(200자 이내)내용을 입력해 주세요.(200자 이내)내용을 입력해 주세요.(200자 이내)내용을 입력해 주세';
  TextEditingController inquirySubjectCont = TextEditingController();
  TextEditingController inquiryDetailsCont = TextEditingController();

  Widget inquiryDetailsWidget() {
    return Column(
      children: [
        SizedBox(height:48.h, child: filledTextField(context, controller: inquirySubjectCont, hintText: inputHint)),
        sbh16,
        filledTextField(
            context, controller: inquiryDetailsCont, hintText: inputDesc, maxLines: 7),
      ],
    );
  }

  Widget attachPicturesWidget() {
    return SizedBox(
      height: 104.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          const AddImage(),
          selectedImagesWidget(context),
        ],
      ),
    );
  }

  String inputHint2 = '성함을 입력해 주세요.';
  String inputHint3 = '이메일을 입력해 주세요.';
  TextEditingController nameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();

  Widget informationToReceiveResponse() {
    return Column(
      children: [
        SizedBox(height:48.h, child: filledTextField(context, controller: nameCont, hintText: inputHint2)),
        sbh16,
        SizedBox(height:48.h, child: filledTextField(context, controller: emailCont, hintText: inputHint3)),
      ],
    );
  }

  String noticeText = '∙ 답변은 평균 7일 정도 소요됩니다. \n∙ 문의하신 답변이 완료되면 이메일로 알려드립니다.';

  Widget lastWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Text(
              noticeText,
              style: s12.copyWith(color: gray79)
          ),
        ),
        sbh24,
        checkboxWithRichTextWidget(context, '개인정보 수집 및 이용동의', dynamicText: '(자세히)', term_title: '개인정보 수집 및 이용동의', term_term: personalInfo),
      ],
    );
  }

  // 이메일 보내는 함수
  void _sendEmail() async {
    List<String?>? uploadedImageUrls = await Provider.of<UtilProvider>(context, listen: false).getAndUploadMultiImages(context);
      final Map<String, dynamic> data = {
        'service_id': dotenv.env['E_SERVICE_ID'],
        'template_id': dotenv.env['E_TEMPLATE_ID'],
        'user_id': dotenv.env['E_USER_ID'],
        'template_params': {
          'mail_prefix': "쿠디 이메일 문의",
          'keyName1': "성함",
          'keyValue1': nameCont.text,
          'keyName2': "이메일",
          'keyValue2': emailCont.text,
          'keyName3': "문의 유형",
          'keyValue3': context.read<UtilProvider>().selectedItem,
          'keyName4': "문의 제목",
          'keyValue4': inquirySubjectCont.text,
          'keyName5': "문의 내용",
          'keyValue5': inquiryDetailsCont.text,
          'img1': uploadedImageUrls.length > 0 ? uploadedImageUrls[0] : '',
          'img2': uploadedImageUrls.length > 1 ? uploadedImageUrls[1] : '',
          'img3': uploadedImageUrls.length > 2 ? uploadedImageUrls[2] : '',
        },
      };
    Navigator.push(context, MaterialPageRoute(builder: (context) => InAppWebViewExampleScreen(data: data)));
  }
}

class InAppWebViewExampleScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool? isJoin;
  final bool? isCode;

  const InAppWebViewExampleScreen({super.key, required this.data, this.isJoin, this.isCode});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
          ),
        ),
        onWebViewCreated: (InAppWebViewController controller) async {
          // WebView가 생성되면 HTML 코드를 로드
          controller.loadData(data: """
            <!DOCTYPE html>
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title></title>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/2.1.3/TweenMax.min.js"></script>
            <style>
              body,
              html {
                height: 100%;
              }
              
              body {
                background: #000000;
                display: flex;
                align-items: center;
                justify-content: center;
                flex-direction: column;
              }
              
              .bub-loader {
                width: 100%;
                height: 14px;
              }
              
              .bub-loader circle {
                fill: white;
                transform: scale(1);
              }
            </style>
            </head>
            <body>
            
            <svg version="1.1" class="bub-loader" viewBox="0 0 100 100">
              <circle cx="-250" cy="50" r="40"/>
              <circle cx="-100" cy="50" r="40"/>
              <circle cx="50" cy="50" r="40"/>
              <circle cx="200" cy="50" r="40"/>
              <circle cx="350" cy="50" r="40"/>
            </svg>

            <script>
            
            var loader = new TimelineMax({ repeat: -1, yoyo: true });
            var svglength = document.querySelectorAll('svg circle').length;
            var bubbles = [];
            
            for (var i = 1; i <= svglength; i++) {
              bubbles.push(document.querySelector('.bub-loader circle:nth-of-type(' + i + ')'));
            }
            
            loader.staggerTo(bubbles, 0.675, {
              css: {
                fill: 'none',
                opacity: 1,
                transform: 'scale(.75)',
              },
            }, 0.25);
            
            window.addEventListener("flutterInAppWebViewPlatformReady", function(event) {
                // 플러터 앱에 데이터를 요청합니다.
                window.flutter_inappwebview.callHandler('myHandlerName')
                    .then(function(result) {
                        // 요청한 데이터를 콘솔로 출력
                        console.log(JSON.stringify(result));
                        
                        // Attach the sendEmail function to the global scope
                        window.sendEmail = function() {
                            // Email.js API 엔드포인트 및 인증 정보 설정
                            var apiUrl = 'https://api.emailjs.com/api/v1.0/email/send';
        
                            // POST 요청을 위한 데이터 생성
                            var data = {
                                service_id: result.service_id,
                                template_id: result.template_id,
                                user_id: result.user_id,
                                template_params: {
                                    mail_prefix: result.template_params.mail_prefix,
                                    keyName1: result.template_params.keyName1,
                                    keyValue1: result.template_params.keyValue1,
                                    keyName2: result.template_params.keyName2,
                                    keyValue2: result.template_params.keyValue2,
                                    keyName3: result.template_params.keyName3,
                                    keyValue3: result.template_params.keyValue3,
                                    keyName4: result.template_params.keyName4,
                                    keyValue4: result.template_params.keyValue4,
                                    keyName5: result.template_params.keyName5,
                                    keyValue5: result.template_params.keyValue5,
                                    keyName6: result.template_params.keyName6,
                                    keyValue6: result.template_params.keyValue6,
                                    img1: result.template_params.img1,
                                    img2: result.template_params.img2,
                                    img3: result.template_params.img3,
                                    message: result.template_params.message,
                                    email: result.template_params.email
                                }
                            };
        
                            // Email.js API에 POST 요청 보내기
                            fetch(apiUrl, {
                                method: 'POST',
                                headers: {
                                    'Content-type':'application/json',
                                },
                                body: JSON.stringify(data),
                            })
                            .then(res => {
                              console.log(res.status);
                              if (res.status === 200) {
                                  return res.json();
                              } else if (res.status === 400) {
                                  return res.json();
                              }
                            })
                            .then(res => {
                              console.log("에러 메시지 ->", res.message);
                              // sendEmail 함수가 완료되면 창 닫기
                              self.opener = self;
                              window.close();
                            })
                           .catch(error => {
                              console.error(error);
                              // 에러가 발생하더라도 창 닫기
                              self.opener = self;
                              window.close();
                            });
                        }
                        
                        // 자동으로 sendEmail 함수 호출
                        window.sendEmail();
                    })
                    .catch(function(error) {
                        console.error(error);
                       // 에러가 발생하더라도 창 닫기
                      self.opener = self;
                      window.close();
                    });
            });
            </script>

            </body>
            </html>
          """);
          controller.addJavaScriptHandler(handlerName: 'myHandlerName', callback: (args) {
            debugPrint('args: $args');
            return data;
          });
        },
        onCloseWindow: (InAppWebViewController controller) {
          if(isCode == true){
            Navigator.pop(context);
          }
        },
        onConsoleMessage: (InAppWebViewController controller, ConsoleMessage consoleMessage) {
          // print("Console: ${consoleMessage.message}");
          if(consoleMessage.message.contains("200")) {
            if(isJoin == true) {
              print('이메일 인증 코드 정상 발송 됨');
              UtilProvider.of(context).setIsEmailSent(true);
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FindPwScreen(initialBodyIndex: 2)));
              snackBar(context, "인증코드가 전송되었습니다.");
            } else if (isCode == true) {
              print('이메일 인증 코드 정상 발송 됨 변경화면');
              UtilProvider.of(context).setIsEmailSent(true);
              snackBar(context, "인증코드가 전송되었습니다.");
            } else {
              Navigator.pushNamedAndRemoveUntil(context, RouteName.home, (route) => false);
              snackBar(context, "정상적으로 접수되었습니다.");
            }
          }
          if(consoleMessage.message.contains("400")) {
            snackBar(context, "다시 시도해주십시오.");
          }
        },
      ),
    );
  }
}