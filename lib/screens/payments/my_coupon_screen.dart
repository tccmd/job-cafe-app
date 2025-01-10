import 'package:CUDI/models/coupon.dart';
import 'package:CUDI/utils/db/firebase_firestore.dart';
import 'package:CUDI/utils/provider.dart';
import 'package:CUDI/widgets/cudi_buttons.dart';
import 'package:CUDI/widgets/cudi_util_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../models/user.dart';
import '../../widgets/cudi_widgets.dart';
import '../components/app_bar.dart';
import '../components/icons/svg_icon.dart';

class MyCouponScreen extends StatefulWidget {
  final String title;

  const MyCouponScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<MyCouponScreen> createState() => _MyCouponScreenState();
}

class _MyCouponScreenState extends State<MyCouponScreen> {
  List<String> tabBarTitles = ['전체', '사용가능', '사용완료'];

  List<Coupon> coupons = []; // 전체 모든 쿠폰들
  List<Coupon> userCoupons = []; // 유저가 가진 쿠폰

  late double thisHeight;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    var u = UserProvider.of(context);
    late List<Coupon> data;
    late List<Coupon> data2;
    if (mounted) {
      data = await FireStore.getCoupons();
      data2 = await FireStore.getUserCoupons(u.currentUser.userEmail ?? '');
      setState(() {
        coupons = data;
        userCoupons = data2;
      });
    }
  }

  Future<void> _refresh() async {
    _initializeData();
  }

  @override
  Widget build(BuildContext context) {
    thisHeight = MediaQuery.sizeOf(context).height - (91.h + 83.h);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            _buildSliverAppBar(context),
            _buildSliverList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return sliverAppBar(context, title: widget.title);
  }

  Widget _buildSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(addRepaintBoundaries: true, [
        DefaultTabController(
          length: tabBarTitles.length,
          child: SizedBox(
            height: thisHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // FilledButton(onPressed: () async {
                //   Coupon c = Coupon(
                //     couponName: 'OOU 카페',
                //     state: "사용가능",
                //     discountRate: 1700,
                //     finishDate: DateTime.now().add(const Duration(days: 30)),
                //     conditions: ["알림수신동의"],
                //   );
                //   FireStore.addCoupon(c);
                // }, child: Text('Function')),
                tabBar(),
                tabBarView(),
                bottoms(),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget tabBar() {
    return TabBar(
      labelStyle: s16w500,
      unselectedLabelColor: white,
      dividerColor: gray80,
      labelPadding: const EdgeInsets.all(16.0),
      indicatorWeight: 1.0,
      indicatorSize: TabBarIndicatorSize.tab,
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      tabs: tabBarTitles.map((e) => Text(e)).toList(),
    );
  }

  Widget tabBarView() {
    final filteredCouponsA =
        userCoupons.where((item) => item.state == tabBarTitles[1]).toList();
    final filteredCouponsNA =
        userCoupons.where((item) => item.state == tabBarTitles[2]).toList();

    List<Widget> tabBarViewWidgets = [
      _buildCouponListView(coupons, '쿠폰이 없습니다.'),
      _buildCouponListView(filteredCouponsA, '사용 가능한 쿠폰이 없습니다.'),
      _buildCouponListView(filteredCouponsNA, '사용 완료한 쿠폰이 없습니다.'),
    ];

    return Expanded(
      child: TabBarView(
        children: tabBarViewWidgets,
      ),
    );
  }

  Widget _buildCouponListView(List<Coupon> coupons, String emptyMessage) {
    return RefreshIndicator(
        onRefresh: _refresh,
        child: coupons.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 24.0.h),
                itemCount: coupons.length,
                itemBuilder: (BuildContext context, int index) {
                  return couponItem(coupons[index]);
                },
              )
            : ListView.builder(
                // shrinkWrap: true,
                padding: EdgeInsets.only(top: thisHeight / 3),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Center(child: Text(emptyMessage));
                },
              ));
  }

  TextStyle couponTitleSt =
      TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w600, height: 1.42);

  Widget couponItem(Coupon coupon) {
    String discountRateText = '${coupon.discountRate}% 할인';
    String discountPriceText =
        '${coupon.discountPrice?.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원 할인';
    return Padding(
      padding: EdgeInsets.fromLTRB(24.h, 0, 24.h, 24.h),
      child: Container(
        height: 166.w,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/coupon.png'),
                fit: BoxFit.fill)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    badge(coupon.state.toString()),
                    const Spacer(flex: 2),
                    Text(
                        coupon.discountRate != null
                            ? discountRateText
                            : discountPriceText,
                        style: couponTitleSt),
                    const Spacer(flex: 1),
                    Text('CUDI 카페', style: w500),
                    Text(
                      '사용기한: ${coupon.finishDate?.year}년 ${coupon.finishDate?.month}월 ${coupon.finishDate?.day}일까지',
                      style: s12.copyWith(color: gray79),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                snackBar(context, '쿠폰이 발급되었습니다.');
              },
              child: Padding(
                padding: EdgeInsets.only(right: 24.w, top: 8.h, bottom: 8.h),
                child: svgIcon('assets/images/img-cooking.svg'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget badge(String text) {
    return Container(
      width: 58.w,
      height: 20.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: text == "사용가능" ? const Color(0xff4AD097) : gray3D,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(text, style: s12w600),
    );
  }

  Widget bottoms() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(children: [
        notice(),
        whiteButton('쿠폰 모두 다운받기', null, () => couponDown()),
        sbh8,
        whiteButton('쿠폰 되돌리기', null, () => couponReset()),
      ]),
    );
  }

  void couponDown() {
    String userEmailId =
        Provider.of<UserProvider>(context, listen: false).userEmail;
    User currentUser =
        Provider.of<UserProvider>(context, listen: false).currentUser;
    List<String> userConditions = [];
    if (currentUser.pushNotificationConsent == true) {
      userConditions.add("푸시알림동의");
    }

    for (Coupon coupon in coupons) {
      // 쿠폰의 조건을 확인하고, 조건이 없거나 일치할 때만 다운로드
      if (coupon.conditions == null ||
          coupon.conditions!.contains(userConditions.first)) {
        // 다운로드 가능한 경우
        FirebaseFirestore.instance
            .collection("user")
            .doc(userEmailId)
            .collection("coupon")
            .doc(coupon.couponId)
            .set(coupon.toFirestore())
            .then((value) => debugPrint('Coupon added: success'))
            .catchError((error) => debugPrint('Error adding coupon: $error'));
      } else {
        // 조건이 일치하지 않아 다운로드 불가능한 경우
        debugPrint(
            'Coupon download conditions not met for coupon: ${coupon.couponId}');
      }
      _refresh();
    }
  }

  Future<void> couponReset() async {
    try {
      String userEmail =
          Provider.of<UserProvider>(context, listen: false).userEmail;

      // Firestore 참조를 얻습니다.
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // 사용자의 "coupon" 컬렉션 참조를 가져옵니다.
      CollectionReference userCouponCollection =
      firestore.collection("user").doc(userEmail).collection("coupon");

      // 현재 컬렉션에 있는 모든 문서를 가져옵니다.
      QuerySnapshot querySnapshot = await userCouponCollection.get();

      // 각 문서를 삭제합니다.
      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        await document.reference.delete();
      }
      _refresh();

      print("모든 쿠폰이 삭제되었습니다.");
    } catch (e) {
      print("쿠폰 삭제 중 오류 발생: $e");
    }
  }

  Widget notice() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Container(
        width: double.infinity, // 가로로 확장되도록 추가
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: gray1C,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: bulletText(text: '지급된 쿠폰은 앱에서만 사용이 가능합니다.'),
      ),
    );
  }
}
