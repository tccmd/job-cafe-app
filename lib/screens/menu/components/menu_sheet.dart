import 'package:CUDI/screens/components/bottom_sheet.dart';
import 'package:CUDI/widgets/cudi_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../models/menu.dart';
import '../../../../utils/db/firebase_firestore.dart';
import '../../../../utils/provider.dart';
import '../../../../constants.dart';
import '../../components/app_bar.dart';
import 'menu_item.dart';

class MenuSheet extends StatefulWidget {
  const MenuSheet({super.key});

  @override
  State<MenuSheet> createState() => _MenuSheetState();
}

class _MenuSheetState extends State<MenuSheet> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BottomSheetOpened(body: body(), pd0: pd0);
  }

  Widget body() {
    return Column(
      children: [
        CudiAppBar(title: "메뉴보기", isPadding: true),
        menuPagination(),
        Flexible(child: pageView()),
      ],
    );
  }

  Widget menuPagination() {
    return Container(
      padding: pd24v,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: pd24L,
        child: Row(
          children: List.generate(
            categoryList.length,
            (index) => Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: button4(categoryList[index], () {
                setState(() {
                  currentIndex = index;
                });
                _pageController.jumpToPage(currentIndex);
              }, index == currentIndex),
            ),
          ),
        ),
      ),
    );
  }

  Widget pageView() {
    var u = UserProvider.of(context);
    return SizedBox(
      height: double.maxFinite,
      child: menusByCategory.isNotEmpty
          ? PageView.builder(
              controller: _pageController,
              itemCount: categoryList.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final category = categoryList[index];
                final categoryMenus = menusByCategory[category];
                return ListView.builder(
                  itemCount: categoryMenus!.length,
                  itemBuilder: (context, index) {
                    final coffeeItem = categoryMenus[index];
                    return MenuItem(
                      goToMenu: () => u.goMenuScreen(context, coffeeItem),
                      menu: coffeeItem,
                    );
                  },
                );
              },
            )
          : const Center(
              child: Text(
              '! 메뉴 준비중',
              style: TextStyle(color: gray80),
            )),
    );
  }

  // 파이어베이스 데이터
  Map<String, List<Menu>> menusByCategory = {};
  List<String> categoryList = [];
  List<String> categoryListSortOrder = []; // 원하는 순서대로 리스트 생성
  int currentIndex = 0;
  late PageController _pageController;

  // 파이어베이스 데이터
  void _initializeData() async {
    try {
      final data = await FireStore.getMenusGroupedByCategory(
          UserProvider.of(context).currentStore.storeId);
      if (mounted) {
        setState(() {
          menusByCategory = data;
        });
      }
    } catch (error) {
      print('getMenuList() failed');
    }
    // 기존의 categories Set을 List로 변환하여 원하는 순서로 배열
    categoryList = menusByCategory.keys.toList();
    categoryListSortOrder = [
      '시그니처',
      '계절메뉴',
      '드립커피',
      '커피',
      '음료',
      '기타',
      '디저트',
      '굿즈'
    ]; // 원하는 순서대로 리스트 생성

    categoryList.sort((a, b) {
      var indexA = categoryListSortOrder.indexOf(a);
      var indexB = categoryListSortOrder.indexOf(b);

      // a와 b가 모두 customOrder에 존재하는 경우
      if (indexA != -1 && indexB != -1) {
        return indexA.compareTo(indexB);
      }
      // a가 customOrder에 존재하지 않지만 b는 존재하는 경우
      else if (indexA == -1 && indexB != -1) {
        return 1; // b가 a보다 앞에 올 수 있도록 1 반환
      }
      // a가 customOrder에 존재하지만 b는 존재하지 않는 경우
      else if (indexA != -1 && indexB == -1) {
        return -1; // a가 b보다 앞에 올 수 있도록 -1 반환
      }
      // a와 b 모두 customOrder에 존재하지 않는 경우
      else {
        return a.compareTo(b); // 문자열 비교 기준으로 정렬
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
