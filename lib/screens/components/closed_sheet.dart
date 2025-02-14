import 'package:jobCafeApp/screens/components/icons/svg_icon.dart';
import 'package:jobCafeApp/theme.dart';
import 'package:jobCafeApp/utils/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../routes.dart';
import '../../widgets/cudi_buttons.dart';
import '../../../constants.dart';
import '../../widgets/cudi_util_widgets.dart';

class ClosedSheet extends StatelessWidget {
  final Widget body;
  final Widget sheet;

  const ClosedSheet({super.key, required this.body, required this.sheet});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showSheet(context, sheet);
        },
        onVerticalDragUpdate: (details) {
          if (details.delta.dy < -20.0) {
            showSheet(context, sheet);
          }
        },
        child: Container(
          decoration: sheetShape,
          child: Column(
            children: [
              sheetDivider(),
              Container(
                padding: pd24h,
                child: body,
              ),
              sbh12,
            ],
          ),
        ));
  }
}
Widget sheetDivider() {
  return Padding(
    padding: pd16v,
    child: Container(
      width: 32.w,
      height: 4.h,
      decoration: BoxDecoration(
        color: const Color(0xffA8A8A8),
        borderRadius: BorderRadius.circular(10.w),
      ),
    ),
  );
}

class SheetButton extends StatelessWidget {
  final List<BottomSheetItem> bottomSheetItems;

  const SheetButton(
      {super.key,
        required this.bottomSheetItems,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: buttonWidgetSize + homeIndicator,
      child: Padding(
        padding: pd24202407,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            (bottomSheetItems[0].buttonName) != "" ? Flexible(
            flex: 1,
            child: button3(bottomSheetItems[0].buttonName, bottomSheetItems[0].onClick, bottomSheetItems[0].assetPath)) 
                : svgIcon("assets/icon/ico-line-3d-default-light-20px.svg", function: bottomSheetItems[0].onClick),// IconButton(onPressed: (){}, icon: Image.asset(bottomSheetItems[0].assetPath ?? "")),
            sbw20,
            Flexible(
              flex: 1,
              child: button3(bottomSheetItems[1].buttonName, bottomSheetItems[1].onClick, bottomSheetItems[1].assetPath)),
          ],
        ),
      ),
    );
  }
}

void showSheet(BuildContext context, Widget sheet) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.transparent,
    elevation: 0,
    // 틴티드 됨
    // constraints: const BoxConstraints.expand(),
    isDismissible: false,
    builder: (BuildContext context) {
      return sheet;
    },
  ).then((value) {
    var u = UserProvider.of(context);
    if (u.isCartAdded) {
      snackBar(context, '장바구니에 상품을 담았습니다.',
          label: '보러가기',
          onClick: () => Navigator.pushNamed(context, RouteName.cart));
    }
    u.setIsCartAdded(false);
  });
}

class BottomSheetItem {
  final String buttonName;
  final void Function() onClick;
  final String? assetPath;

  BottomSheetItem({
    required this.buttonName,
    required this.onClick,
    required this.assetPath,
  });
}