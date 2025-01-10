import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebView extends StatefulWidget {
  const WebView({super.key});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late WebViewController controller;
  final ValueNotifier<double> progressNotifier = ValueNotifier<double>(0);

  @override
  void dispose() {
    controller.reload();
    controller.clearLocalStorage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _arguements =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    // iOS media player background 재생할 수 있도록 설정 추가
    late final PlatformWebViewControllerCreationParams params;

    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true, // true 로 해줘야 백그라운드 재생 가능
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // 자바스크립트 무제한 설정
      ..setBackgroundColor(const Color(0xff000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            progressNotifier.value = progress.toDouble();
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            } else if (request.url.startsWith('tel:')) {
              // 전화 걸기+
              _makePhoneCall(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      // ..loadRequest(Uri.parse(_arguements["threeDUrl"]));
      ..loadRequest(Uri.parse("https://google.com"));

    return Scaffold(
        body: Stack(
          children: [
            WebViewWidget(controller: controller),
            ValueListenableBuilder<double>(
              valueListenable: progressNotifier,
              builder: (context, progressValue, child) {
                return progressValue < 100 ? Center(
                  child: Image.asset(
                    'assets/images/cudi_loading_trans_2.gif',
                    fit: BoxFit.fitWidth,
                  ),
                ) : const SizedBox.shrink();
              },
            ),
          ],
        ),
    );
  }

  // 전화 걸기
  Future<void> _makePhoneCall(String phoneNumber) async {
    try {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      bool launched = await launchUrl(launchUri);

      if (launched) {
        print('전화 걸기 성공: $phoneNumber');
      } else {
        print('전화 걸기 실패: $phoneNumber');
      }
    } catch (e) {
      print(e);
    }
  }
}