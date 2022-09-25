import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/resources/assets_manager.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/resources/font_manager.dart';
import 'package:shopmobile/routing/navigation.dart';
import 'package:shopmobile/routing/routes.dart';
import 'package:shopmobile/ui/features/Profile/profileProvider.dart';
import 'package:shopmobile/ui/shared/widgets/CustomAppBar.dart';
import 'package:shopmobile/ui/shared/widgets/CustomCTAButton.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeRoundedTextFiled.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeSvg.dart';
import 'package:shopmobile/utils/validator.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen() {
    sl<ProfileProvider>().getAddressProvider();
    sl<ProfileProvider>().getLocationAttitude();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, value, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: CustomeCTAButton(
            trigger: false,
            primary: ColorManager.secondColor,
            onPressed: () {
              sl<NavigationService>().navigateTo(paymentMethodScreen);
              // Login Function
              // value.loginProvider();
            },
            title: "Continuetopayment",
          ),
        ),
        backgroundColor: ColorManager.backgroundColor,
        appBar: CustomAppBar(
          backgroundColor: ColorManager.backgroundColor,
          title: "ShippingAddress",
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: ListView.separated(
              separatorBuilder: (context, indexS) => Divider(
                    color: ColorManager.parent,
                  ),
              itemCount: value.address.length + 1,
              itemBuilder: (context, index) {
                if (index == value.address.length) {
                  return InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        // isDismissible: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: ColorManager.backgroundColor,
                        context: context,
                        builder: (context) => ListView(
                          shrinkWrap: true,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),

                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Center(
                                        child: Text(
                                          "NewAddress".tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(
                                                  color: ColorManager.black,
                                                  fontWeight:
                                                      FontWeightManager.regular),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      CustomTextFiled(
                                        hintText: 'AddressName'.tr(),
                                        keyboardType: TextInputType.emailAddress,
                                        focuse: (_) =>
                                            FocusScope.of(context).nextFocus(),
                                        textInputAction: TextInputAction.next,
                                        onChanged: (val) {
                                          value.addressName.text = val!;
                                        },
                                        validator: (value) =>
                                            Validator.valueExists(value ?? ""),
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      CustomTextFiled(
                                        hintText: 'City'.tr(),
                                        keyboardType: TextInputType.emailAddress,
                                        focuse: (_) =>
                                            FocusScope.of(context).nextFocus(),
                                        textInputAction: TextInputAction.next,
                                        onChanged: (val) {
                                          value.addressCity.text = val!;
                                        },
                                        validator: (value) =>
                                            Validator.valueExists(value ?? ""),
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      CustomTextFiled(
                                        hintText: 'Region'.tr(),
                                        keyboardType: TextInputType.emailAddress,
                                        focuse: (_) =>
                                            FocusScope.of(context).nextFocus(),
                                        textInputAction: TextInputAction.next,
                                        onChanged: (val) {
                                          value.addressRegion.text = val!;
                                        },
                                        validator: (value) =>
                                            Validator.valueExists(value ?? ""),
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      CustomTextFiled(
                                        hintText: 'details'.tr(),
                                        keyboardType: TextInputType.emailAddress,
                                        focuse: (_) =>
                                            FocusScope.of(context).nextFocus(),
                                        textInputAction: TextInputAction.next,
                                        onChanged: (val) {
                                          value.addressDetails.text = val!;
                                        },
                                        validator: (value) =>
                                            Validator.valueExists(value ?? ""),
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      CustomTextFiled(
                                        hintText: 'notes'.tr(),
                                        keyboardType: TextInputType.emailAddress,
                                        focuse: (_) =>
                                            FocusScope.of(context).nextFocus(),
                                        textInputAction: TextInputAction.next,
                                        onChanged: (val) {
                                          value.addressNotes.text = val!;
                                        },
                                        validator: (value) =>
                                            Validator.valueExists(value ?? ""),
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      CustomeCTAButton(
                                        ProgressColor: ColorManager.white,
                                        colorBorder: ColorManager.secondColor,
                                        haveBorder: false,
                                        textColor: ColorManager.white,
                                        trigger: value.loading,
                                        primary: ColorManager.primaryGreen,
                                        onPressed: () {
                                          value.addAddressProvider();
                                          // value. filterCars();
                                          // value.editProfile();
                                        },
                                        title: "AddAddress",
                                        fontSized: 17.sp,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsetsDirectional.only(bottom: 100.h),
                      elevation: 0,
                      child: Column(
                        children: [
                          ListTile(
                            trailing: Icon(
                              Icons.refresh,
                              color: ColorManager.lightGrey,
                            ),
                            leading: Container(
                              child: CustomSvgAssets(
                                path: IconAssets.locationFill,
                              ),
                              decoration: BoxDecoration(
                                color: ColorManager.backgroundColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7.r),
                                ),
                              ),
                            ),
                            title: Text("TitleAddress".tr(),
                                style: Theme.of(context).textTheme.bodyText1!),
                            subtitle: Text("Addtheshippingaddress".tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: ColorManager.lightGrey)),
                          ),
                          Divider(
                            color: ColorManager.lightGrey.withOpacity(0.5),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
                            child: DottedBorder(
                              padding: EdgeInsets.all(16),
                              strokeWidth: 1,
                              borderType: BorderType.RRect,
                              dashPattern: [2.2],
                              color: ColorManager.lightGrey,
                              radius: Radius.circular(7.r),
                              child: Container(
                                child: Center(
                                    child: Icon(
                                  Icons.add,
                                  color: ColorManager.lightGrey,
                                )),
                                // child:
                                decoration: BoxDecoration(
                                  color: ColorManager.parent,
                                  // image: DecorationImage(
                                  //   fit: BoxFit.cover,
                                  //   image: AssetImage(ImageAssets.mapImage),
                                  // ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(7.r),
                                  ),
                                  // color: ColorManager.lightGrey
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Card(
                    elevation: 0,
                    child: Column(
                      children: [
                        RadioListTile(
                          toggleable: false,
                          value: index,
                          onChanged: (val) {
                            value.changeRadio(val);
                          },
                          controlAffinity: ListTileControlAffinity.trailing,
                          groupValue: value.val,
                          secondary: Container(
                            child: CustomSvgAssets(
                              path: IconAssets.locationFill,
                            ),
                            decoration: BoxDecoration(
                              color: ColorManager.backgroundColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(7.r),
                              ),
                            ),
                          ),
                          title: Text("${value.address[index].name}",
                              style: Theme.of(context).textTheme.bodyText1!),
                          subtitle: Text(
                              "${value.address[index].city},${value.address[index].details}",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: ColorManager.lightGrey)),
                        ),
                        Divider(
                          color: ColorManager.lightGrey.withOpacity(0.5),
                        ),
                        AspectRatio(
                          aspectRatio: 295 / 98,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
                            child: Container(
                              child: CustomSvgAssets(
                                path: IconAssets.locationFill,
                                color: ColorManager.primaryGreen,
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(ImageAssets.mapImage)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7.r),
                                ),
                                // color: ColorManager.lightGrey
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
