import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/resources/assets_manager.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/ui/features/Profile/profileProvider.dart';
import 'package:shopmobile/ui/features/cart/cartProvider.dart';
import 'package:shopmobile/ui/shared/widgets/CustomAppBar.dart';
import 'package:shopmobile/ui/shared/widgets/CustomCTAButton.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeRoundedTextFiled.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeSvg.dart';
import 'package:shopmobile/utils/validator.dart';
import 'package:provider/provider.dart';

class PaymentDetailsScreen extends StatelessWidget {
  const PaymentDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, value, child) => Scaffold(
        // key: value.productDetailsScaffoldKey,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: CustomeCTAButton(
            trigger: false,
            primary: ColorManager.primaryGreen,
            onPressed: () {
              value.voidConfirmMethod();
            },
            title: "Confirm",
          ),
        ),
        backgroundColor: ColorManager.backgroundColor,
        appBar: CustomAppBar(
          backgroundColor: ColorManager.backgroundColor,
          title: "Paymentdetails",
        ),
        body: SingleChildScrollView(
          child: Form(
            key: value.formKey,
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomSvgAssets(
                      path: IconAssets.card,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${value.holderName ?? ""}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: ColorManager.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "${value.cardNumber ?? ""}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: ColorManager.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                            sl<CartProvider>().cartTotal != 0?  "${sl<CartProvider>().cartTotal } AED":"",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: ColorManager.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Text(
                        "CardDetails".tr(),
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: CustomTextFiled(
                    inputFormatters: [
                      FilteringTextInputFormatter.singleLineFormatter,
                      LengthLimitingTextInputFormatter(22),
                      // CardNumberInputFormatter(),
                    ],
                    prefixIcon: CustomSvgAssets(
                      color: ColorManager.lightGrey,
                      path: IconAssets.profile,
                    ),
                    hintText: 'HolderName'.tr(),
                    focuse: (_) => FocusScope.of(context).nextFocus(),
                    textInputAction: TextInputAction.next,
                    onChanged: (val) {
                      value.holderController.text = val!;
                    },
                    validator: (value) => Validator.valueExists(value ?? ""),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: CustomTextFiled(
                    suffixIcon: CardUtils.getCardIcon(value.cardType),
                    prefixIcon: CustomSvgAssets(
                      color: ColorManager.lightGrey,
                      path: IconAssets.payment,
                    ),
                    hintText: 'CardNumber'.tr(),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                      CardNumberInputFormatter(),
                    ],
                    focuse: (_) => FocusScope.of(context).nextFocus(),
                    textInputAction: TextInputAction.next,
                    onChanged: (val) {
                      value.cardNumberController.text = val!;
                    },
                    validator: (value) => Validator.valueExists(value ?? ""),
                    // validator: (value) =>
                    //     Validator2.validateMasterCardNumber(value ?? ""),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextFiled(
                          prefixIcon: CustomSvgAssets(
                            color: ColorManager.lightGrey,
                            path: IconAssets.calender,
                          ),
                          hintText: 'MM/YY',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                            CardMonthInputFormatter(),
                          ],
                          focuse: (_) => FocusScope.of(context).nextFocus(),
                          textInputAction: TextInputAction.next,
                          onChanged: (val) {
                            value.mmyyController.text = val!;
                          },
                          validator: (value) =>
                              CardUtils.validateDate(value ?? ""),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: CustomTextFiled(
                          keyboardType: TextInputType.number,
                          prefixIcon: CustomSvgAssets(
                            color: ColorManager.lightGrey,
                            path: IconAssets.lock,
                          ),
                          hintText: 'CVV',
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            // Limit the input
                            LengthLimitingTextInputFormatter(4),
                          ],
                          focuse: (_) => FocusScope.of(context).nextFocus(),
                          textInputAction: TextInputAction.next,
                          onChanged: (val) {
                            value.cvvController.text = val!;
                          },
                          validator: (value) =>
                              CardUtils.validateCVV(value ?? ""),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: CustomTextFiled(
                    prefixIcon: CustomSvgAssets(
                      color: ColorManager.lightGrey,
                      path: IconAssets.tiketStar,
                    ),
                    hintText: 'coupon'.tr(),
                    focuse: (_) => FocusScope.of(context).nextFocus(),
                    textInputAction: TextInputAction.next,
                    onChanged: (val) {
                      value.promoCodeController.text = val!;
                    },
                    // validator: (value) =>
                    //     Validator2.validateMasterCardNumber(value ?? ""),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
