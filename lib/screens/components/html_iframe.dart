// 필수 import
import 'package:flutter/material.dart';
import 'dart:html';
import 'dart:ui_web' as ui;

import 'package:webview_flutter/webview_flutter.dart';

Widget getWebView({
  String? src,
  String? id,
  Function(dynamic)? listener,
  WebViewController? controller
}) {
  IFrameElement iFrame = IFrameElement();
  iFrame.src = src;
  iFrame.id = id!;
  iFrame.style.border = 'none';

  if (listener != null) {
    window.addEventListener('message', listener);
  }

  ui.platformViewRegistry.registerViewFactory(id, (int viewId) => iFrame);

  return HtmlElementView(viewType: id);
}