import 'package:CUDI/screens/components/web_view.dart';
import 'package:CUDI/screens/menu/menu_screen.dart';
import 'package:CUDI/screens/my_cudi/my_cudi_screen.dart';
import 'package:CUDI/screens/order/cart_screen.dart';
import 'package:CUDI/screens/order/order_screen.dart';
import 'package:CUDI/screens/main_screens.dart';
import 'package:CUDI/screens/auth/launch_screen.dart';
import 'package:CUDI/screens/auth/splash_screen.dart';
import 'package:CUDI/screens/store/store_screen.dart';
import 'package:flutter/cupertino.dart';

class RouteName {
  static const splash = "/splash";
  static const launch = "/launch";
  static const login = "/login";
  static const home = "/home";
  static const store = "/cafe"; // 다이나믹 링크 표시 고려 store -> cafe로 링크 이름만 사용
  static const menu = "/menu";
  static const cart = "/cart";
  static const order = "/order";
  static const my = "/my";
  static const webView = "/web_view";
}

final namedRoutes = <String, WidgetBuilder> {
  RouteName.splash: (context) => const SplashScreen(),
  RouteName.launch: (context) => const LaunchScreen(),
  RouteName.home: (context) => const MainScreens(),
  RouteName.store: (context) => const StoreScreen(),
  RouteName.menu: (context) => const MenuScreen(),
  RouteName.cart: (context) => const CartScreen(),
  RouteName.order: (context) => const OrderScreen(),
  RouteName.my: (context) => const MyCUDIScreen(),
  RouteName.webView: (context) => const WebView(),
};