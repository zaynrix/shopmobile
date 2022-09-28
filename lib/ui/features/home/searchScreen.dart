import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/models/subCategoryModel.dart';
import 'package:shopmobile/resources/assets_manager.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/resources/font_manager.dart';
import 'package:shopmobile/routing/navigation.dart';
import 'package:shopmobile/routing/routes.dart';
import 'package:shopmobile/ui/features/cart/cartProvider.dart';
import 'package:shopmobile/ui/features/home/homeProvider.dart';
import 'package:shopmobile/ui/shared/pages/reConnect.dart';
import 'package:shopmobile/ui/shared/skeletonWidget/SkeletonMobileCard.dart';
import 'package:shopmobile/ui/shared/widgets/CustomAppBar.dart';
import 'package:shopmobile/ui/shared/widgets/CustomCTAButton.dart';
import 'package:shopmobile/ui/shared/widgets/CustomMobileCard.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeRoundedTextFiled.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeSvg.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) => RefreshIndicator(
        color: ColorManager.primaryGreen,
        onRefresh: () async {
          await value.refreshSearch();
        },
        child: Scaffold(
          appBar: CustomAppBar(
            title: "Search",
          ),
          backgroundColor: ColorManager.backgroundColor,
          body: OfflineBuilder(
            connectivityBuilder: (
                BuildContext context,
                ConnectivityResult connectivity,
                Widget child,
                ) {
              if (connectivity == ConnectivityResult.none) {
                return NetworkDisconnected(onPress: (){
                  // sl<HomeProvider>().getHomeProvider();
                });
              } else {
                return child;
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: CustomTextFiled(
                            prefixIcon: CustomSvgAssets(
                              color: ColorManager.lightGrey,
                              path: IconAssets.search,
                            ),

                            hintText: 'Search'.tr(),
                            keyboardType: TextInputType.emailAddress,
                            focuse: (_) => FocusScope.of(context).nextFocus(),
                            textInputAction: TextInputAction.next,
                            onChanged: (val) {
                              value.searchProduct(tex: val);
                              value.searchController.text = val!;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          flex: 1,
                          child: CustomeCTAButton(
                            heighbox: 55,
                            primary: ColorManager.secondColor,
                            onPressed: () {
                              showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                backgroundColor: Colors.white,
                                context: context,
                                builder: (context) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 25),
                                  child: ListView(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Filter".tr(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(
                                                    color: ColorManager.black,
                                                    fontWeight:
                                                        FontWeightManager.semiBold),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 32.h,
                                      ),
                                      Card(
                                        elevation: 0,
                                        color: ColorManager.primarySuger,
                                        child: ExpansionTile(
                                          iconColor: ColorManager.lightGrey,
                                          tilePadding:
                                              EdgeInsets.symmetric(horizontal: 10),
                                          title: Text(
                                            "Brand".tr(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(
                                                    color: ColorManager.black,
                                                    fontWeight:
                                                        FontWeightManager.semiBold),
                                          ),
                                          children: [
                                            Card(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 14,
                                                          vertical: 4),
                                                  child: Row(
                                                    children: [
                                                      Chip(
                                                        label: Text(
                                                          "Apple".tr(),
                                                        ),
                                                        shape: StadiumBorder(
                                                          side: BorderSide(
                                                              color: ColorManager
                                                                  .lightPink,
                                                              width: 1),
                                                        ),
                                                        backgroundColor:
                                                            ColorManager.white,
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      Chip(
                                                        label: Text(
                                                          "OnePlus".tr(),
                                                        ),
                                                        shape: StadiumBorder(
                                                          side: BorderSide(
                                                              color: ColorManager
                                                                  .lightPink,
                                                              width: 1),
                                                        ),
                                                        backgroundColor:
                                                            ColorManager.white,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                margin: EdgeInsets.zero,
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: ColorManager
                                                            .lightPink))),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                      Card(
                                        elevation: 0,
                                        color: ColorManager.primarySuger,
                                        child: ExpansionTile(
                                          iconColor: ColorManager.lightGrey,
                                          tilePadding:
                                              EdgeInsets.symmetric(horizontal: 10),
                                          title: Text(
                                            "Price".tr(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(
                                                    color: ColorManager.black,
                                                    fontWeight:
                                                        FontWeightManager.semiBold),
                                          ),
                                          children: [
                                            Card(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 14,
                                                          vertical: 8),
                                                  child: StatefulBuilder(
                                                    builder: (context, setState) =>
                                                        Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                            "${value.rangeValues.start.round()} AED - ${value.rangeValues.end.round()} AED"),
                                                        RangeSlider(
                                                          inactiveColor:
                                                              ColorManager.fadeGrey,
                                                          activeColor: ColorManager
                                                              .primaryGreen,
                                                          labels: RangeLabels(
                                                              '${value.rangeValues.start.round()}',
                                                              '${value.rangeValues.end.round()}'),
                                                          values: value.rangeValues,
                                                          min: 0,
                                                          divisions: 1000,
                                                          max: 50000,
                                                          onChanged:
                                                              (RangeValues values) {
                                                            setState(() {
                                                              value.rangeChanged(
                                                                  values);
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                margin: EdgeInsets.zero,
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: ColorManager
                                                            .lightPink))),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                      Card(
                                        elevation: 0,
                                        color: ColorManager.primarySuger,
                                        child: ExpansionTile(
                                          iconColor: ColorManager.lightGrey,
                                          tilePadding:
                                              EdgeInsets.symmetric(horizontal: 10),
                                          title: Text(
                                            "Color".tr(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(
                                                    color: ColorManager.black,
                                                    fontWeight:
                                                        FontWeightManager.semiBold),
                                          ),
                                          children: [
                                            Card(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 14, vertical: 4),
                                                child: Row(
                                                  children: [
                                                    Chip(
                                                      label: Text(
                                                        "Red".tr(),
                                                      ),
                                                      shape: StadiumBorder(
                                                        side: BorderSide(
                                                            color: ColorManager
                                                                .lightPink,
                                                            width: 1),
                                                      ),
                                                      backgroundColor:
                                                          ColorManager.white,
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Chip(
                                                      label: Text(
                                                        "Blue".tr(),
                                                      ),
                                                      shape: StadiumBorder(
                                                        side: BorderSide(
                                                            color: ColorManager
                                                                .lightPink,
                                                            width: 1),
                                                      ),
                                                      backgroundColor:
                                                          ColorManager.white,
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Chip(
                                                      label: Text(
                                                        "Black".tr(),
                                                      ),
                                                      shape: StadiumBorder(
                                                        side: BorderSide(
                                                            color: ColorManager
                                                                .lightPink,
                                                            width: 1),
                                                      ),
                                                      backgroundColor:
                                                          ColorManager.white,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              margin: EdgeInsets.zero,
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: ColorManager.lightPink),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 32.h,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomeCTAButton(
                                              haveBorder: true,
                                              textColor: ColorManager.secondColor,
                                              trigger: false,
                                              primary: ColorManager.parent,
                                              onPressed: () {
                                                // value.rangeValues.
                                                // sl<NavigationService>()
                                                //     .navigateTo(
                                                //         createNewPassword);
                                              },
                                              title: "ClearAll",
                                              fontSized: 12.sp,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Expanded(
                                            child: CustomeCTAButton(
                                              ProgressColor: ColorManager.white,
                                              colorBorder:
                                                  ColorManager.secondColor,
                                              haveBorder: true,
                                              textColor: ColorManager.white,
                                              trigger: false,
                                              primary: ColorManager.secondColor,
                                              onPressed: () {
                                                value. filterCars();
                                                // value.editProfile();
                                              },
                                              title: "ApplyFilter",
                                              fontSized: 12.sp,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            trigger: false,
                            haveWidget: false,
                            widget: CustomSvgAssets(
                              color: ColorManager.white,
                              path: IconAssets.filter,
                            ),
                            title: "",
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: value.searchList.isEmpty
                          ? Text(
                              "Recently".tr(),
                              style: Theme.of(context).textTheme.bodyText1,
                            )
                          : SizedBox(),
                    ),
                    StreamBuilder<List<Sub>>(
                      // StreamBuilder<QuerySnapshot> in your code.
                      initialData: value.searchListInitial, // you won't need this. (dummy data).
                      // stream: Your querysnapshot stream.
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Sub>> snapshot) {
                        return StreamBuilder<List<Sub>>(
                          key: ValueKey(snapshot.data),
                          initialData: snapshot.data,
                          stream: value.stream,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Sub>> snapshot) {
                            print(snapshot.data);
                            return value.isInFavourite == true &&
                                    value.searchList.length == 0
                                ? SingleChildScrollView(
                                    child: SkeletonMobileCardList(
                                      itemCount: 10,
                                    ),
                                  )
                                : value.searchList.length > 0
                                    ? SingleChildScrollView(
                                        child: GridView.builder(
                                            shrinkWrap: true,
                                            itemCount: value.searchList.isNotEmpty
                                                ? value.searchList.length
                                                : 6,
                                            physics: BouncingScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    childAspectRatio: 0.6,
                                                    crossAxisCount: 2),
                                            itemBuilder: (_, index) =>
                                                CustomMobileCard(
                                                    onTapDetails: () {
                                                      value.getProductDetails(
                                                          id: value
                                                              .searchList[index].id);
                                                      sl<NavigationService>()
                                                          .navigateTo(
                                                              productDetilas,args: [value.searchList[index].id]);
                                                    },
                                                    onTap: () {
                                                      if (sl<CartProvider>()
                                                          .isRedundentClick(
                                                              DateTime.now())) {
                                                        value.toggleFav(
                                                          isFav: value
                                                              .searchList[index]
                                                              .inFavorites,
                                                          // x: index,
                                                          id: value
                                                              .searchList[index].id,
                                                        );
                                                        print(
                                                            'hold on, processing');
                                                        return;
                                                      }
                                                      print('run process');
                                                    },
                                                    inFavorites: value.searchList[index].inFavorites,
                                                    images: value
                                                        .searchList[index].image,
                                                    discount: value
                                                        .searchList[index].discount,
                                                    name: value
                                                        .searchList[index].name,
                                                    price: value
                                                        .searchList[index].price)),
                                      )
                                    : Center(
                                        child: Text("NoData".tr()),
                                      );
                            //   ListView.builder(
                            //   shrinkWrap: true,
                            //   itemCount: snapshot.data!.length,
                            //   itemBuilder: (BuildContext context, int index) {
                            //     return Text(snapshot.data![index].name!);
                            //   },
                            // );
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
