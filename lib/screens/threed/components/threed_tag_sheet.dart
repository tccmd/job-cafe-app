import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../components/app_bar.dart';
import '../../components/bottom_sheet.dart';
import '../../components/closed_sheet.dart';
import '../../../utils/enum.dart';
import '../../../utils/provider.dart';
import '../../../constants.dart';

class ThreedTagSheet extends StatefulWidget {
  const ThreedTagSheet({super.key});

  @override
  State<ThreedTagSheet> createState() =>
      _ThreedTagSheetState();
}

class _ThreedTagSheetState extends State<ThreedTagSheet> {
  @override
  Widget build(BuildContext context) {
    Set<Enum> filters = Provider.of<SelectedTagProvider>(context).filters; // 셋타입의 변수(괄호는 {}이나, 리스트 형식 (중복을 허용하지 않는 고유값이 필요할 때 쓴다))
    List<BottomSheetItem> bottomSheetItems = [
      BottomSheetItem(
        buttonName: "",
        onClick: () {
          var selectedTagProvider = Provider.of<SelectedTagProvider>(
              context,
              listen: false);
          selectedTagProvider.clearFilters();
        },
        assetPath: "assets/icon/ico-line-3d-black.png",
      ),
      BottomSheetItem(
        buttonName: "적용하기",
        onClick: () {
          Navigator.pop(context);
        },
        assetPath: null,
      ),
    ];
    return BottomSheetOpened(body: body(filters), bottomSheetItems: bottomSheetItems);
  }

  Widget body (filters) {
    return Column(
      children: [
        CudiAppBar(title: "지역"),
        SizedBox(
          width: 390.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 5.0),
              Wrap(
                spacing: 8.0,
                children: TagFilter.values.map((TagFilter tag) {
                  return FilterChip(
                    side: BorderSide(
                        color: filters.contains(tag) ? primary : grayEA,
                        width: 1
                    ),
                    showCheckmark: false, // 선택 됬을때 앞에 나오는 체크 유무
                    backgroundColor: Colors.transparent,
                    label: Text(tagFilterLabels[tag].toString(),
                        style: TextStyle(color: filters.contains(tag) ? primary : Colors.grey[800])),
                    elevation: 0.0,
                    pressElevation: 0.0,
                    color: MaterialStateProperty.resolveWith((states) {
                      // 예시: 선택된 상태에 따라 다른 색상 반환
                      if (states.contains(MaterialState.selected)) {
                        // 선택된 상태일 때의 색상
                        return white;
                      } else {
                        // 선택되지 않은 상태일 때의 색상
                        return white;
                      }
                    }),
                    selected: filters.contains(tag),
                    onSelected: (bool selected) {
                      var selectedTagProvider = Provider.of<SelectedTagProvider>(context, listen: false);
                      selectedTagProvider.toggleFilter(tag);
                    },
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
