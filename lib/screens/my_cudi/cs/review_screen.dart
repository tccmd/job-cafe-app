import 'package:CUDI/screens/components/no_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../utils/provider.dart';
import '../../../widgets/cudi_widgets.dart';
import '../../components/app_bar.dart';

class MyReviewScreen extends StatefulWidget {
  final String title;

  const MyReviewScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<MyReviewScreen> createState() => _MyReviewScreenState();
}

class _MyReviewScreenState extends State<MyReviewScreen> {
  @override
  Widget build(BuildContext context) {
    UtilProvider p = UtilProvider.of(context);
    UserProvider u = UserProvider.of(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            sliverAppBar(context, title: widget.title),
            SliverList(
              delegate: SliverChildListDelegate([
                NoContent(imgUrl: 'assets/images/img-emptystate-peparing.png', imgWidth: 186.w, imgHeight: 136.h, title: '리뷰 준비 중!', subTitle: '2024년, 더 편리한 쿠디를 위해 준비중이에요', btnText: '준비되면 알림받기', function: () => p.updateUserConsents(context, u.uid, {'push_notification_consent': true}))
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
