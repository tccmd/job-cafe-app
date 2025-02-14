import 'package:jobCafeApp/screens/components/no_content.dart';
import 'package:jobCafeApp/utils/db/firebase_firestore.dart';
import 'package:jobCafeApp/widgets/cudi_util_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../routes.dart';
import '../../models/favorite.dart';
import '../../models/store.dart';
import '../../utils/provider.dart';
import '../../widgets/cudi_widgets.dart';
import '../components/icons/haert_icon.dart';
import '../components/app_bar.dart';
import '../../constants.dart';
import '../components/icons/svg_icon.dart';
import '../components/icons/threed_icon.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _fetchData,
          child: FutureBuilder(
            future: _fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                textFavoriteDescControllers = List.generate(
                    favoriteStores.length, (index) => TextEditingController());
                focusNodes = List.generate(
                    favoriteStores.length, (index) => FocusNode());
                return CustomScrollView(
                  slivers: <Widget>[
                    _buildSliverAppBar(context),
                    _buildSliverList(),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return sliverAppBar(context, title: '찜한 카페', isGoHome: true);
  }

  Widget _buildSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
            padding: pd24all,
            child: (favoriteStores.isEmpty) ? _noContent() : listViewWidget(),
          );
        },
        childCount: 1,
      ),
    );
  }

  Future<void> _fetchData() async {
    var u = UserProvider.of(context);
    favorites = await FireStore.getUserFavoriteDesc(u.uid);
    favoriteStores = await FireStore.getUserFavoriteStores(u.uid);
  }

  Widget _noContent() {
    return NoContent(
        imgUrl: 'assets/logo/MintChoco.png',
        imgWidth: 131.w,
        imgHeight: 136.h,
        title: '아직 찜한 카페가 없어요!',
        subTitle: '자주 찾는 카페를 찜 해보세요',
        btnText: '카페 둘러보기',
        function: () => Navigator.pushNamed(context, RouteName.home));
  }

  Widget listViewWidget() {
    // 한 행에 두 개의 항목이 있는 세로 스크롤 리스트
    return SizedBox(
      height: 620.h,
      child: ListView.builder(
        itemCount: (favoriteStores.length / 2).ceil(), // 올림 처리
        itemBuilder: (context, rowIndex) {
          return Padding(
            padding: pd24B,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 항목 간 간격 조절
              children: List.generate(2, (index) {
                // 현재 행에서 두 개의 항목을 가져옴
                int itemIndex = rowIndex * 2 + index;
                if (itemIndex < favoriteStores.length) {
                  final store = favoriteStores[itemIndex];
                  textFavoriteDescActions = List.generate(
                      favoriteStores.length,
                      (index) => () {
                            FirebaseFirestore.instance
                                .collection('favorite')
                                .doc(favorites[index].favoriteId)
                                .update({
                              "favorite_desc":
                                  textFavoriteDescControllers[index].text
                            }).then(
                                    (value) => print(
                                        "DocumentSnapshot successfully updated!"),
                                    onError: (e) =>
                                        print("Error updating document $e"));
                            snackBar(context, '저장되었습니다', margin: 0);
                            focusNodes[index].unfocus();
                          });
                  return gridItem(store, itemIndex);
                } else {
                  // 리스트의 항목 수를 넘어가는 경우 처리
                  return Container(); // 빈 컨테이너를 추가하여 정렬 유지
                }
              }),
            ),
          );
        },
      ),
    );
  }

  Widget gridItem(Store store, int index) {
    return SizedBox(
      width: 161.w,
      height: 274.h + 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          stack(store),
          sbh16,
          favoriteStoreName(store),
          SizedBox(
            height: 24.h,
            child: Row(
              children: [
                textField(store, index),
                SizedBox(width: 4.w),
                submitButton(index),
                // Spacer()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget stack(Store store) {
    return InkWell(
      onTap: () => UserProvider.of(context).goStoreScreen(context, store),
      child: SizedBox(
        width: 161.w,
        height: 214.h,
        child: Stack(
          children: [
            // Image.network(store.storeImageUrl.toString(),
            Image.asset('assets/images/matterport_model.png',
                fit: BoxFit.cover, height: 214.h, width: 161.w),
            Positioned(
              right: 8.w,
              bottom: 48.h,
              child: HeartIcon(storeId: store.storeId, isColumn: true),
            ),
            Positioned(
                right: 8.w,
                bottom: 8.h,
                child: ThreeDIcon(storeThreeDUrl: store.storeThreeDUrl)),
          ],
        ),
      ),
    );
  }

  Widget favoriteStoreName(Store store) {
    return Text(store.storeName.toString(),
        style: s16w600.copyWith(overflow: TextOverflow.ellipsis));
  }

  Widget textField(Store store, int index) {
    return Flexible(
      child: TextFormField(
        controller: textFavoriteDescControllers[index],
        focusNode: focusNodes[index],
        style: TextStyle(color: grayB5, fontSize: 14.sp),
        cursorColor: grayB5,
        decoration: InputDecoration(
          isDense: true,
          hintText: (index >= 0 && index < favorites.length)
              ? favorites[index].favoriteDesc ?? '별명을 입력해주세요'
              : '별명을 입력해주세요',
          hintStyle: TextStyle(color: grayB5),
          contentPadding: EdgeInsets.zero,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide.none, // 밑줄 색상 설정
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: grayB5), // 밑줄 색상 설정
          ),
        ),
      ),
    );
  }

  Widget submitButton(int index) {
    return GestureDetector(
        onTap: textFavoriteDescActions[index],
        child: svgIcon('assets/icon/Icon-Line-45.svg'));
  }

  // 파이어베이스 데이터
  List<Favorite> favorites = [];
  List<Store> favoriteStores = [];

  // 인풋 컨트롤러들 생성
  List<TextEditingController> textFavoriteDescControllers = [];

  List<Function()> textFavoriteDescActions = [];

  // FocusNode 생성
  List<FocusNode> focusNodes = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in textFavoriteDescControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
