import 'package:flutter/material.dart';
import 'package:telofarmer_app/consts/colors.dart';
import 'package:telofarmer_app/consts/sizes.dart';

@immutable
class MyTextInput extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final bool obscure;
  final Icon? suffixIcon;
  final Function? onTapSuffixIcon;

  const MyTextInput({
    Key? key,
    required this.textController,
    required this.hintText,
    required this.obscure,
    this.suffixIcon,
    this.onTapSuffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: textController,
        obscureText: obscure,
        textAlignVertical: TextAlignVertical.center,
        autofocus: false,
        cursorColor: AppColors.mainColor,
        style: TextStyle(
            color: AppColors.mainColor, fontSize: context.pWidth * 0.04),
        decoration: InputDecoration(
            isDense: true,
            contentPadding: suffixIcon != null
                ? EdgeInsets.only(
                    left: context.pWidth * 0.02,
                    right: context.pWidth * 0.02,
                    top: 0,
                    bottom: 0,
                  )
                : EdgeInsets.all(context.pWidth * 0.02),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                )),
            suffixIcon: suffixIcon != null
                ? IconButton(
                    icon: suffixIcon!,
                    iconSize: context.pWidth * 0.05,
                    padding: EdgeInsets.zero,
                    color: AppColors.mainColor,
                    onPressed: () {
                      onTapSuffixIcon!();
                    })
                : null,
            filled: true,
            fillColor: AppColors.subColor,
            hintText: hintText,
            hintStyle: TextStyle(color: AppColors.mainColor)),
        keyboardType: TextInputType.text);
  }
}
