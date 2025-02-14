import 'dart:ui';

import 'package:jobCafeApp/screens/home/near_screen.dart';
import 'package:jobCafeApp/screens/home/push_screen.dart';
import 'package:jobCafeApp/screens/home/view_more_screen.dart';
import 'package:flutter/material.dart';
import 'package:jobCafeApp/widgets/cudi_buttons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../utils/provider.dart';
import '../components/cudi_pay.dart';
import '../payments/my_cupay_screen.dart';
import 'components/main_stores.dart';
import '../../widgets/cudi_widgets.dart';
import '../components/big_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String uid;
  @override
  Widget build(BuildContext context) {
    uid = context.read<UserProvider>().uid;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: pd24L,
                  child: Column(
                    children: [
                      sbh16,
                      profile(),
                      mainSaying(),
                    ],
                  ),
                ),
                mainHorizonList(),
                Padding(
                  padding: pd24L,
                  child: Column(
                    children: [
                      sbh16,
                      sbh16,
                      mainViewMoreTextButton(),
                      sbh16,
                      view(),
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

  Widget profile() {
    return Padding(
      padding: pd00122412,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          circleBeany(context, isSmaile: true, size: 56),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Stack(
              //   children: [CUDIAnimatedIcon(assetPath: 'assets/images/img-cudipay.png', function: () => Navigator.push(context, MaterialPageRoute(
              //       builder: (context) => const MyCupayScreen())), width: 101.0,
              //     height: 32.0,),
              // ]),
              ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MyCupayScreen())), child: Text('MINTPAY')),
              SizedBox(
                width: 16.w,
                height: 10.h,
              ),
              SizedBox(
                width: 24.w,
                height: 24.h,
                child: IconButton(
                    icon: Image.asset(
                        'assets/icon/bell_none.png',
                      ),
                    constraints: const BoxConstraints(), // 아이콘 패딩 제거
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const PushScreen()));
                    }),
              ),
            ],
          )
        ],
      ),
    );
  }

  String viewMoreText = viewMoreTitles[0];

  Widget mainSaying() {
    return bigText('${context.read<UserProvider>().currentUser.userNickname ?? ''}님, 반가워요.\n궁금한 카페 3D로 구경해요!');
  }

  Widget mainHorizonList() {
    return SizedBox(
      height: 40.w,
      child: ListView.builder(
        padding: pd24L,
          scrollDirection: Axis.horizontal,
          itemCount: categoryItems.length,
          itemBuilder: (context, index) {
            return cudiHorizonListButton(
                categoryItems[index].label, categoryItems[index].icon, () async {
              setState(() {
                for (int i = 0; i < categoryItems.length; i++) {
                  categoryItems[i].isSelected = (i == index);
                }
                viewMoreText = viewMoreTitles[index];
              });
              await UtilProvider.getAndSetStores(context, index: index);
              if (index == 2) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const NearScreen()));
              }
            }, categoryItems[index].isSelected);
          }),
    );
  }

  Widget mainViewMoreTextButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 22.0),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ViewMoreScreen(title: viewMoreText))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              viewMoreText,
              style: TextStyle(
                fontSize: 20.0.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.4,
                height: 1.0,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget view() {
    return MainStores(whatScreen: "home_horizon");
  }
}

class CategoryItem {
  late bool isSelected;
  final String label;
  final String icon;

  CategoryItem(this.isSelected, this.label, this.icon);
}

// 페이지뷰
List<CategoryItem> categoryItems = [
  CategoryItem(true, 'NEW', 'assets/icon/new.png'),
  CategoryItem(false, 'HOT', 'assets/icon/hot.png'),
  CategoryItem(false, 'NEAR', 'assets/icon/near.png'),
  CategoryItem(false, 'RECENT', 'assets/icon/recent.png'),
];

List<String> viewMoreTitles = ['카페 신규 입점', '카페 찜 많은 순', '가까운 카페', '최근 방문한 카페'];