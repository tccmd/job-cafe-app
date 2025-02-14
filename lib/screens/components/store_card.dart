import 'package:jobCafeApp/utils/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../models/store.dart';
import 'icons/threed_icon.dart';
import '../../widgets/cudi_widgets.dart';
import 'icons/haert_icon.dart';
import '../../../constants.dart';

class StoreCard extends StatefulWidget {
  final Store store;

  const StoreCard({Key? key, required this.store}) : super(key: key);

  @override
  State<StoreCard> createState() => _StoreCardState();
}

class _StoreCardState extends State<StoreCard> {
  late Store store;

  @override
  Widget build(BuildContext context) {
    store = widget.store;
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.w),
      ),
      child: stack(),
    );
  }

  Widget stack() {
    return Stack(
      children: [
        storeImage(),
        gradient(),
        storeName(),
        storeAddress(),
        materialButton(),
        heartIcon(),
        threeDIcon(),
      ],
    );
  }

  Widget storeImage() {
    return Image.asset('assets/images/matterport_model.png',
      fit: BoxFit.cover,
      width: 342.w,
      height: 456.h,
    );
    return Image.network(
      store.storeImageUrl.toString(),
      fit: BoxFit.cover,
      width: 342.w,
      height: 456.h,
    );
  }

  Widget gradient() {
    return Container(
      width: 342.w,
      height: 456.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.w),
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
    );
  }

  Widget storeName() {
    return Positioned(
      top: 24.h,
      left: 24.w,
      child: Text(
        '${store.storeName}',
        style: s16w600,
      ),
    );
  }

  Widget storeAddress() {
    return Positioned(
        top: 44.h, left: 24.w, child: customStoreAddress(store.storeAddress));
  }

  Widget materialButton() {
    UserProvider userProvider = context.read<UserProvider>();
    return MaterialButton(
      splashColor: white.withOpacity(0.1),
      onPressed: () => userProvider.goStoreScreen(context, store),
      child: SizedBox(
        width: 342.w,
        height: 456.h,
      ),
    );
  }

  Widget heartIcon() {
    return Positioned(
      left: 24.w,
      bottom: 24.h,
      child: HeartIcon(storeId: store.storeId),
    );
  }

  Widget threeDIcon() {
    return Positioned(
      bottom: 24.h,
      right: 24.w,
      child: ThreeDIcon(storeThreeDUrl: store.storeThreeDUrl.toString()),
    );
  }
}