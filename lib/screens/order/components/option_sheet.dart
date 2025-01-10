import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/cart.dart';
import '../../../models/menu.dart';
import '../../../routes.dart';
import '../../components/bottom_sheet.dart';
import '../../components/closed_sheet.dart';
import '../../components/icons/svg_icon.dart';
import '../../../theme.dart';
import '../../../utils/db/firebase_firestore.dart';
import '../../../utils/provider.dart';
import '../../../widgets/cudi_buttons.dart';
import '../../../widgets/cudi_checkboxes.dart';
import '../../../widgets/cudi_widgets.dart';
import '../../../constants.dart';

class OptionSheet extends StatefulWidget {
  const OptionSheet({super.key});

  @override
  State<OptionSheet> createState() => _OptionSheetState();
}

class _OptionSheetState extends State<OptionSheet> {
  late Menu menu;
  late Cart cart;

  List<String> cup = ['매장컵', '일회용컵'];
  List<bool> isSelected = [true, false];
  int shotCount = 0;
  int syrupCount = 0;

  @override
  void initState() {
    super.initState();
    menu = UserProvider.of(context).currentMenu;
    cart = Cart(
      uid: UserProvider.of(context).uid,
      storeId: menu.storeId,
      menuId: menu.menuId,
      menuName: menu.menuName,
      menuImgUrl: menu.menuImgList?[0],
      menuSumPrice: menu.menuPrice,
      quantity: 1,
      cup: "매장컵",
      selectedValue: "HOT"
    );
  }

