import 'package:flutter/material.dart';
import 'package:shopmobile/resources/color_manager.dart';

class CustomeDiscount extends StatelessWidget {
  final int? discount;
  final double radius;

  CustomeDiscount({this.discount, Key? key,this.radius=4}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 8),
        child: Text(
          "-$discount%",
          style: Theme
              .of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: ColorManager.white),
        ),
      ),
      decoration: BoxDecoration(
        color: ColorManager.red,
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
      ),
    );
  }
}
