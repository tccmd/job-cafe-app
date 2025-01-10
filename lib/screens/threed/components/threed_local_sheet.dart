import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../components/app_bar.dart';
import '../../components/bottom_sheet.dart';
import '../../components/closed_sheet.dart';
import '../../../utils/enum.dart';
import '../../../utils/provider.dart';
import '../../../constants.dart';

class ThreedLocalSheet extends StatefulWidget {
  const ThreedLocalSheet({super.key});

  @override
  State<ThreedLocalSheet> createState() => _ThreedLocalSheetState();
}

class _ThreedLocalSheetState extends State<ThreedLocalSheet> {
  Set<Enum> filters = {};

  @override
  Widget build(BuildContext context) {
    filters = Provider.of<SelectedTagProvider>(context).filters;
    List<BottomSheetItem> bottomSheetItems = [
      BottomSheetItem(
        buttonName: "",
        onClick: () {
          var selectedTagProvider = Provider.of<SelectedTagProvider>(
              context,
              listen: false);
            selectedTagProvider.clearFilters();
        },
        assetPath: "assets/icon/ico-line-3d-default-light-20px.svg",
      ),
      BottomSheetItem(
        buttonName: "적용하기",
        onClick: () {
          Navigator.pop(context);
        },
        assetPath: null,
      ),
    ];
    return BottomSheetOpened(body: body(), bottomSheetItems: bottomSheetItems);
  }

  Widget body() {
    return DefaultTabController(
      length: enumMap.keys.length,
      child: Column(
        children: [
          CudiAppBar(title: "지역"),
          tabBar(), // 탭바
          tabBarView(), // 탭바뷰
        ],
      ),
    );
  }

  Widget tabBar() {
    return SizedBox(
      height: 50.0.h, // TabBar 높이 설정
      child: SingleChildScrollView(
        physics: const RangeMaintainingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: TabBar(
          physics: const RangeMaintainingScrollPhysics(),
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.tab,
          // TabBar를 스크롤 가능하도록 설정
          indicatorWeight: 1.0,
          labelColor: primary,
          unselectedLabelColor: gray80,
          tabs: enumMap.keys
              .map((tab) => Tab(
                    child: Text(
                      tagFilterLabels[tab] ?? '', // 해당하는 라벨 가져오기
                      style: s16w500,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget tabBarView() {
    return Expanded(
      child: TabBarView(
        physics: const RangeMaintainingScrollPhysics(),
        children: enumMap.values.map((tabList) {
          return SizedBox(
            height: 500,
            child: ListView(
              physics: const RangeMaintainingScrollPhysics(),
              children: tabList.map((tabs) {
                var tabStringList = [];
                for (var tab in tabs) {
                  tabStringList.add(tagFilterLabels[tab]);
                }
                return ListTile(
                  onTap: () {
                    var selectedTagProvider = Provider.of<SelectedTagProvider>(
                        context,
                        listen: false);
                    for (var tab in tabs) {
                      selectedTagProvider.toggleFilter(tab);
                    }
                  },
                  title: Text(tabStringList.join(' / '),
                      style: TextStyle(
                          color: filters.contains(tabs[0]) ? black : gray80,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0)),
                  trailing: Checkbox(
                    checkColor: primary,
                    fillColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors.transparent;
                      }
                    }),
                    side: const BorderSide(color: Colors.transparent),
                    value: filters.contains(tabs[0]),
                    onChanged: (bool? selected) {
                      var selectedTagProvider =
                          Provider.of<SelectedTagProvider>(context,
                              listen: false);
                      for (var tab in tabs) {
                        selectedTagProvider.toggleFilter(tab);
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }
}
