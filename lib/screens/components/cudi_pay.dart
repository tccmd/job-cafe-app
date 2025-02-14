import 'dart:ui';

import 'package:jobCafeApp/screens/components/icons/svg_icon.dart';
import 'package:flutter/material.dart';

class CUDIAnimatedIcon extends StatefulWidget {
  final bool isSVG;
  final String assetPath;
  final VoidCallback function;
  final double width;
  final double height;
  const CUDIAnimatedIcon({super.key, required this.assetPath, required this.width, required this.height, this.isSVG = false, required this.function});

  @override
  State<CUDIAnimatedIcon> createState() => _CUDIAnimatedIconState();
}

class _CUDIAnimatedIconState extends State<CUDIAnimatedIcon> {
  double opacity = 1.0;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          opacity = 0.5; // 터치 다운 시 투명도 변경
        });
      },
      onTapUp: (_) {
        setState(() {
          opacity = 1.0; // 터치 업 시 투명도 원래대로 복원
        });
        widget.function(); // 함수 호출을 위해 () 추가
      },
      onTapCancel: () {
        setState(() {
          opacity = 1.0; // 터치 취소 시 투명도 원래대로 복원
        });
      },
      child: AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 100),
          child: widget.isSVG ? svgIcon(widget.assetPath) : Image.asset(
            widget.assetPath,
            width: widget.width,
            height: widget.height,
          ),
        ),
    );
  }
}