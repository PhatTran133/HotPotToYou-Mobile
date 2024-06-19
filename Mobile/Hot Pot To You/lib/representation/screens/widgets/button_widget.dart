import 'package:electronic_equipment_store/core/constants/color_constants.dart';
import 'package:electronic_equipment_store/core/constants/dismension_constants.dart';
import 'package:electronic_equipment_store/core/constants/textstyle_constants.dart';
import 'package:flutter/material.dart';



class ButtonWidget extends StatefulWidget {
  const ButtonWidget(
      {super.key,
      required this.title,
      this.onTap,
      this.height,
      this.width,
      this.size,
      this.color});

  final String title;
  final Function()? onTap;
  final double? height;
  final double? width;
  final double? size;
  final Color? color;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  var glowing = false;
  var scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (val) {
        setState(() {
          glowing = false;
          scale = 1.0;
        });
      },
      onTapDown: (val) {
        setState(() {
          glowing = true;
          scale = 1.1;
        });
      },
      onTap: widget.onTap,
      child: AnimatedContainer(
        transform: Matrix4.identity()..scale(scale),
        duration: const Duration(milliseconds: 100),
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kDefaultCircle14),
            color: widget.color ?? ColorPalette.primaryColor,
            boxShadow: glowing
                ? [
                    const BoxShadow(
                      color: Colors.black38,
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(8, 0),
                    ),
                  ]
                : []),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.title,
              style: TextStyles.defaultStyle.bold
                  .setTextSize(widget.size!)
                  .whiteTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
