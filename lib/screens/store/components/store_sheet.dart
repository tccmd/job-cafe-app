import 'package:jobCafeApp/models/store.dart';
import 'package:jobCafeApp/utils/provider.dart';
import 'package:jobCafeApp/widgets/cudi_widgets.dart';
import 'package:jobCafeApp/screens/components/icons/haert_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants.dart';
import '../../../theme.dart';
import '../../components/app_bar.dart';
import '../../components/bottom_sheet.dart';
import '../../components/closed_sheet.dart';

class StoreSheet extends StatefulWidget {
  final List<BottomSheetItem> bottomSheetItems;
  const StoreSheet({super.key, required this.bottomSheetItems});

  @override
  State<StoreSheet> createState() => _StoreSheetState();
}

class _StoreSheetState extends State<StoreSheet> {
  late Store store;
  List<String> storeTag = ['직접 로스팅', '노키즈존', '루프탑', '내부 흡연실', '야경맛집'];
  int storeDescMaxLength = 200;

  @override
  Widget build(BuildContext context) {
    var u = UserProvider.of(context);
    store = u.currentStore;
    return BottomSheetOpened(body: body(), bottomSheetItems: widget.bottomSheetItems, pd0: pd0);
  }

  Widget body() {
    return Column(
      children: [
        CudiAppBar(title: store.storeName, subTitle: store.storeSubTitle, isPadding: true),
        sbh16,
        storeDescription(store),
        sbh24,
        storeTagList(),
        sbh24,
        divider,
        Flexible(flex: 1, child: storeInformation(store)),
        storeBottomButton(),
      ],
    );
  }

  Widget storeDescription(Store store) {
    return Padding(
      padding:pd24h,
      child: Text(
        // size?.height,
        store.storeDescription!.length <= storeDescMaxLength
            ? store.storeDescription!
            : '${store.storeDescription!.substring(0, storeDescMaxLength)}...',
        // 글자 수를 제한하고 넘치면 "..."을 추가
        style: TextStyle(fontSize: 13.sp, color: gray58, height: 1.6.sp),
        softWrap: true,
        // overflow: TextOverflow.ellipsis
      ),
    );
  }

  Widget storeTagList() {
    return Container(
      height: 32.h,
      child: ListView.builder(
        padding: pd24L,
          scrollDirection: Axis.horizontal,
          itemCount: storeTag.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
                    elevation: 0.0,
                    disabledBackgroundColor: black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.w),
                    ),
                  ),
                  child: Text(
                    '#${storeTag[index]}',
                    style:
                    TextStyle(fontSize: 12.sp, color: white, height: 1.sp),
                  )),
            );
          }),
    );
  }

  Widget storeInformation(Store store) {
    return SingleChildScrollView(
      child: SizedBox(
        child: ListView.builder(
            padding: pd24h.copyWith(top: 24.h),
            itemCount: 1,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cudiDetailListItem(
                      '운영시간', store.storeHours.toString(), 'time'),
                  cudiDetailListItem(
                      '휴무일', store.storeClosed.toString(), 'holiday',
                      color: heart),
                  cudiDetailListItem(
                      '카페 주소', store.storeAddress!, 'companyaddress',
                      click: () =>
                          _launchInBrowser(Uri.parse(store.storeTMap!)),
                      color: const Color(0xff6280E3)),
                  cudiDetailListItem(
                      '대중교통', store.storeTraffic.toString(), 'bus'),
                  cudiDetailListItem(
                      '주차장', store.storeParking.toString(), 'parking'),
                  cudiDetailListItem('전화번호', store.storeTell!, 'num',
                      click: () => _makePhoneCall(store.storeTell!),
                      color: const Color(0xff6280E3)),
                ],
              );
            }),
      ),
    );
  }

  Widget storeBottomButton() {
    return Container(
      padding: pd24h12v,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: grayEA, width: 1.w))),
      child: SizedBox(
        height: 48.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeartIcon(storeId: store.storeId, isPlain: true),
            shareIcon("cafe", store.storeId??""),
          ],
        ),
      ),
    );
  }

  // 브라우저 열기
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  // 전화 걸기
  Future<void> _makePhoneCall(String phoneNumber) async {
    try {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      bool launched = await launchUrl(launchUri);
      if (launched) {
        print('전화 걸기 성공: $phoneNumber');
      } else {
        print('전화 걸기 실패: $phoneNumber');
      }
    } catch (e) {
      print(e);
    }
  }
}
