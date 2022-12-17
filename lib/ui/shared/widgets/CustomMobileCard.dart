// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/data/local_repo.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/resources/assets_manager.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/resources/font_manager.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeDiscount.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeSvg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shopmobile/utils/appConfig.dart';

class CustomMobileCard extends StatelessWidget {
  String? name;
  void Function()? onTapDetails;
  String? description;
  int? discount;
  num? price;
  num? oldPrice;
  bool? inFavorites;
  bool? inCart;
  bool? check;
  String? images;
  void Function()? onTap;

  CustomMobileCard(
      {Key? key,
      this.check,
      this.onTapDetails,
      this.name,
      this.description,
      this.discount,
      this.images,
      this.inCart,
      this.inFavorites = true,
      this.oldPrice,
      this.price,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapDetails,
      child: Card(
        margin: EdgeInsets.all(6),
        child: Padding(
          padding: EdgeInsets.all(10.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  discount != 0
                      ? CustomeDiscount(
                          discount: discount,
                        )
                      : SizedBox(),
                  CustomeFavourite(onTap: onTap, inFavorites: inFavorites)
                ],
              ),
              CachedNetworkImage(
                height: 110.h,
                width: 110.w,
                fit: BoxFit.contain,
                errorWidget: (context, url, error) =>
                    Image.asset(ImageAssets.splashLogoPng),
                placeholder: (context, url) =>
                    Image.asset(ImageAssets.splashLogoPng),
                imageUrl: "$images",
              ),
              Text("$name",
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontWeight: FontWeightManager.semiBold)),
              SizedBox(
                height: 8.h,
              ),
              Text("$price AED",
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      color: ColorManager.primaryGreen,
                      fontWeight: FontWeightManager.semiBold)),
              SizedBox(
                height: 8.h,
              ),
              Center(child: CustomeRating()),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomeFavourite extends StatelessWidget {
  const CustomeFavourite({
    Key? key,
    required this.onTap,
    required this.inFavorites,
  }) : super(key: key);

  final void Function()? onTap;
  final bool? inFavorites;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap:       sl<SharedLocal>().getUser()!.token != ""
            ? onTap: (){
          AppConfig.showSnakBar("You Should login");
        },
        child: !inFavorites!
            ? CircleAvatar(
                backgroundColor: ColorManager.parent,
                child: CustomSvgAssets(path: IconAssets.hertOutlined),
              )
            : CircleAvatar(
                backgroundColor: ColorManager.primaryGreen,
                child: CustomSvgAssets(
                    color: ColorManager.white, path: IconAssets.hertOutlined),
              ));
  }
}

class CustomeRating extends StatelessWidget {
  MainAxisAlignment mainAxisAlignment;
   CustomeRating({
    this.mainAxisAlignment = MainAxisAlignment.center,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Container(
          height: 14.h,
          width: 14.w,
          child: CustomSvgAssets(
            path: IconAssets.StarFill,
            color: ColorManager.starYellow,
          ),
        ),
        Text(
          "4.5 (3k review)",
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}
