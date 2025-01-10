import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget svgIcon(String assetPath, {void Function()? function}) {
  return GestureDetector(
      onTap: function,
      child: SvgPicture.asset(assetPath, fit: BoxFit.scaleDown));
}
