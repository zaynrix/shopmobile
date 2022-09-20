// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/resources/assets_manager.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/resources/font_manager.dart';
import 'package:shopmobile/ui/features/cart/cartProvider.dart';
import 'package:shopmobile/ui/features/cart/cartScreen.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeSvg.dart';
import 'package:provider/provider.dart';

class CustomCart extends StatelessWidget {
  int index;

  CustomCart({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<CartProvider>(context).cartList[index];
    var actions = Provider.of<CartProvider>(context, listen: true);
    return Dismissible(
      direction: DismissDirection.startToEnd,

      background: const SlideRightBackground(),
      // secondaryBackground: const SlideLeftBackground(),
      key: UniqueKey(),
      confirmDismiss: (direction) async {
        print(direction.name);
        if (direction == DismissDirection.startToEnd) {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Are you sure you want to delete".tr(),
                        style: Theme.of(context).textTheme.headline3!
                     ),
                    TextSpan(
                        text: " ${data.product!.name} ?",
                        style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeightManager.semiBold)),
                  ]),
                ),
                // RichText(
                //   text: InlineSpan[
                //
                //   ],
                //   children: [
                //     Expanded(child: Text("Are you sure you want to delete".tr(),overflow: TextOverflow.visible,)),
                //     Expanded(child: Text("${data.product!.name}")),
                //   ],
                // ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      "Cancel".tr(),
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton(
                    child: Text(
                      "Delete".tr(),
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      actions.deleteCartProvider(
                          cartId: data.id, itemIndex: index);
                      print("Delete :");
                    },
                  ),
                ],
              );
            },
          );
          // return res;
        } else {
          print("Edit :");
        }
        return null;
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        height: 100.h,
        child: Row(
          children: [
            Container(
              height: 100.h,
              width: 100.w,
              decoration: BoxDecoration(
                  color: ColorManager.lightPink,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: SizedBox(
                child: Padding(
                  padding: EdgeInsets.all(14.0.w),
                  child: CachedNetworkImage(
                    height: 110.h,
                    width: 110.w,
                    fit: BoxFit.contain,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    imageUrl: "${data.product!.image}",
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text("${data.product!.name}",
                              style: Theme.of(context).textTheme.headline3!),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Text(
                        "${data.product!.description}",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: ColorManager.lightGrey),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${data.product!.price} AED",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeightManager.semiBold,
                                    color: ColorManager.primaryGreen,
                                  ),
                        ),
                        Container(
                          width: 100.w,
                          height: 25.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (actions
                                      .isRedundentClick(DateTime.now())) {
                                    actions.decrement(
                                        itemIndex: index, cartId: data.id);
                                    print('hold on, processing');
                                    return;
                                  }
                                  print('run process');
                                },
                                child: CustomSvgAssets(
                                  path: IconAssets.minus,
                                  color: ColorManager.white,
                                ),
                              ),
                              Text(
                                "${data.quantity}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontWeight: FontWeightManager.semiBold,
                                      color: ColorManager.white,
                                    ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (actions
                                      .isRedundentClick(DateTime.now())) {
                                    actions.increment(
                                        itemIndex: index, cartId: data.id);
                                    print('hold on, processing');
                                    return;
                                  }
                                  print('run process');
                                },
                                child: CustomSvgAssets(
                                  path: IconAssets.plus,
                                  color: ColorManager.white,
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: ColorManager.primaryGreen,
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.r),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