  @override
  Widget build(BuildContext context) {
    List<BottomSheetItem> bottomSheetItems = [
      BottomSheetItem(
        buttonName: "메뉴담기",
        onClick: () async {
          await FireStore.addCart(context, cart).then((value) {
            Navigator.pop(context);
          });
        },
        assetPath: "assets/icon/ico-line-cart.png",
      ),
      BottomSheetItem(
        buttonName: "바로결제",
        onClick: () async {
          await FireStore.addCart(context, cart).then((value) {
            Navigator.pushNamed(context, RouteName.order);
            UserProvider.of(context).setIsCartAdded(false);
          });
        },
        assetPath: "assets/icon/ico-line-pay.png",
      ),
    ];
    return BottomSheetOpened(body: body(), bottomSheetItems: bottomSheetItems);
  }

  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: Column(
              children: [
                MenuInfo(isOpenSheet: true), // 메뉴 인포
                cups(), // 핫 아이스 선택
                sbh24,
                divider, // 디바이더
                options(), // 옵션들
              ],
            ),
          ),
        ),
        Wrap(
          children: [
            divider, // 디바이더
            sumPriceText(price: cart.menuSumPrice ?? 0),
          ],
        ), // 옵션 합계 금액
      ],
    );
  }

  Widget cups() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: cupButton(cup[0], () {
            setState(() {
              for (int i = 0; i < isSelected.length; i++) {
                isSelected[i] = (i == 0);
                cart.cup = cup[0];
              }
            });
          }, isSelected[0]),
        ),
        sbw20,
        Expanded(
          child: cupButton(cup[1], () {
            // 버튼을 클릭하면 isSelected 값을 변경합니다.
            setState(() {
              for (int i = 0; i < isSelected.length; i++) {
                isSelected[i] = (i == 1);
                cart.cup = cup[1];
              }
            });
          }, isSelected[1]),
        ),
      ],
    );
  }

  Widget orderSelectAdd(
      {required String what,
      required int addPrice,
      required VoidCallback plus,
      required VoidCallback minus,
      required int count}) {
    return Container(
      padding: pd24T,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(what,
                  style: w500.copyWith(color: black)),
              priceText(
                  price: addPrice,
                  style: h17.copyWith(fontSize: 12.sp, color: black)),
            ],
          ),
          Container(
            padding: pd12h8v,
            width: 120.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: grayEA)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: ElevatedButton(
                      onPressed: minus,
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                      ),
                      child: svgIcon(
                          'assets/icon/ico-line-count-down.svg')),
                ),
                SizedBox(
                  width: 20.w,
                  child: Text(
                    count.toString(),
                    style: s14.copyWith(color: gray58),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: ElevatedButton(
                      onPressed: plus,
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                      ),
                      child: svgIcon(
                          'assets/icon/ico-line-count-plus.svg')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  // 다중 선택 (체크 박스)
  Widget orderSelectCheck() {
    return Container(
      // height: 65.h,
      padding: pd24T,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('옵션 유형2(다중선택)',
                  style: w500.copyWith(color: black)),
              Text('600원',
                  style: h17.copyWith(fontSize: 12.sp, color: gray58)),
            ],
          ),
          cudiWhiteFillCheckBox(
              cart.isChecked ?? false,
              (bool? value) => setState(() {
                    cart.isChecked = value ?? false;
                    if (value!) {
                      cart.menuSumPrice = (cart.menuSumPrice ?? 0) + 600;
                    } else {
                      cart.menuSumPrice = (cart.menuSumPrice ?? 0) - 600;
                    }
                  })),
        ],
      ),
    );
  }

  // 단일 선택 (라디오 버튼)
  Widget orderSelectRadio(String? value, int price, int groupValueNumber) {
    return Container(
      padding: pd24T,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value!,
                  style: w500.copyWith(color: black)),
              Text('$price원',
                style: h17.copyWith(fontSize: 12.sp, color: gray58)),
            ],
          ),
          Radio(
            value: value,
            toggleable: groupValueNumber == 1 ? false : true,
            groupValue: groupValueNumber == 1
                ? cart.selectedValue
                : cart.selectedValue2,
            onChanged: (value) {
              setState(() {
                if (groupValueNumber == 1) {
                  cart.selectedValue = value;
                } else if (groupValueNumber == 2) {
                  cart.selectedValue2 = value;
                  if (value == null) {
                    cart.menuSumPrice = (cart.menuSumPrice ?? 0) + 600;
                  } else {
                    cart.menuSumPrice = (cart.menuSumPrice ?? 0) - 600;
                  }
                }
              });
              print(cart.selectedValue);
              print(cart.selectedValue2);
            },
            fillColor:
                MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return primary.withOpacity(0.82); // Custom disabled color
              }
              return grayEA; // Custom enabled color
            }),
          ),
        ],
      ),
    );
  }


  Widget options() {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                optionNotice1(), // 안내 컨테이너
                orderSelectRadio('HOT', 0, 1),
                orderSelectRadio('ICED', 0, 1),
                orderSelectRadio('ICED ONLY', 0, 1),
                orderSelectAdd(
                  what: '샷추가',
                  addPrice: 600,
                  plus: () {
                    setState(() {
                      if (shotCount < 10) {
                        shotCount++;
                        cart.menuSumPrice = (cart.menuSumPrice ?? 0) + 600;
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Text(
                          '한 메뉴에 10개 이상을 선택할 수 없습니다.',
                          style: TextStyle(color: Colors.grey),
                        )));
                      }
                    });
                  },
                  minus: () {
                    setState(() {
                      if (shotCount > 0) {
                        shotCount--;
                        cart.menuSumPrice = (cart.menuSumPrice ?? 0) - 600;
                      }
                    });
                  },
                  count: shotCount,
                ),
                orderSelectAdd(
                  // storeMenuOne: storeMenuOne,
                  what: '시럽추가',
                  addPrice: 600,
                  plus: () {
                    setState(() {
                      if (syrupCount < 10) {
                        syrupCount++;
                        cart.menuSumPrice = (cart.menuSumPrice ?? 0) + 600;
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Text(
                          '한 메뉴에 10개 이상을 선택할 수 없습니다.',
                          style: TextStyle(color: Colors.grey),
                        )));
                      }
                    });
                  },
                  minus: () {
                    setState(() {
                      if (syrupCount > 0) {
                        syrupCount--;
                        cart.menuSumPrice = (cart.menuSumPrice ?? 0) - 600;
                      }
                    });
                  },
                  count: syrupCount,
                ),
                orderSelectCheck(),
                orderSelectRadio('옵션 유형2(단일선택)', 600, 2),
                optionNotice2(), // 안내 컨테이너
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget optionNotice1() {
    return Padding(
      padding: pd24v,
      child: Container(
        padding: pd16h12v,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: grayF6,
            borderRadius: BorderRadius.circular(8.w)),
        child: Text(
            '・ 좌석이 없을시 일회용컵으로 대체 가능합니다. \n・ 개인컵 사용시 직원에게 전달해 주세요. \n・ 매장마다 운영 상황이 다를 수 있습니다. \n・ 여기 문구는 관리자에서 입력이 가능합니다.',
            style: h17.copyWith(fontSize: 12.sp, color: gray80)),
      ),
    );
  }

  Widget optionNotice2() {
    return Padding(
      padding: pd24v,
      child: Container(
        alignment: Alignment.center,
        height: 36.h,
        decoration: BoxDecoration(
            color:grayF6,
            borderRadius: BorderRadius.circular(8.w)),
        child: Text('! 메뉴 사진은 연출된 이미지로 실제와 다를 수 있습니다.',
            style: s12.copyWith(color: grayC1)),
      ),
    );
  }
}
