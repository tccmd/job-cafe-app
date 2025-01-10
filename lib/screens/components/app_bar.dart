import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../routes.dart';
import '../../constants.dart';
import 'icons/svg_icon.dart';

SliverAppBar sliverAppBar(BuildContext context,
    {String? title,
    Widget? iconButton,
    bool? isGoHome,
    bool? isNoLeading,
    void Function()? leadingFunction}) {
  return SliverAppBar(
    pinned: true,
    snap: true,
    floating: true,
    centerTitle: true,
    backgroundColor: black,
    surfaceTintColor: Colors.transparent,
    leadingWidth: 48.w,
    toolbarHeight: 88.h,
    leading: isNoLeading ?? false
        ? sb
        : GestureDetector(
            onTap: leadingFunction ??
                () {
                  isGoHome ?? false
                      ? Navigator.pushNamedAndRemoveUntil(
                          context, RouteName.home, (route) => false)
                      : Navigator.pop(context);
                },
            child: svgIcon('assets/icon/ico-line-arrow-back-white.svg')),
    title: Text(title ?? '', style: appBarStyle),
    actions: [iconButton ?? sb, SizedBox(width: 24.w)],
  );
}

class CudiAppBar extends StatelessWidget {
  String? title;
  Widget? iconButton;
  bool isGoToMain;
  bool isWhite;
  String? subTitle;
  bool isPadding;
  bool isHeightPadding;

  CudiAppBar({super.key, this.title = '', this.isGoToMain = false, this.isWhite = false, this.subTitle, this.isPadding = false, this.isHeightPadding = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isPadding ? pd24h : pd0,
      child: AppBar(
        toolbarHeight: subTitle != null ? 68.h : isHeightPadding ? 88.h : 56.h,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        leadingWidth: 40.w,
        leading: svgIcon(isWhite ? 'assets/icon/ico-line-arrow-back-white.svg' : 'assets/icon/ico-line-arrow-back-black.svg', function: isGoToMain ? () => Navigator.pushReplacementNamed(
            context, RouteName.home) : () => Navigator.pop(context)),
        title: subTitle != null ? Column(children: [
          Text(title ?? "", style: s20w600.copyWith(color: black)),
          sbh8,
          Text(subTitle ?? "", style: TextStyle(color: gray58, fontSize: 14.sp),
          )
        ]) : Text(title ?? "", style: s20w600.copyWith(color: isWhite ? white : black)),
        actions: [
          iconButton ?? sb
        ],
      ),
    );
  }
}

Widget cudiAppBar(
  BuildContext context, {
  String? appBarTitle,
  Widget? iconButton,
  bool? isGoToMain,
  bool? isPadding,
  void Function()? leadingFunction,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: isPadding != null ? 24.h : 0),
    child: SizedBox(
      height: 56.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: 20.w,
              height: 20.h,
              child: GestureDetector(
                  onTap: leadingFunction ??
                      () {
                        isGoToMain == null
                            ? Navigator.pop(context)
                            : Navigator.pushReplacementNamed(
                                context, RouteName.home);
                      },
                  child: svgIcon('assets/icon/ico-line-arrow-back-white.svg'))),
          Text(appBarTitle ?? '', style: appBarStyle),
          SizedBox(
              width: 24.w,
              height: 24.h,
              child: iconButton ?? SizedBox(width: 20.w)),
        ],
      ),
    ),
  );
}

Widget customSheetAppBar(String title) {
  return AppBar(
    toolbarHeight: 56.h,
    leading: svgIcon('assets/icon/ico-line-arrow-back-black.svg'),
    title: Text(title, style: s20w600.copyWith(color: black)),
  );
  // return Container(
  //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
  //   height: 56.h,
  //   child: Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       SizedBox(
  //         width: 40.0.w,
  //         height: 40.0.h,
  //         // child: IconButton(
  //         //   // onPressed: () => Navigator.pop(context),
  //         //   icon:
  //         //   svgIcon('assets/icon/ico-line-arrow-back-black.svg'),
  //         // ),
  //       ),
  //       Text('메뉴보기',
  //           style: TextStyle(
  //               color: black,
  //               fontSize: 20.0.sp,
  //               fontWeight: FontWeight.w600,
  //               letterSpacing: -0.1)),
  //       SizedBox(width: 40.w)
  //     ],
  //   ),
  // );
}
