import 'package:CUDI/utils/provider.dart';
import 'package:CUDI/widgets/cudi_buttons.dart';
import 'package:CUDI/widgets/cudi_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import 'app_bar.dart';

class AppbarScreen extends StatefulWidget {
  final String title;
  final Column column;
  final bool? padding;
  final Widget? icon;
  final String? buttonTitle;
  final bool? isNoLeading;
  final void Function()? buttonClick;

  const AppbarScreen(
      {super.key,
      required this.title,
      required this.column,
      this.padding,
      this.icon,
      this.buttonTitle,
      this.buttonClick,
      this.isNoLeading});

  @override
  State<AppbarScreen> createState() => _AppbarScreenState();
}

class _AppbarScreenState extends State<AppbarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            sliverAppBar(context,
                title: widget.title,
                iconButton: widget.icon,
                isNoLeading: widget.isNoLeading),
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
                        child: widget.column,
                      ),
                      if (widget.buttonClick != null) const Spacer(),
                      // Text(context.read<UtilProvider>().isSent.toString()),
                      if (widget.buttonClick != null) button(),
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

  Widget button() {
    return Selector<UtilProvider, String>(
      selector: (context, p) => p.certButtonTitle,
      builder: (context, buttonTitle, child) {
        // someValue를 직접 사용
        print("buttonTitle: $buttonTitle");
        return buttonSpace(
            button1(widget.buttonTitle == "프로바이더 변수" ? buttonTitle : '${widget.buttonTitle}', widget.buttonClick));
      },
    );
  }

  @override
  void dispose() {
    phoneController.clear();
    certController.clear();
    super.dispose();
  }
}
