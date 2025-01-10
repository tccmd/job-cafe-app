import 'package:flutter/material.dart';
import '../../constants.dart';

Widget bigText(String text) {
  return Padding(
    padding: pd16v,
    child: Container(
        alignment: Alignment.centerLeft,
        child: Text(text, style: big, textAlign: TextAlign.start)),
  );
}