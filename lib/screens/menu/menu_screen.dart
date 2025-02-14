import 'package:jobCafeApp/routes.dart';
import 'package:jobCafeApp/screens/order/components/option_sheet.dart';
// import 'package:jobCafeApp/utils/secure_shot.dart';
import 'package:jobCafeApp/screens/components/closed_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants.dart';
import '../../../../models/cart.dart';
import '../../../../models/menu.dart';
import '../../../../utils/db/firebase_firestore.dart';
import '../../../../utils/provider.dart';
import '../../widgets/cudi_util_widgets.dart';
import '../../widgets/cudi_widgets.dart';
import '../components/app_bar.dart';
import '../components/icons/cart_icon.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late Menu menu;
  late Cart cart;

  // 페이지네이션
  int currentIndex = 0;
  late PageController _pageController;

  // 크게 보기
  bool isView = false;

  // 버튼
  late List<BottomSheetItem> bottomSheetItems;

  @override
  void initState() {
    super.initState();
    menu = UserProvider.of(context).currentMenu;
    cart = Cart(
      uid: UserProvider.of(context).uid,
      storeId: menu.storeId,
      menuId: menu.menuId,
      menuName: menu.menuName,
      menuImgUrl: menu.menuImgList?[0],
      menuSumPrice: menu.menuPrice,
      quantity: 1,
      cup: "매장컵",
    );
    _pageController = PageController(initialPage: currentIndex);
    // SecureShot.on();
  }

  @override
  void dispose() {
    _pageController.dispose();
    // SecureShot.off();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bottomSheetItems = [
      BottomSheetItem(
        buttonName: "메뉴담기",
        onClick: () async {
          await FireStore.addCart(context, cart).then((value) {
            snackBar(context, '장바구니에 상품을 담았습니다.',
                label: '보러가기',
                onClick: () {
                  Navigator.pushNamed(context, RouteName.cart);
                  UserProvider.of(context).setIsCartAdded(false);
                });
          });
        },
        assetPath: "assets/icon/ico-line-cart.png",
      ),
      BottomSheetItem(
        buttonName: "바로결제",
        onClick: () async {
          await FireStore.addCart(context, cart).then((value) {
            Navigator.pushNamed(context, RouteName.order);
            UserProvider.of(context).setIsCartAdded(false);
          });
        },
        assetPath: "assets/icon/ico-line-pay.png",
      ),
    ];
    return Scaffold(
      body: Stack(
        children: [
          menuImage(),
          if (!isView) stacks(),
        ],
      ),
    );
  }

  Widget menuImage() {

    String menuAsset;
    if (menu.menuCategory == "시그니처") {
      menuAsset = "assets/images/americano.jpg";
    } else if (menu.menuCategory == "커피") {
      menuAsset = "assets/images/latte.jpg";
    } else {
      menuAsset = "assets/images/juice.jpeg";
    }

    double mh = MediaQuery.of(context).size.height;
    double mpb = MediaQuery.of(context).padding.bottom;
    double imageHeight = isView ? mh - mpb : 580.h;
    double mw = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => setState(() => isView = !isView),
      child: SizedBox(
        height: imageHeight,
        width: mw,
        child: PageView.builder(
          controller: _pageController,
          itemCount: menu.menuImgList?.length,
          onPageChanged: (index) => setState(() => currentIndex = index),
          itemBuilder: (context, index) {
            return Image.asset(
              menuAsset, // menu.menuImgList?[index] ?? '',
              width: mw,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  color: grayEA,
                  child: Center(
                      child: Text(
                    nullDataText,
                    style: const TextStyle(color: gray58),
                  )), // 에러 발생 시 대체할 색 또는 위젯 설정
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget stacks() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        top(),
        bottoms(),
      ],
    );
  }

  Widget top() {
    return Padding(
      padding: pd18h16v,
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: cudiAppBar(context, iconButton: CartIcon()),
      ),
    );
  }

  Widget bottoms() {
    return Column(
      children: [
        ClosedSheet(body: MenuInfo(isOpenSheet: false,), sheet: const OptionSheet()),
        sheetButtonsWidget(),
      ],
    );
  }

  Widget sheetButtonsWidget() {
    return SheetButton(bottomSheetItems: bottomSheetItems);
  }
}
