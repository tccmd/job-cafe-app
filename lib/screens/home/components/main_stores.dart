import 'package:jobCafeApp/widgets/cudi_widgets.dart';
import 'package:jobCafeApp/screens/components/icons/haert_icon.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../models/store.dart';
import '../../../utils/db/firebase_firestore.dart';
import '../../../utils/provider.dart';
import '../../components/icons/threed_icon.dart';

class MainStores extends StatefulWidget {
  final String whatScreen;

  const MainStores({super.key, required this.whatScreen});

  @override
  State<MainStores> createState() => _MainStoresState();
}

class _MainStoresState extends State<MainStores> {
  // 파이어베이스 데이터
  late List<Store> stores = [];
  Set<String> koreanLabels = {};
  String dataCompleteMessage = '';

  // 파이어베이스 데이터
  void _initializeData() async {
    late List<Store> data;
    if (mounted) {
      if (widget.whatScreen == 'three_d') {
        data = await FireStore.getTagStore(koreanLabels);
        setState(() {
          stores = data;
          dataCompleteMessage = '! 정보를 포함한 카페가 없습니다.';
        });
      } else if (widget.whatScreen == 'home_horizon') {
        await UtilProvider.getAndSetStores(context, index: 0);
        // CudiProvider().set
        setState(() {
          stores = UtilProvider.of(context).storeList;
          dataCompleteMessage = '데이터 준비중';
        });
      }
    }
  }

  Future<void> _refresh() async {
    _initializeData();
  }

  @override
  void initState() {
    _initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    koreanLabels = Provider.of<SelectedTagProvider>(context).koreanLabels;
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return SizedBox(
      height: widget.whatScreen == "three_d" ? userProvider.bodyHeight : 357.h,
      // 리스트뷰의 무한대 에러 방지를 위함
      child: Consumer<SelectedTagProvider>(
        // 필터값이 변경되면 다시 로드하기 위함
        builder: (context, selectedTagProvider, child) {
          if (!setEquals(selectedTagProvider.previousFilters,
              selectedTagProvider.filters)) {
            selectedTagProvider.previousFilters =
                selectedTagProvider.filters.toSet();
            _initializeData();
          } // 필터 프로바이더의 필터값이 변경되면 데이터를 다시 로드
          return stores.isNotEmpty
              ? RefreshIndicator(
                  onRefresh: _refresh,
                  child: widget.whatScreen == "home_vertical" ||
                          widget.whatScreen == "three_d"
                      ? listView(userProvider)
                      : carouselSlider(userProvider),
                )
              : empty();
        },
      ),
    );
  }

  Widget empty() {
    return Align(
        alignment: const Alignment(0, -0.2), child: Text(dataCompleteMessage));
  }

  // 세로 리스트
  Widget listView(userProvider) {
    return ListView.builder(
      // physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(bottom: 130.0.h),
        itemCount: stores.length,
        itemBuilder: (context, index) {
          var store = stores[index];
          return card(store, userProvider);
        });
  }

  Widget card(store, userProvider) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          0, 0, widget.whatScreen == "home_vertical" ? 24.h : 0, 24.0.h),
      child: Container(
        width: 342.0.w,
        height: 456.0.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          image: DecorationImage(
              image: AssetImage('assets/images/matterport_model.png'),// NetworkImage(store.storeImageUrl.toString()),
              fit: BoxFit.cover),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(24.0),
          onTap: () => userProvider.goStoreScreen(context, store),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0.h),
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                        -0.15,
                        0.6,
                        1.15
                      ],
                      colors: [
                        Color.fromARGB(180, 0, 0, 0),
                        Color.fromARGB(0, 255, 255, 255),
                        Color.fromARGB(180, 0, 0, 0)
                      ]),
                ),
              ), //그라데이션
              Positioned(
                top: 24,
                left: 24,
                child: Text(
                  '${store.storeName}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    height: 1.0,
                  ),
                ),
              ),
              Positioned(
                  top: 44,
                  left: 24,
                  child: customStoreAddress(store.storeAddress)),
              widget.whatScreen == 'three_d'
                  ? const SizedBox()
                  : Positioned(
                      left: 24.0,
                      bottom: 24.0,
                      child: HeartIcon(storeId: store.storeId),
                    ),
              widget.whatScreen == 'three_d'
                  ? const SizedBox()
                  : ThreeDIcon(storeThreeDUrl: store.storeThreeDUrl),
              widget.whatScreen == 'three_d'
                  ? Align(
                      alignment: Alignment(0, 0),
                      child: Image.asset('assets/icon/view_3d.png'),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  // 가로 리스트
  Widget carouselSlider(userProvider) {
    return Consumer<UtilProvider>(
        builder: (context, cudiProvider, child) {
          stores = UtilProvider.of(context).storeList;
          if (stores.isEmpty) _initializeData();
          return CarouselSlider(
            options: CarouselOptions(
              height: 357.0,
              viewportFraction: 0.938,
              // 현재 페이지 보기에서 차지합니다.
              enableInfiniteScroll: false,
              reverse: true,
              initialPage: stores.length,
              // scrollDirection: Axis.vertical,
            ),
            items: carouselItem(userProvider),
          );
        });
  }

  List<Builder> carouselItem(UserProvider userProvider) {
    return stores.asMap().entries.map((store) {
      return Builder(
        builder: (BuildContext context) {
          return Transform.translate(
            offset: Offset(-12.0.w, 0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                margin: EdgeInsets.only(right: 24.0.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  image: DecorationImage(
                    image: AssetImage('assets/images/matterport_model.png'),// NetworkImage(store.value.storeImageUrl.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(24.0),
                  onTap: () =>
                      userProvider.goStoreScreen(context, store.value),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0.h),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [-0.15, 0.6, 1.15],
                            colors: [
                              Color.fromARGB(180, 0, 0, 0),
                              Color.fromARGB(0, 255, 255, 255),
                              Color.fromARGB(180, 0, 0, 0),
                            ],
                          ),
                        ),
                      ), //그라데이션
                      Positioned(
                        top: 24,
                        left: 24,
                        child: Text(
                          '${store.value.storeName}',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            height: 1.0,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(1.0, 1.0),
                                blurRadius: 3.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          top: 44,
                          left: 24,
                          child: customStoreAddress(
                              '${store.value.storeAddress}')),
                      Positioned(
                        left: 24.0,
                        bottom: 24.0,
                        child: HeartIcon(
                            storeId: store.value.storeId, isPlain: false),
                      ),
                      Positioned(
                        bottom: 24.0,
                        right: 24.0,
                        child: ThreeDIcon(
                            storeThreeDUrl: store.value.storeThreeDUrl),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }).toList();
  }
}
