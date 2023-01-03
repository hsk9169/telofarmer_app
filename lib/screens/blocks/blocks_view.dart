import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telofarmer_app/consts/sizes.dart';
import 'package:telofarmer_app/consts/colors.dart';
import 'package:telofarmer_app/providers/session_provider.dart';
import 'package:telofarmer_app/providers/platform_provider.dart';

class BlocksView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BlocksView();
}

class _BlocksView extends State<BlocksView> {
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
        color: Colors.white,
        width: context.pWidth,
        height: context.pHeight,
        child: Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            thickness: context.pWidth * 0.02,
            radius: Radius.circular(context.pWidth * 0.02),
            scrollbarOrientation: ScrollbarOrientation.right,
            child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                    children:
                        List.generate(100, (index) => Text('Blocks View'))))));
  }
}
