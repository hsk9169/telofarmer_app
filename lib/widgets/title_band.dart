import 'package:flutter/material.dart';
import 'package:telofarmer_app/consts/colors.dart';
import 'package:telofarmer_app/consts/sizes.dart';

@immutable
class TitleBand extends StatelessWidget {
  final String title;

  const TitleBand({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: context.pWidth,
        alignment: Alignment.centerLeft,
        color: AppColors.subColor,
        padding: EdgeInsets.only(
          left: context.hPadding,
          right: context.hPadding,
          top: context.vPadding,
          bottom: context.vPadding,
        ),
        child: Text(title,
            style: TextStyle(
                color: AppColors.mainColor, fontSize: context.pWidth * 0.035)));
  }
}
