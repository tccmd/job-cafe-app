import 'package:jobCafeApp/screens/components/icons/haert_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/store.dart';
import '../../../utils/provider.dart';
import '../../models/menu.dart';
import '../../theme.dart';
import '../../utils/db/firebase_firestore.dart';
import '../components/closed_sheet.dart';
import '../menu/components/menu_sheet.dart';
import 'components/store_sheet.dart';
import '../../widgets/cudi_widgets.dart';
import '../../../constants.dart';
import '../components/app_bar.dart';
import '../components/video_player.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  int currentIndex = 0;
  bool isView = false;
  late UtilProvider provider;
  late Store store;
  late PageController _pageController;
  late List<BottomSheetItem> bottomSheetItems;

  @override
  Widget build(BuildContext context) {
    store = UserProvider.of(context).currentStore;
    provider = Provider.of<UtilProvider>(context);
    isView = provider.isView;
    bottomSheetItems = [
      BottomSheetItem(
        buttonName: "3D투어",
        onClick: () async {
          // Navigator.pushNamed(context, "/web_view", arguments: {
          //   "threeDUrl": store.storeThreeDUrl.toString()
          // });
          final uri = Uri.parse('https://my.matterport.com/show/?m=BxTC43Sjbhs&ss=149&sr=-3.14%2C-.64&tag=sSJmv6vb8dy&pin-pos=5.37%2C1.64%2C2.13');
          if (await canLaunchUrl(uri)) {
            // Launch the App
            await launchUrl(
              uri,
            );
          }
        },
        assetPath: "assets/icon/ico-line-3d-black.png",
      ),
      BottomSheetItem(
        buttonName: "메뉴보기",
        onClick: () {
          showSheet(context, const MenuSheet());
        },
        assetPath: "assets/icon/ico-line-menu.png",
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          storeMedia(),
          if (!isView) gradient(),
          if (!isView) blackCover(),
          if (!isView)
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                tops(),
                bottoms(),
              ],
            ),
        ],
      ),
    );
  }

  Widget storeMedia() {
    return InkWell(
      onTap: () => provider.setView(),
      child: ClipRRect(
        // 배경 슬라이드
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        ),
        child: SizedBox(
          child: PageView.builder(
            controller: _pageController,
            itemCount: 7, // store.storeImgList?.length ?? 0,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              if (index == 0) {
                // 첫 번째 페이지에 비디오 플레이어를 표시
                return VideoApp(
                    videoUrl: store.storeVideoUrl.toString(),
                    thumbnailUrl: store.storeThumbnail.toString());
              } else {
                // 나머지 페이지에 Container를 표시
                // int adjustedIndex = index - 1; // 첫 번째 페이지를 뺀 나머지 페이지의 인덱스
                return store.storeImgList?[index] != ''
                    ? Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/matterport_model.png'),
                                // image: NetworkImage(
                                //     store.storeImgList?[index] ?? ''),
                                fit: BoxFit.cover)))
                    : sb;
              }
            },
          ),
        ),
      ),
    );
  }

  Widget gradient() {
    return IgnorePointer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(0, 0, 0, 0.28), // 연하게
              Colors.transparent,
            ],
            stops: [0.0, 0.25], // 11/20 수정됨 // 짧게
          ),
        ),
      ),
    );
  }

  Widget blackCover() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(height: 150.h, color: black));
  }

  Widget tops() {
    return Column(
      children: [
        CudiAppBar(isWhite: true, isPadding: true, isHeightPadding: true),
      ],
    );
  }

  Widget bottoms() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // TextButton(onPressed: () {
        //   FireStore.updateStoreData(store.storeId!, 37.5063677, 130.8571536);
        // }, child: const Text('함수 실행')),

        // TextButton(onPressed: (){
        //
        //   Menu one = Menu(
        //     storeId: store.storeId,
        //     menuName: '아메리카노',
        //     menuPrice: 3200,
        //     menuDesc: '깔끔하고 부드러운 맛을 자랑하는 아메리카노입니다. 깊고 진한 커피 향이 입안을 가득 채우며, 산뜻한 피니시로 부담 없이 즐길 수 있는 클래식한 음료입니다. 커피 본연의 맛을 즐기고 싶다면 이 아메리카노가 제격입니다.',
        //     menuImgList: [
        //       '.'
        //     ],
        //     menuAllergy: '카페인, 크로스 컨태미네이션, 첨가물',
        //     menuCategory: '시그니처',
        //   );
        //
        //   Menu two = Menu(
        //     storeId: store.storeId,
        //     menuName: '카페라떼',
        //     menuPrice: 5000,
        //     menuDesc: '부드러운 우유와 진한 에스프레소가 조화롭게 어우러진 라떼입니다. 따뜻한 우유 거품 위로 펼쳐진 섬세한 라떼 아트가 시각적 즐거움까지 선사하며, 한 모금 마실 때마다 고소하고 부드러운 맛이 입안을 감쌉니다. 편안한 휴식을 원할 때 최적의 선택입니다.',
        //     menuImgList: [
        //       '.',
        //       '.'
        //     ],
        //     menuAllergy: '우유',
        //     menuCategory: '커피',
        //   );
        //
        //   Menu three = Menu(
        //     storeId: store.storeId,
        //     menuName: '주스',
        //     menuPrice: 3000,
        //     menuDesc: '상큼하고 달콤한 과일 향이 가득한 음료입니다. 톡 쏘는 탄산과 신선한 과일의 조화가 어우러져 입안을 상쾌하게 만들어줍니다. 더운 여름날, 또는 기분 전환이 필요할 때 언제든지 즐기기 좋은 음료입니다.',
        //     menuImgList: [
        //       '.'
        //     ],
        //     menuAllergy: '밀, 계란, 우유, 대두',
        //     menuCategory: '디저트',
        //   );
        //
        //   List<Menu> etcMenuListFinalPart = [
        //     one,
        //     two,
        //     three
        //   ];
        //
        //   for (Menu eachMenu in etcMenuListFinalPart) {
        //     FireStore.addMenu(eachMenu, store.storeId);
        //   }
        // }, child: const Text('이 스토어의 메뉴 추가')),
        menuPagenation(store),
        manuBottomSheetClosed(store),
        sheetButtonsWidget(),
      ],
    );
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  Widget menuPagenation(Store store) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx > 0) {
          // 오른쪽으로 스와이프
          if (currentIndex < (store.storeImgList?.length ?? 0)) {
            setState(() {
              currentIndex++;
            });
            _pageController.jumpToPage(currentIndex);
          }
        } else if (details.velocity.pixelsPerSecond.dx < 0) {
          // 왼쪽으로 스와이프
          if (currentIndex > 0) {
            setState(() {
              currentIndex--;
            });
            _pageController.jumpToPage(currentIndex);
          }
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Container(
          width: ((store.storeImgList?.length ?? 0) - 1) * 16.0 + 20.0 + 16.0,
          // 불릿(8), 가로 패딩(8) + 양쪽 여백 (20) + 비디오 페이지 포함 (16.0)
          height: 24.0,
          decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 8.0, 4.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                store.storeImgList?.length ?? 0,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                      });
                      _pageController.jumpToPage(currentIndex);
                    },
                    child: Container(
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                            color:
                                index == currentIndex ? white : Colors.white24,
                            borderRadius: BorderRadius.circular(20.0))),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget manuBottomSheetClosed(Store store) {
    return ClosedSheet(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${store.storeName}', style: s20w600.copyWith(color: black)),
          sbh8,
          Text('${store.storeAddress}',
              style: s14.copyWith(color: gray58),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          sbh16,
          SizedBox(
            height: 48.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HeartIcon(storeId: store.storeId, isPlain: true),
                shareIcon("cafe", store.storeId??""),
              ],
            ),
          ),
        ],
      ), sheet: StoreSheet(bottomSheetItems: bottomSheetItems),
    );
  }

  Widget sheetButtonsWidget() {
    return SheetButton(bottomSheetItems: bottomSheetItems);
  }
}
