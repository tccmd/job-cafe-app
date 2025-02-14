import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/cudi_widgets.dart';
import '../components/app_bar.dart';
import '../../constants.dart';

class ReservesScreen extends StatefulWidget {
  const ReservesScreen({Key? key}) : super(key: key);

  @override
  State<ReservesScreen> createState() => _ReservesScreenState();
}

class _ReservesScreenState extends State<ReservesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: <Widget>[
            sliverAppBar(context, title: '민트페이 적립금'),
            SliverList(
              delegate: SliverChildListDelegate([
                DefaultTabController(
                  length: 3,
                  child: SizedBox(
                    height: 700.h,
                    child: Column(
                      children: [
                        cupayReserves(padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.h)),
                        tabBar(),
                        tabBarView(),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabBar() {
    return TabBar(
        labelStyle: s16w500,
        unselectedLabelColor: white,
        dividerColor: gray80,
        labelPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.h),
        indicatorWeight: 1.0,
        indicatorSize: TabBarIndicatorSize.tab,
        overlayColor: MaterialStatePropertyAll(Colors.transparent),
        tabs: [
          Text('전체'),
          Text('적립'),
          Text('사용'),
        ]);
  }

  Widget tabBarView() {
    return SizedBox(
      height: 466.h,
      child: TabBarView(children: [
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: reserves.length,
          itemBuilder: (BuildContext context, int index) {
            return reserveTile(reserves[index]);
          },
        ),
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: reserves.where((item) => item["condition"] == "지급").length,
          itemBuilder: (BuildContext context, int index) {
            final filteredReserves = reserves.where((item) => item["condition"] == "지급").toList();
            return reserveTile(filteredReserves[index]);
          },
        ),
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: reserves.where((item) => item["condition"] == "사용").length,
          itemBuilder: (BuildContext context, int index) {
            final filteredReserves = reserves.where((item) => item["condition"] == "사용").toList();
            return reserveTile(filteredReserves[index]);
          },
        ),
      ]),
    );
  }

  List<Map<String, dynamic>> reserves = [
    {
      "title": "민트페이 적립",
      "subtitle": "MINT 카페 주문",
      "three_line": "2023년 11월 12일",
      "condition": "지급",
    },
    {
      "title": "적립금 사용",
      "subtitle": "MINT 카페 주문",
      "three_line": "2023년 11월 12일",
      "condition": "사용",
    },
    {
      "title": "적립금 사용",
      "subtitle": "MINT 카페 주문",
      "three_line": "2023년 11월 12일",
      "condition": "사용",
    },
    {
      "title": "민트페이 적립",
      "subtitle": "MINT 카페 주문",
      "three_line": "2023년 11월 12일",
      "condition": "지급",
    },
    {
      "title": "민트페이 적립",
      "subtitle": "MINT 카페 주문",
      "three_line": "2023년 11월 12일",
      "condition": "지급",
    },
    {
      "title": "적립금 사용",
      "subtitle": "MINT 카페 주문",
      "three_line": "2023년 11월 12일",
      "condition": "사용",
    },
  ];

  ListTile reserveTile(reserve) {
    return ListTile(
      contentPadding: const EdgeInsets.only(top: 16, left: 24.0, right: 24.0),
      title: Text('${reserve["title"]}', style: w500.copyWith(fontSize: 14)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          Text('${reserve["subtitle"]}', style: c85s12h16),
          Text('${reserve["three_line"]} ${reserve["condition"]} 완료', style: c79s12),
        ],
      ),
      trailing:  operatorPriceText(condition: reserve["condition"] == "지급", price: 250),
    );
  }

  Widget operatorPriceText({required dynamic condition, required int price}) {
    return Text(
      '${condition ? "+" : "-"}${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
      style: w500.copyWith(color: condition ? white : gray79, fontSize: 14),
    );
  }
}
