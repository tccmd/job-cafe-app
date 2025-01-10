import 'package:CUDI/screens/components/icons/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/db/firebase_firestore.dart';
import '../../../utils/provider.dart';
import '../../../../constants.dart';

class HeartIcon extends StatefulWidget {
  final String? storeId;
  bool isPlain;
  bool isColumn;

  HeartIcon(
      {Key? key,
      required this.storeId,
      this.isPlain = false,
      this.isColumn = false})
      : super(key: key);

  @override
  State<HeartIcon> createState() => _HeartIconState();
}

class _HeartIconState extends State<HeartIcon> {
  late bool isFavorite;
  late int storeFav = 0;

  // favorite 개수
  void _initializeData() async {
    late int data;
    if (mounted) {
      data = await FireStore.getFavQuanWithStore(widget.storeId ?? "");
      setState(() {
        storeFav = data;
      });
    }
  }

  @override
  void initState() {
    _initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var u = UserProvider.of(context);
    var p = UtilProvider.of(context);
    isFavorite = p.favorites.any((favorite) => favorite.storeId == widget.storeId);
    return InkWell(
      onTap: () async {
        await FireStore.toggleFavorite(
            isFavorite, u.uid, widget.storeId.toString());
        _initializeData();
        await UtilProvider.getFavorites(context, u.uid);
      },
      child: widget.isColumn
          ? Column(
              children: [
                SizedBox(
                  width: 32.w,
                  height: 32.h,
                  child: Image.asset(
                    isFavorite
                        ? 'assets/icon/heart.png'
                        : 'assets/icon/heart_o.png',
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  storeFav.toString(),
                  style: w500.copyWith(color: Colors.white),
                ),
              ],
            )
          : Row(
              children: [
                SizedBox(
                  width: widget.isPlain ? 24.w : 32.w,
                  height: widget.isPlain ? 24.h : 32.h,
                  child: widget.isPlain
                      ? svgIcon(
                          isFavorite
                              ? 'assets/icon/ico-line-heart-black-on.svg'
                              : 'assets/icon/ico-line-heart-black.svg',
                        )
                      : Image.asset(
                          isFavorite
                              ? 'assets/icon/heart.png'
                              : 'assets/icon/heart_o.png',
                        ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  storeFav.toString(),
                  style: w500.copyWith(
                      color: widget.isPlain ? black : white),
                ),
              ],
            ),
    );
  }
}
