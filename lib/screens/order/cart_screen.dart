import 'package:jobCafeApp/screens/components/closed_sheet.dart';
import 'package:jobCafeApp/screens/components/no_content.dart';
import 'package:jobCafeApp/screens/order/components/option_sheet.dart';
import 'package:jobCafeApp/screens/order/order_screen.dart';
import 'package:jobCafeApp/utils/provider.dart';
import 'package:jobCafeApp/widgets/cudi_buttons.dart';
import 'package:jobCafeApp/widgets/cudi_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../routes.dart';
import '../../constants.dart';
import '../../models/cart.dart';
import '../../models/store.dart';
import '../../theme.dart';
import '../../utils/db/firebase_firestore.dart';
import '../components/app_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static double bottomStackHeight = 72.h + 83.h;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late String uid;
  late String storeId;
  String storeName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                CudiAppBar(title: '장바구니', isWhite: true),
                cartList.isEmpty
                    ? noContent()
                    : Column(
                        children: [
                          cartOfOnlyOneStore(),
                          Divider(height: 1.h, color: gray3D),
                          orderListViewBuilder(),
                        ],
                      )
              ],
            ),
            cartList.isEmpty
                ? const SizedBox.shrink()
                : Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: bottomStack,
                      child: Wrap(
                        children: [
                          sumPriceText(price: cartSumPrice, text: '총'),
                          Padding(
                            padding: pd24202407,
                            child: whiteButton('주문하기', null, () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const OrderScreen()));
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget noContent() {
    return NoContent(
        imgUrl: 'assets/logo/MintChoco.png',
        imgWidth: 178.w,
        imgHeight: 136.h,
        title: '장바구니가 비어있어요!',
        subTitle: '좋아하는 카페 메뉴를 담아보세요',
        btnText: '카페 둘러보기',
        function: () => Navigator.pushNamed(context, RouteName.home));
  }

  TextStyle orderSmall =
      TextStyle(color: grayB5, fontSize: 12.sp, height: 1.6.h);
  late List<Cart> cartList = [];
  late Map store = {};
  int cartSumPrice = 0;
  int menuQuantity = 0;

  void _initializeData() async {
    uid = UserProvider.of(context).uid;
    cartSumPrice = 0;
    menuQuantity = 0;
    late List<Cart> data;
    late DocumentSnapshot<Map<String, dynamic>> data2;
    if (mounted) {
      data = await FireStore.getCart(uid);
    }
    setState(() {
      cartList = data;
      if (cartList.isNotEmpty) {
        storeId = cartList[0].storeId.toString();
      }
    });
    if (cartList.isNotEmpty) {
      data2 = await FireStore.db.collection('store').doc(storeId).get();
      setState(() {
        storeName = data2.data()?['store_name'];
      });
    }
    for (int i = 0; i < cartList.length; i++) {
      cartSumPrice += (cartList[i].menuSumPrice! * cartList[i].quantity!);
      menuQuantity += (cartList[i].quantity!);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeData();
  }

  Widget cartOfOnlyOneStore() {
    return Padding(
      padding: pd24all,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(storeName, style: s16w500),
          GestureDetector(
            onTap: () async {
              Store store;
              DocumentSnapshot<Map<String, dynamic>> snapshot =
                  await FirebaseFirestore.instance
                      .collection("store")
                      .doc(storeId)
                      .get();
              if (snapshot.exists) {
                store = Store.fromFirestore(snapshot, null);
                Provider.of<UserProvider>(context, listen: false)
                    .goStoreScreen(context, store);
              } else {}
            },
            child: SizedBox(
              height: 24.h,
              child: const Icon(Icons.chevron_right_rounded, color: white),
            ),
          ),
        ],
      ),
    );
  }

  Widget orderListViewBuilder() {
    return SizedBox(
      height: 580.h,
      child: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: CartScreen.bottomStackHeight),
          itemCount: cartList.length,
          itemBuilder: (context, index) {
            return orderContainerOfCart(index);
          },
        ),
      ),
    );
  }

  Widget orderContainerOfCart(int index) {

    String menuAsset;
    if (cartList[index].menuName == "아메리카노") {
      menuAsset = "assets/images/americano.jpg";
    } else if (cartList[index].menuName == "카페라떼") {
      menuAsset = "assets/images/latte.jpg";
    } else {
      menuAsset = "assets/images/juice.jpeg";
    }

    return Container(
      height: 249.h + 24.h,
      decoration: const BoxDecoration(
          // color: Colors.white10,
          border: Border(bottom: BorderSide())),
      child: Padding(
        padding: pd24all,
        child: Row(
          children: [
            SizedBox(
              width: 104.w,
              height: 195.8.h,
              child: Image.asset(
                menuAsset,
                // cartList[index].menuImgUrl.toString(),
                fit: BoxFit.cover, // 이미지가 세로로 꽉 차도록 설정
                height: double.infinity, // 이미지 위젯의 높이를 최대화
              ),
            ),
            SizedBox(width: 16.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (cartList[index].menuName != null)
                        Text(cartList[index].menuName.toString(),
                            style: s16w600),
                      SizedBox(
                        height: 24.h,
                        width: 24.w,
                        child: IconButton(
                          onPressed: () {
                            // print(CartList[index].orderId);
                            FireStore.deleteCartDoc(context,
                                cartList[index].cartId.toString(), uid);
                            _initializeData();
                          },
                          icon: Icon(Icons.close, size: 24.w),
                        ),
                      )
                    ],
                  ),
                  Flexible(flex: 50, child: orderOptions(cartList[index])),
                  if (cartList[index].menuSumPrice != null)
                    priceText(
                        price: cartList[index].menuSumPrice!,
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                  const Spacer(flex: 5),
                  if (cartList[index].quantity != null)
                    Text('수량 ${cartList[index].quantity}개', style: orderSmall),
                  const Spacer(flex: 3),
                  Row(
                    children: [
                      orderPlusMinusButton(cartList[index].cartId.toString()),
                      SizedBox(width: 8.w),
                      orderOptionEditButton(),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int addQuantity = 1;

  Widget orderPlusMinusButton(String orderId) {
    return Container(
      width: 96.w,
      height: 32.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: gray80)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: (96.w - 16.w) / 2,
            child: TextButton(
              onPressed: () {
                FireStore.updateOrderQuantity(orderId, uid, isPlus: false);
                _initializeData();
              },
              child: Text('-', style: s12.copyWith(color: grayEA)),
            ),
          ),
          SizedBox(
            child: Text(addQuantity.toString(),
                style: const TextStyle(color: grayEA, fontSize: 12.0)),
          ),
          SizedBox(
            width: (96.w - 16.w) / 2,
            child: TextButton(
              onPressed: () {
                FireStore.updateOrderQuantity(orderId, uid);
                _initializeData();
              },
              child: Text('+', style: s12.copyWith(color: grayEA)),
            ),
          ),
        ],
      ),
    );
  }

  Widget orderOptions(Cart Cart) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0.h),
      child: SizedBox(
        height: 95.0.h,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 컵
              Text(Cart.cup.toString(), style: orderSmall),
              // 핫 or 아이스
              if (Cart.selectedValue != null)
                Text(Cart.selectedValue.toString(), style: orderSmall),
              // 샷 추가
              if (Cart.addedShot != null)
                Text(
                    '샷추가(${(Cart.addedShot! * 600).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원)',
                    style: orderSmall),
              // 시럽 추가
              if (Cart.addedSyrup != null)
                Text(
                    '시럽추가(${(Cart.addedSyrup! * 600).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원)',
                    style: orderSmall),
              // 휘핑 추가 - 아직 없음
              if (Cart.addedWhipping != null)
                Text(
                    '휘핑추가(${(600).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원)',
                    style: orderSmall),
              // 다중 선택을 휘핑으로 뷰에서만
              if (Cart.selectedValue != null)
                Text(
                    '휘핑추가(${(600).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원)',
                    style: orderSmall),
              // 단일 선택
              if (Cart.selectedValue2 != null)
                Text(
                    '단일선택(${(600).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원)',
                    style: orderSmall),
            ],
          ),
        ),
      ),
    );
  }

  Widget orderOptionEditButton() {
    return InkWell(
      onTap: () => showSheet(context, const OptionSheet()),
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        width: 74.w,
        height: 32.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: gray80)),
        alignment: Alignment.center,
        child: Text('옵션수정', style: TextStyle(color: grayEA, fontSize: 12.0.sp)),
      ),
    );
  }

  Future<void> _refresh() async {
    _initializeData();
  }
}
