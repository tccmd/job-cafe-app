import 'package:jobCafeApp/screens/components/closed_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/enum.dart';
import '../../utils/provider.dart';
import '../home/components/main_stores.dart';
import 'components/threed_tag_sheet.dart';
import 'components/threed_local_sheet.dart';
import '../components/app_bar.dart';
import '../../constants.dart';

class ThreeDScreen extends StatefulWidget {

  const ThreeDScreen({super.key});

  @override
  State<ThreeDScreen> createState() => _ThreeDScreenState();
}

class _ThreeDScreenState extends State<ThreeDScreen> {
  Set<Enum> filters = {}; // TagFilter를 가진 세트 변수
  Set<String> koreanLabels = {}; // 한글라벨을 가진 세트 변수
  String selectedTagLabel = '상세정보';
  String selectedLocationLabel = '지역';
  List<String> threeDHorizonListItem = [];
  List<Widget> threeDHorizonListItem2 = [
    const ThreedLocalSheet(),
    const ThreedTagSheet()
  ];
  List<Color> threeDHorizonListItem3 = [];
  List<Color> threeDHorizonListItem4 = [];
  @override
  Widget build(BuildContext context) {
    filters = Provider.of<SelectedTagProvider>(context)
        .filters; // 셋타입의 변수(괄호는 {}이나, 리스트 형식 (중복을 허용하지 않는 고유값이 필요할 때 쓴다))
    koreanLabels = Provider.of<SelectedTagProvider>(context).koreanLabels;
    if (filters.whereType<TagFilter>().length > 1) {
      selectedTagLabel = '${filters.whereType<TagFilter>().map((e) => koreanLabels.elementAt(filters.toList().indexOf(e))).toList().first} 외 ${filters.whereType<TagFilter>().length-1}개';
    } else if (filters.whereType<TagFilter>().length == 1) {
      selectedTagLabel = filters.whereType<TagFilter>().map((e) => koreanLabels.elementAt(filters.toList().indexOf(e))).toList().first;
    } else {
      selectedTagLabel = '상세정보';
    }
    if (filters.whereType<TagFilterLocalLocations>().isNotEmpty){
      selectedLocationLabel = filters.whereType<TagFilterLocalLocations>().map((e) => koreanLabels.elementAt(filters.toList().indexOf(e))).toList().first;
    } else {
      selectedLocationLabel = '지역';
    }
    threeDHorizonListItem = [selectedLocationLabel, selectedTagLabel];
    threeDHorizonListItem3 = [
      filters.whereType<TagFilterLocalLocations>().isNotEmpty ? primary : black,
      filters.whereType<TagFilter>().isNotEmpty ? primary : black,
    ];
    threeDHorizonListItem4 = [
      filters.whereType<TagFilterLocalLocations>().isNotEmpty ? Colors.transparent : gray80,
      filters.whereType<TagFilter>().isNotEmpty ? Colors.transparent : gray80,
    ];
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: <Widget>[
            sliverAppBar(context, title: '3D 카페 투어', isGoHome: true),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      threeDHorizonList(),
                      sbh24,
                      MainStores(
                          whatScreen: "three_d"),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget threeDHorizonList() {
    return SizedBox(
      height: 40.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: threeDHorizonListItem.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ElevatedButton(
                  onPressed: () {
                    showSheet(context, threeDHorizonListItem2[index]);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: threeDHorizonListItem3[index],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 12.0),
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: threeDHorizonListItem4[index], width: 1.0)),
                  ),
                  child: Text(
                    threeDHorizonListItem[index],
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: white,
                        height: 1.0),
                  )),
            );
          }),
    );
  }

@override
  void dispose() {
    super.dispose();
    filters.clear();
  }
}
