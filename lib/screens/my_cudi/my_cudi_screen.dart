import 'package:jobCafeApp/screens/payments/my_coupon_screen.dart';
import 'package:jobCafeApp/screens/payments/my_cupay_screen.dart';
import 'package:jobCafeApp/screens/my_cudi/cs/customer_center_screen.dart';
import 'package:jobCafeApp/screens/my_cudi/cs/grade_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../models/store.dart';
import '../../theme.dart';
import '../../utils/db/firebase_firestore.dart';
import '../../utils/provider.dart';
import '../components/app_bar.dart';
import '../components/icons/cart_icon.dart';
import '../components/icons/svg_icon.dart';
import '../order/my_order_history_screen.dart';
import 'components/profile.dart';
import 'cs/event_screen.dart';
import 'cs/review_screen.dart';

class MyCUDIScreen extends StatefulWidget {
  const MyCUDIScreen({Key? key}) : super(key: key);

  @override
  State<MyCUDIScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyCUDIScreen> {
  // 파이어베이스 데이터
  void _initializeData() async {
    if (mounted) {}
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  Widget build(BuildContext context) {
    final uid = context.read<UserProvider>().uid;
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: <Widget>[
          sliverAppBar(context,
              title: '내 정보', isGoHome: true, iconButton: const CartIcon()),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: pd24h,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    profile(context, isMyScreen: true),
                    myRowList(),
                    dividerMy,
                    sbh8,
                    myColumnList(),
                    // TextButton(
                    //     onPressed: () {
                    //       Store store = Store(
                    //         uid: uid,
                    //         storeName: "카페 3",
                    //         storeSubTitle: "카페 3 설명입니다.",
                    //         storeDescription: "자가 이용 시 카페 맞은 편 산호주차장 주차가능(30분 1500원)하며 대중교통 이용 시 금련산역 1번출구에서 광안리 해변 쪽으로 3분 도보 입니다.",
                    //         storeAddress: "0000시 00구 00로 000번길 00 카페 3",
                    //         storeTell: "000-000-0000",
                    //         storeTraffic: "-",
                    //         storeHours: "11:00 - 19:00(18:30 라스트오더)",
                    //         storeClosed: "일요일",
                    //         storeParking: "00주차장 주차가능(00분 0000원)",
                    //         storeTMap: "https://surl.tmap.co.kr/a3086492",
                    //         storeThumbnail:
                    //         "",
                    //         storeImageUrl:
                    //         "",
                    //         storeVideoUrl:
                    //         "",
                    //         storeThreeDUrl: "https://goshow.me/bundle-3d-tags/",
                    //         storeImgList: ["", "", "", "", "", ""],
                    //         storeTagList: ["루프탑", "주차장"],
                    //       );
                    //       FireStore.addStore(store);
                    //     },
                    //     child: const Text('스토어 추가')),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget myRowList() {
    final Map<String, String> myRowListList = {
      '주문내역': 'assets/icon/ico-line-list-24px.svg',
      '민트페이': 'assets/icon/ico-line-cupay-24px.svg',
      '쿠폰': 'assets/icon/ico-line-cupon-24px.svg',
    };
    return Container(
      padding: pd24T,
      height: 144.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: myRowListList.length,
          itemBuilder: (context, index) {
            String key = myRowListList.keys.elementAt(index);
            List<Widget> myRowWidgetList = [
              MyOrderHistoryScreen(title: key),
              const MyCupayScreen(),
              MyCouponScreen(title: key),
            ];
            return InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => myRowWidgetList[index])),
              child: SizedBox(
                width: 114.w,
                height: 64.h,
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        svgIcon(myRowListList[key]!),
                        sbh24,
                        Text(key, style: w500),
                      ]),
                ),
              ),
            );
          }),
    );
  }

  Widget myColumnList() {
    List<String> myColumnListTitles = ['이벤트', '민트 등급', '리뷰', '고객센터'];
    return SizedBox(
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: myColumnListTitles.length,
          itemBuilder: (context, index) {
            List<Widget> myColumnWidgetList = [
              MyEventScreen(title: myColumnListTitles[index]),
              MyGradeScreen(title: myColumnListTitles[index]),
              MyReviewScreen(title: myColumnListTitles[index]),
              CustomerCenterScreen(title: myColumnListTitles[index]),
            ];
            return myColumItem(
                myColumnListTitles[index], myColumnWidgetList[index]);
          }),
    );
  }

  Widget myColumItem(title, route) {
    goFunction() =>
        Navigator.push(context, MaterialPageRoute(builder: (context) => route));
    return InkWell(
        onTap: goFunction,
        child: Padding(
          padding: pd16v,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: s16w500),
              svgIcon('assets/icon/ico-line-arrow-right-white-24px.svg',
                  function: goFunction),
            ],
          ),
        ));
  }
}
