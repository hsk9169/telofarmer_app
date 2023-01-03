import 'package:flutter/material.dart';
import 'package:telofarmer_app/consts/colors.dart';
import 'package:telofarmer_app/consts/sizes.dart';

@immutable
class VerticalScrollBox extends StatelessWidget {
  final double width;
  final double height;
  final ScrollController controller;
  final List<Widget>? children;

  const VerticalScrollBox({
    Key? key,
    required this.width,
    required this.height,
    required this.controller,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        width: context.pWidth,
        height: context.pHeight,
        padding: EdgeInsets.only(
          left: context.hPadding,
          right: context.hPadding,
          top: context.vPadding,
        ),
        child: RawScrollbar(
            controller: controller,
            thumbVisibility: true,
            thumbColor: AppColors.mainColor,
            radius: Radius.circular(context.pWidth * 0.02),
            thickness: context.pWidth * 0.01,
            scrollbarOrientation: ScrollbarOrientation.right,
            trackColor: AppColors.subColor,
            trackVisibility: true,
            trackBorderColor: Colors.transparent,
            child: SingleChildScrollView(
                controller: controller,
                child: Column(children: children ?? []))));
  }
}
