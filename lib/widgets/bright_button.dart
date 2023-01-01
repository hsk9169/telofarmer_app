import 'package:flutter/material.dart';
import 'package:telofarmer_app/consts/colors.dart';
import 'package:telofarmer_app/consts/sizes.dart';

@immutable
class MyBrightButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const MyBrightButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.subColor),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(context.pWidth * 0.01),
              ),
            )),
        child: Text(text,
            style: TextStyle(
                color: AppColors.mainColor, fontSize: context.pWidth * 0.04)),
        onPressed: () {
          onPressed();
        });
  }
}
