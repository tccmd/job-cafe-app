import 'package:jobCafeApp/screens/components/no_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../utils/provider.dart';
import '../../../widgets/cudi_widgets.dart';
import '../../components/app_bar.dart';

class MyGradeScreen extends StatefulWidget {
  final String title;

  const MyGradeScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<MyGradeScreen> createState() => _MyGradeScreenState();
}

class _MyGradeScreenState extends State<MyGradeScreen> {
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
                NoContent(imgUrl: 'assets/logo/MintChoco.png', imgWidth: 186.w, imgHeight: 136.h, title: '민트 등급은 준비 중!', subTitle: '2025년, 더 편리한 민트를 위해 준비중이에요', btnText: '준비되면 알림받기', function: () => p.updateUserConsents(context, u.uid, {'push_notification_consent': true}))
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
