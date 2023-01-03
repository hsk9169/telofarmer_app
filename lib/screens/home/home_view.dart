import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telofarmer_app/consts/sizes.dart';
import 'package:telofarmer_app/consts/colors.dart';
import 'package:telofarmer_app/providers/session_provider.dart';
import 'package:telofarmer_app/providers/platform_provider.dart';
import 'package:telofarmer_app/widgets/title_band.dart';
import 'package:telofarmer_app/widgets/vertical_scroll_box.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeView();
}

class _HomeView extends State<HomeView> {
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
    return SizedBox(
        width: context.pWidth,
        height: context.pHeight,
        child: Column(children: [
          const TitleBand(title: 'Notifications'),
          Expanded(
              child: VerticalScrollBox(
            width: context.pWidth,
            height: context.pHeight,
            controller: _scrollController,
            children: List.generate(
                100,
                (index) => Align(
                    alignment: Alignment.centerLeft, child: Text('Home View'))),
          ))
        ]));
  }
}
