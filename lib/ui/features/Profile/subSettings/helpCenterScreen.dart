import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/ui/features/Profile/profileProvider.dart';
import 'package:shopmobile/ui/shared/widgets/CustomAppBar.dart';

class HelpCenterScreen extends StatelessWidget {
  final data = sl<ProfileProvider>();

  HelpCenterScreen() {
    data.getFAQProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      appBar: CustomAppBar(
        backgroundColor: ColorManager.backgroundColor,
        title: "",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Frequently Asked".tr(),
                overflow: TextOverflow.visible,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15.h,
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) => Divider(),
                itemCount: data.faq.length,
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0.r),
                    ),
                  ),
                  child: Card(
                    elevation: 0,
                    child: ExpansionTile(
                      textColor: ColorManager.primaryGreen,
                      iconColor: ColorManager.primaryGreen,
                      title: Text("${data.faq[index].question}",
                          style: Theme.of(context).textTheme.bodyText1!,
                          overflow: TextOverflow.visible),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${data.faq[index].answer}",
                              overflow: TextOverflow.visible),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
