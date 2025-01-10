import 'package:CUDI/screens/auth/splash_screen.dart';
import 'package:CUDI/theme.dart';
import 'package:CUDI/utils/push/notification_service.dart';
import 'package:CUDI/utils/provider.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  final notificationService = NotificationService();
  WidgetsFlutterBinding.ensureInitialized();
  await notificationService.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load();

  // Initialize a GlobalKey to obtain context later
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Check if you received the link via `getInitialLink` first
  // final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
  // print('initialLink: $initialLink');

  // if (initialLink != null) {
  //   final Uri deepLink = initialLink.link;
  //   // Example of using the dynamic link to push the user to a different screen
  //   navigatorKey.currentState?.pushNamed(deepLink.path);
  //   print('deepLink: $deepLink');
  // }
  //
  // FirebaseDynamicLinks.instance.onLink.listen(
  //       (pendingDynamicLinkData) {
  //     // Set up the `onLink` event listener next as it may be received here
  //     if (pendingDynamicLinkData != null) {
  //       final Uri deepLink = pendingDynamicLinkData.link;
  //       // Example of using the dynamic link to push the user to a different screen
  //       navigatorKey.currentState?.pushNamed(deepLink.path);
  //       print('deepLink2: $deepLink');
  //       navigatorKey.currentState?.pushNamed(RouteName.my);
  //     }
  //
  //     if (pendingDynamicLinkData.link.queryParameters.containsKey("storeId")) {
  //       String storeId = pendingDynamicLinkData.link.queryParameters['storeId']!;
  //       print("storeId: $storeId");
  //       navigatorKey.currentState?.pushNamed(RouteName.my);
  //     }
  //   },
  // );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => UtilProvider()),
        ChangeNotifierProvider(create: (context) => SelectedTagProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true, // 너비와 높이의 최소값에 따라 텍스트를 조정할지 여부
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme(),
            home: const SplashScreen(),
            routes: namedRoutes,
          );
        });
  }
}

// 앱 실행 전에 NotificationSevice 인스턴스 생성
// Flutter 엔진 초기화 // 앱이 시작되기 전에 특정 플러그인이나 작업이 먼저 초기화되어야 할 때 사용된다.
// 푸시 알림이 비동기인 await으로 초기화하기 때문에 필수로 수행해야 한다.
// Flutter 프레임워크와 플러그인 사이의 바인딩이 초기화되고, 이후 초기화 작업이 정상적으로 수행되는 것을 보장하기 때문