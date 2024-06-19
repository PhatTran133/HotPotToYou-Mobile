import 'package:electronic_equipment_store/core/constants/color_constants.dart';
import 'package:electronic_equipment_store/core/constants/textstyle_constants.dart';
import 'package:flutter/material.dart';

class AppBarMain extends StatelessWidget {
  const AppBarMain({
    super.key,
    required this.child,
    this.titleAppbar,
    required this.leading,
  });

  final Widget child;
  final String? titleAppbar;
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 56,
          child: AppBar(
            leading: leading,
            title: Text(
              titleAppbar ?? '',
              style: TextStyles.h5.bold.setTextSize(19),
            ),
            backgroundColor: ColorPalette.backgroundScaffoldColor,
            centerTitle: true,
            automaticallyImplyLeading: false,
            elevation: 0,

          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 56),
          child: child,
        ),
      ],
    );
  }
}
