import 'package:jobCafeApp/utils/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../screens/auth/term_screen.dart';

Widget cudiAllCheckBox({bool? value, void Function(bool?)? onChange, bool? sized20}) {
  return Checkbox(
    value: value,
    onChanged: onChange,
    side: MaterialStateBorderSide.resolveWith(
          (states) => BorderSide(
        color: states.contains(MaterialState.selected) ? primary : gray58,
        width: sized20 == null ? 1 : 2,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
    ),
    checkColor: white,
    visualDensity: VisualDensity.compact,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
    ),
    fillColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.selected) ? primary : Colors.transparent,
    ),
  );
}

Widget cudiWhiteFillCheckBox(bool? value, void Function(bool?)? onChange){
  return Checkbox(value: value, onChanged: onChange,
    side: const BorderSide(color: grayEA),
    checkColor: white,
    fillColor: MaterialStateProperty.resolveWith ((Set  states) {
      if (states.contains(MaterialState.selected)) {
        return primary.withOpacity(.82);
      }
      return white;
    }),
  );
}

Widget cudiTransparentCheckBox(bool? value, void Function(bool?)? onChange){
  return Checkbox(value: value, onChanged: onChange,
    visualDensity: VisualDensity.compact,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    side: BorderSide.none,
    checkColor: primary,
    fillColor: const MaterialStatePropertyAll(Colors.transparent),
  );
}

Widget primarySwitch({
  required bool? value,
  required ValueChanged<bool> onChanged,
}) {
  if (value == null) {
    return Switch(
      value: false,
      onChanged: null,
      inactiveTrackColor: Colors.grey.withOpacity(0.5),
      inactiveThumbColor: Colors.grey,
      inactiveThumbImage: null,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  final MaterialStateProperty<Color?> trackColor =
  MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return primary;
      }
      return gray3D;
    },
  );
  final MaterialStateProperty<Color?> thumbColor =
  MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return white;
      }
      return gray79;
    },
  );
  final MaterialStateProperty<Icon?> thumbIcon =
  MaterialStateProperty.resolveWith<Icon?>(
        (Set<MaterialState> states) {
      return const Icon(null);
    },
  );
  return Switch(
    value: value,
    onChanged: onChanged,
    trackColor: trackColor,
    thumbColor: thumbColor,
    thumbIcon: thumbIcon,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
}

Widget checkRow({required String text, required bool value, void Function(bool)? onChange}) {
  return Container(
    height: 40.h,
    padding: pd24T,
    child: Row(
      children: [
        SizedBox(width:20.w, child: cudiAllCheckBox(value: value, onChange: (value) => onChange?.call(value ?? false))),
        SizedBox(width: 16.w),
        Text(text, style: w500.copyWith(height: 1.h)),
      ],
    ),
  );
}

Widget checkboxWithRichTextWidget(BuildContext context, String labelText, {String? dynamicText, String? term_title, String? term_term, Color? bgColor}) {
  var p = UtilProvider.of(context);
  return Row(
    children: [
      SizedBox(height:16.h, child: cudiAllCheckBox(value: p.allowButtonCheck, onChange: (value) => p.setAllowButtonCheck(value!))),
      SizedBox(width: 8.w),
      GestureDetector(
        onTap: () {
          if (term_term != null) {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                    TermScreen(title: term_title ?? "",
                        term: term_term ?? "",
                        bgColor: bgColor ?? black)));
          }
        },
        child: RichText(
          text: TextSpan(
            style: s12,
            children: <TextSpan>[
              const TextSpan(
                text: '[필수]',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              TextSpan(
                text: labelText,
              ),
              if(dynamicText != null) TextSpan(
                text: dynamicText,
                style: w500.copyWith(decoration: TextDecoration.underline),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}