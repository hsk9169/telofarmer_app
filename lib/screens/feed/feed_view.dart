import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telofarmer_app/consts/sizes.dart';
import 'package:telofarmer_app/consts/colors.dart';
import 'package:telofarmer_app/providers/session_provider.dart';
import 'package:telofarmer_app/providers/platform_provider.dart';

class FeedView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FeedView();
}

class _FeedView extends State<FeedView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            left: context.pWidth * 0.02, right: context.pWidth * 0.02),
        color: Colors.white,
        width: context.pWidth,
        height: context.pHeight,
        child: RawScrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            thumbColor: AppColors.mainColor,
            radius: Radius.circular(context.pWidth * 0.02),
            thickness: context.pWidth * 0.01,
            scrollbarOrientation: ScrollbarOrientation.right,
            trackColor: AppColors.subColor,
            trackVisibility: true,
            trackBorderColor: Colors.transparent,
            child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                    children:
                        List.generate(100, (index) => Text('Feed View'))))));
  }
}
