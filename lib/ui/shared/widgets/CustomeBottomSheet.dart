import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/data/local_repo.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/models/languageModel.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/resources/font_manager.dart';
import 'package:shopmobile/routing/navigation.dart';
import 'package:shopmobile/ui/features/Profile/profileProvider.dart';
import 'package:shopmobile/ui/shared/widgets/CustomCTAButton.dart';

class BottomSheetLanguage extends StatefulWidget {
  @override
  _BottomSheetLanguageState createState() => _BottomSheetLanguageState();
}

class _BottomSheetLanguageState extends State<BottomSheetLanguage> {
  final data = sl<ProfileProvider>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Row(
              children: [
                Text(
                  "Language".tr(),
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: ColorManager.black,
                      fontWeight: FontWeightManager.semiBold),
                )
              ],
            ),
            SizedBox(
              height: 32.h,
            ),
            ListView.separated(
              shrinkWrap: true,
              itemCount: Language.languageList.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0.r),
                  ),
                ),
                child: Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    child: RadioListTile(
                      toggleable: false,
                      value: index,
                      onChanged: (dynamic value) {
                        sl<SharedLocal>().setLanguage =
                            Language.languageList[index].languageCode;
                        context.setLocale(Locale(
                            '${Language.languageList[index].languageCode}'));

                        print(context.locale.toString());
                        setState(() {
                          data.changeRadio2(value);
                          sl<SharedLocal>().setLanguageIndex = data.languageval;

                          data.languageval = value;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      groupValue: sl<SharedLocal>().getIndexLang,
                      title: Text(
                        "${Language.languageList[index].name}",
                        style: Theme.of(context).textTheme.bodyText1!,
                      ),
                    ),
                  ),
                  margin: EdgeInsets.zero,
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
          ],
        ),
      ),
    );
  }
}

class BottomSheetAddress extends StatefulWidget {
  @override
  _BottomSheetAddressState createState() => _BottomSheetAddressState();
}

class _BottomSheetAddressState extends State<BottomSheetAddress> {
  final data = sl<ProfileProvider>();

  @override
  void initState() {
    data.getAddressProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,

      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        "Address".tr(),
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: ColorManager.black,
                            fontWeight: FontWeightManager.semiBold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  data.address.length == 0

                      ? Text("No Address")
                      : ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.address.length,
                          separatorBuilder: (context, index) => Divider(),
                          itemBuilder: (context, index) => Container(
                            decoration: BoxDecoration(
                              color: ColorManager.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0.r),
                              ),
                            ),
                            child: Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 4),
                                child: RadioListTile(
                                  toggleable: false,
                                  value: index,
                                  onChanged: (dynamic value) {
                                    setState(() {
                                      data.changeAddressValue(value);
                                      data.addressValue = value;
                                    });
                                  },
                                  controlAffinity: ListTileControlAffinity.leading,
                                  groupValue: data.addressValue,
                                  title: Text(
                                    "${data.address[index].name}",
                                    style: Theme.of(context).textTheme.bodyText1!,
                                  ),
                                ),
                              ),
                              margin: EdgeInsets.zero,
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomeCTAButton(
                    trigger: false,
                    primary: ColorManager.secondColor,
                    onPressed: () {
                      sl<NavigationService>().pop();
                    },
                    title: "Save",
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
