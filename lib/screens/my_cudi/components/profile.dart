import 'package:CUDI/screens/my_cudi/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../models/user.dart';
import '../../../utils/provider.dart';
import '../../../widgets/cudi_widgets.dart';
import '../../components/icons/svg_icon.dart';

Widget profile(BuildContext context, {bool? isMyScreen}) {
  var p = UtilProvider.of(context);
  isMyScreen = isMyScreen ?? false;
  SizedBox sbh4 = SizedBox(height: 4.h);
  return Column(
    children: [
      sbh24,
      Stack(children: [
        if (!isMyScreen)
          const SizedBox(
            height: 96 + 8, // 프로필 편집 아이콘을 위한 여백
            width: 96 + 8,
          ),
        circleBeany(context, isSmaile: true, size: 96),
        if (!isMyScreen)
          Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                  onTap: () async {
                    await p.getImage(ImageSource.gallery).then((value) {
                      p.imagePickerFunction(context, p.pickedImage);
                    });
                  },
                  child: svgIcon('assets/icon/Frame6356926.svg')))
      ]),
      sbh24,
      InkWell(
        onTap: isMyScreen
            ? () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditScreen())); // AppbarScreen(title: '내 정보 수정', column: editMyInformation(context))));
        }
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Selector<UserProvider, String>(
              selector: (context, userProvider) => userProvider.currentUser.userNickname ?? "",
              builder: (context, value, child) {
                return Text('$value', style: s16w600);
              },
            ),
            if (isMyScreen)
              svgIcon(
                  'assets/icon/ico-line-arrow-right-white-24px.svg')
          ],
        ),
      ),
      sbh4,
      Selector<UserProvider, String>(
        selector: (context, userProvider) => userProvider.userEmail,
        builder: (context, value, child) {
          return Text('$value', style: h17.copyWith(color: gray79));
        },
      ),
    ],
  );
}