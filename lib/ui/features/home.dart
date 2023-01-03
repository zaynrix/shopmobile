// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/data/local_repo.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/resources/assets_manager.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/routing/navigation.dart';
import 'package:shopmobile/routing/routes.dart';
import 'package:shopmobile/ui/features/Profile/profileScreen.dart';
import 'package:shopmobile/ui/features/cart/cartScreen.dart';
import 'package:shopmobile/ui/features/explor/explorScreen.dart';
import 'package:shopmobile/ui/features/favorite/favoriteScreen.dart';
import 'package:shopmobile/ui/features/home/homeProvider.dart';
import 'package:shopmobile/ui/features/home/homeScreen.dart';
import 'package:shopmobile/ui/shared/widgets/CustomAppBar.dart';
import 'package:shopmobile/ui/shared/widgets/CustomWidget.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeSvg.dart';
import 'package:badges/badges.dart';
import 'package:shopmobile/utils/storage.dart';


class PagesTestWidget extends StatefulWidget {
  Widget currentPage = Home();

  String? currentTitle;
  int currentTab;

  PagesTestWidget({
    Key? key,
    required this.currentTab,
  }) {
    currentTab = 0;
  }

  @override
  _PagesTestWidgetState createState() => _PagesTestWidgetState();
}

class _PagesTestWidgetState extends State<PagesTestWidget> {
  @override
  initState() {
    sl<HomeProvider>();
    super.initState();
    _selectTab(widget.currentTab);
  }
// @override
  @override
  void didUpdateWidget(PagesTestWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }


  var data = sl<SharedLocal>().getUser();

  void _selectTab(int tabItem) {
    setState(
      () {
        widget.currentTab = tabItem;
        switch (tabItem) {
          case 0:
            widget.currentTitle = "Home";
            widget.currentPage = Home();

            break;
          case 1:
            widget.currentTitle = "ShoppingCart";
            // data == ""
            //     ?
            widget.currentPage = Cart();
                // : sl<NavigationService>().navigateToAndRemove(login);
            break;
          case 2:
            widget.currentTitle = "Explore";
            widget.currentPage = Explore();
            break;
          case 3:
            widget.currentTitle = "Favorite";
            widget.currentPage = FavoriteScreen();
            break;
          case 4:
            widget.currentTitle = "Profile";
            widget.currentPage = Profile();
            break;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<CustomAppBar> appbar = [
      CustomAppBar(
        title: widget.currentTitle!.tr(),
        leading: GestureDetector(
          onTap: () {
            sl<NavigationService>().navigateTo(categoryScreen);
          },
          child: CustomSvgAssets(
            path: IconAssets.Category,
            // color: ColorManager.black,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              sl<NavigationService>().navigateTo(searchScreen);
            },
            child: CustomSvgAssets(
              path: IconAssets.search,
              // color: ColorManager.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Badge(
                badgeColor: ColorManager.starYellow,
                position: BadgePosition.topEnd(top: 10, end: 0),
                badgeContent: null,
                child: GestureDetector(
                  onTap: () {
                    sl<NavigationService>().navigateTo(notifications);
                  },
                  child: CustomSvgAssets(
                    path: IconAssets.notification,
                    // color: ColorManager.black,
                  ),
                )),
          ),
        ],
      ),
      CustomAppBar(
        title: widget.currentTitle!,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: GestureDetector(
              onTap: () {},
              child: CustomSvgAssets(
                path: IconAssets.menu,
                color: ColorManager.black,
              ),
            ),
          ),
        ],
      ),
      CustomAppBar(
        title: widget.currentTitle!,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Badge(
                badgeColor: ColorManager.starYellow,
                position: BadgePosition.topEnd(top: 10, end: 0),
                badgeContent: null,
                child: GestureDetector(
                  onTap: () {
                    sl<NavigationService>().navigateTo(notifications);
                  },
                  child: CustomSvgAssets(
                    path: IconAssets.notification,
                    color: ColorManager.black,
                  ),
                )),
          )
        ],
      ),
      CustomAppBar(
        title: widget.currentTitle!,
      ),
      CustomAppBar(
        title: widget.currentTitle!,
      )
    ];
    return Scaffold(
      // key: ,
      appBar: appbar[widget.currentTab],
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: widget.currentPage,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.07),
              spreadRadius: 5,
              blurRadius: 30,
              offset: Offset(0, -7), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: <BottomNavigationBarItem>[
              CommonWidget().getItem(
                current: widget.currentTab,
                iconPath: IconAssets.home,
                index: 0,
              ),
            CommonWidget().getItem(
                current: widget.currentTab,
                iconPath: IconAssets.cart,
                index: 1,
              ) ,
              CommonWidget().getItem(
                current: widget.currentTab,
                iconPath: IconAssets.explor,
                index: 2,
              ),
              CommonWidget().getItem(
                current: widget.currentTab,
                iconPath: IconAssets.star,
                index: 3,
              ),
              CommonWidget().getItem(
                current: widget.currentTab,
                iconPath: IconAssets.profile,
                index: 4,
              ),
            ],
            currentIndex: widget.currentTab,
            selectedItemColor: Colors.amber[800],
            onTap: (int i) {
              _selectTab(i);
            },
          ),
        ),
      ),
    );
  }
}
