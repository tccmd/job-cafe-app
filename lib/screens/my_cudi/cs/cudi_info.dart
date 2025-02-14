import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme.dart';
import '../../../widgets/cudi_buttons.dart';
import '../../components/app_bar.dart';
import '../../../constants.dart';
import '../../components/icons/cart_icon.dart';

class CUDIInfo extends StatefulWidget {
  final String title;
  final bool? padding;
  final CartIcon? cartIcon;
  final String? buttonTitle;
  final void Function()? buttonClick;

  const CUDIInfo(
      {super.key,
        required this.title,
        this.cartIcon,
        this.padding,
        this.buttonTitle,
        this.buttonClick});

  @override
  State<CUDIInfo> createState() => _CUDIInfoState();
}

class _CUDIInfoState extends State<CUDIInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            sliverAppBar(context,
                title: widget.title, iconButton: widget.cartIcon),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      88.h -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                        widget.padding == null ? pd24h : EdgeInsets.zero,
                        child: Column(
                          children: [
                            SizedBox(height: 668.h, child: listViewWidget()),
                          ],
                        ),
                      ),
                      if(widget.buttonClick != null) const Spacer(),
                      if(widget.buttonClick != null) Padding(
                        padding: pd24202407,
                        child: whiteButton(
                            '${widget.buttonTitle}', null, widget.buttonClick),
                      )
                    ],
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }

  ListView listViewWidget() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: titleList.length, itemBuilder: (context, index) {
      return bottomBorderContainer(index);
    });
  }

  List<String> titleList = [
    '상호',
    '대표이사',
    '사업자등록번호',
    '통신판매업번호',
    '주소',
    '전화번호',
    '팩스번호',
  ];
  List<String> descList = [
    'MintChoco(민트초코)',
    '정희원',
    '000-00-00000',
    '0000-민트초코-0000 호',
    '대한민국',
    '000.000.0000',
    '000.000.0000',
  ];
  Container bottomBorderContainer(int index) {
    return Container(
      decoration: index == titleList.length-1 ? null: bottomBorder,
      child: Padding(padding: pd24all,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titleList[index], style: s12.copyWith(color: gray79)),
              sbh8,
              Text(descList[index], style: s16w500),
            ],
          )),
    );
  }
}
