import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/resources/assets_manager.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/resources/font_manager.dart';
import 'package:shopmobile/routing/navigation.dart';
import 'package:shopmobile/routing/routes.dart';
import 'package:shopmobile/ui/features/category/categoryProvider.dart';
import 'package:shopmobile/ui/shared/widgets/CustomAppBar.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen() {
   sl<CategoryProvider>().getCategoriesProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor2,
      appBar: CustomAppBar(
        backgroundColor: ColorManager.backgroundColor2,
        title: "Category",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: Consumer<CategoryProvider>(
          builder: (context, value, child) =>
              value.category.isNotEmpty ? SingleChildScrollView(
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: value.category.length,
                        // value.products.isNotEmpty
                        //     ? value.products.length
                        //     : 6,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 15.00,
                            crossAxisSpacing: 15.00,
                            childAspectRatio: 0.8611,
                            crossAxisCount: 2),
                        itemBuilder: (_, index) =>
                            GestureDetector(
                              onTap: () {
                                value.getSubCategoriesProvider(
                                    id: value.category[index].id);
                                sl<NavigationService>().navigateTo(
                                    subCategoryScreen);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.00)),
                                elevation: 0,
                                // margin: EdgeInsets.all(6),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CachedNetworkImage(
                                      height: 110.h,
                                      width: 110.w,
                                      fit: BoxFit.contain,
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                              ImageAssets.splashLogoPng),
                                      placeholder: (context, url) =>
                                          Image.asset(
                                              ImageAssets.splashLogoPng),
                                      imageUrl: "${value.category[index]
                                          .image}",
                                    ),
                                    Text("${value.category[index].name}",
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .headline4!
                                            .copyWith(
                                            fontWeight: FontWeightManager
                                                .regular)),
                                  ],
                                ),
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
              ): Center(child: CircularProgressIndicator(
                color: ColorManager.primaryGreen,
              ))
        ),
      ),
    );
  }
}
