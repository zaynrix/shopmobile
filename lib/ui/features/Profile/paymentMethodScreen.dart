import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/models/paymentMethodModel.dart';
import 'package:shopmobile/resources/assets_manager.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/ui/features/Profile/profileProvider.dart';
import 'package:shopmobile/ui/shared/widgets/CustomAppBar.dart';
import 'package:shopmobile/ui/shared/widgets/CustomCTAButton.dart';
import 'package:provider/provider.dart';
import '../../shared/widgets/CustomeSvg.dart';

class PaymentMethodScreen extends StatelessWidget {
   PaymentMethodScreen() {
     sl<ProfileProvider>().getAddressProvider();
   }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, value, child) => Scaffold(
        key: value.productDetailsScaffoldKey,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: CustomeCTAButton(
            trigger: false,
            primary: ColorManager.secondColor,
            onPressed: () {
              value.checkSelected();
            },
            title: "Confirm",
          ),
        ),
        backgroundColor: ColorManager.backgroundColor2,
        appBar: CustomAppBar(
          backgroundColor: ColorManager.backgroundColor2,
          title: "PaymentMethod",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Payment".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: PaymentMethod.paymentMethods.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index) => Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.00)),
                    elevation: 0,
                    child: Column(
                      children: [
                        RadioListTile(
                          toggleable: false,
                          value: PaymentMethod.paymentMethods[index].id!,
                          onChanged: (val) {
                            value.changeRadio(val);
                          },
                          controlAffinity: ListTileControlAffinity.trailing,
                          groupValue: value.val,
                          secondary: Container(
                            child: CustomSvgAssets(
                              path: PaymentMethod.paymentMethods[index].path,
                            ),
                          ),
                          title: Text(
                              "${PaymentMethod.paymentMethods[index].title}",
                              style: Theme.of(context).textTheme.bodyText1!),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Address".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                GestureDetector(
                  onTap: () {
                    value.AddressSheet();
                    value.getAddressProvider();
                  },
                  child: Card(
                    elevation: 0,
                    child: ListTile(
                      trailing: Icon(Icons.add),
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
                      title: Text(
                          value.changed != true
                              ? "TitleAddress".tr()
                              : "${value.address[value.addressValue].name}",
                          style: Theme.of(context).textTheme.bodyText1!),
                      subtitle: Text(
                          value.changed != true
                              ? "Addtheshippingaddress".tr()
                              : "${value.address[value.addressValue].city},${value.address[value.addressValue].details}",
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: ColorManager.lightGrey)),
                    ),
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
