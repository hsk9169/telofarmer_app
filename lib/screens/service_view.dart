import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:animations/animations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telofarmer_app/consts/colors.dart';
import 'package:telofarmer_app/models/auth/models.dart';
import 'package:telofarmer_app/providers/platform_provider.dart';
import 'package:telofarmer_app/providers/session_provider.dart';
import 'package:telofarmer_app/consts/sizes.dart';
import 'package:telofarmer_app/screens/pages.dart';

class ServiceView extends StatefulWidget {
  final int? tapNum;
  const ServiceView(this.tapNum);
  @override
  State<StatefulWidget> createState() => _ServiceView();
}

class _ServiceView extends State<ServiceView> {
  Widget? _bodyWidget(int _index) {
    switch (_index) {
      case 0:
        return HomeView();
      case 1:
        return FeedView();
      case 2:
        return BlocksView();
      case 3:
        return ArchiveView();
      case 4:
        return InputView();
      case 5:
        return HubView();
      default:
        break;
    }
  }

  void _onItemTapped(int sel) {
    Provider.of<Platform>(context, listen: false).servicePageNum = sel + 1;
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = Provider.of<Platform>(context, listen: true).isLoading;
    int pageNum = Provider.of<Platform>(context, listen: true).servicePageNum;
    return AbsorbPointer(
        absorbing: isLoading,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size(context.pWidth, context.pHeight * 0.06),
            child: AppBar(
              titleSpacing: 0,
              backgroundColor: Colors.white,
              title: _appBar(),
              elevation: 0,
            ),
          ),
          body: SafeArea(
              bottom: false,
              child: PageTransitionSwitcher(
                  transitionBuilder: (
                    child,
                    animation,
                    secondaryAnimation,
                  ) {
                    return SharedAxisTransition(
                        animation: animation,
                        secondaryAnimation: secondaryAnimation,
                        transitionType: SharedAxisTransitionType.horizontal,
                        child: child);
                  },
                  child: _bodyWidget(
                      Provider.of<Platform>(context, listen: true)
                          .servicePageNum))),
          bottomNavigationBar: BottomNavigationBar(
            onTap: _onItemTapped,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Padding(
                    padding: EdgeInsets.only(bottom: context.pHeight * 0.01),
                    child: SvgPicture.asset(
                        pageNum == 1
                            ? 'assets/icons/feed_active.svg'
                            : 'assets/icons/feed.svg',
                        width: context.pWidth * 0.08)),
                label: 'Feed',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                    padding: EdgeInsets.only(bottom: context.pHeight * 0.01),
                    child: SvgPicture.asset(
                        pageNum == 2
                            ? 'assets/icons/blocks_active.svg'
                            : 'assets/icons/blocks.svg',
                        width: context.pWidth * 0.08)),
                label: 'Blocks',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                    padding: EdgeInsets.only(bottom: context.pHeight * 0.01),
                    child: SvgPicture.asset(
                        pageNum == 3
                            ? 'assets/icons/archive_active.svg'
                            : 'assets/icons/archive.svg',
                        width: context.pWidth * 0.08)),
                label: 'Archive',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                    padding: EdgeInsets.only(bottom: context.pHeight * 0.01),
                    child: SvgPicture.asset(
                        pageNum == 4
                            ? 'assets/icons/input_active.svg'
                            : 'assets/icons/input.svg',
                        width: context.pWidth * 0.08)),
                label: 'Input',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                    padding: EdgeInsets.only(bottom: context.pHeight * 0.01),
                    child: SvgPicture.asset(
                        pageNum == 5
                            ? 'assets/icons/hub_active.svg'
                            : 'assets/icons/hub.svg',
                        width: context.pWidth * 0.08)),
                label: 'Hub',
              ),
            ],
            backgroundColor: Colors.white,
            elevation: 1,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: context.pHeight * 0.015,
            unselectedFontSize: context.pHeight * 0.015,
            unselectedItemColor: AppColors.mainColor,
          ),
        ));
  }

  Widget _appBar() {
    final sessionProvider = Provider.of<Session>(context, listen: true);
    final platformProvider = Provider.of<Platform>(context, listen: true);
    final String siteName = 'Roederer Estate';
    return Container(
        color: Colors.white,
        width: context.pWidth,
        margin: EdgeInsets.only(
          left: context.hPadding,
          right: context.hPadding,
          top: context.vPadding,
          bottom: context.vPadding,
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SvgPicture.asset('assets/icons/telofarm_mark.svg',
              width: context.pWidth * 0.06),
          Text(siteName,
              style: TextStyle(
                  color: AppColors.mainColor, fontSize: context.pWidth * 0.04)),
          GestureDetector(
              child: platformProvider.servicePageNum == 0
                  ? SvgPicture.asset('assets/icons/home_active.svg',
                      width: context.pWidth * 0.05)
                  : SvgPicture.asset('assets/icons/home.svg',
                      width: context.pWidth * 0.05),
              onTap: () => _onItemTapped(-1))
        ]));
  }
}
