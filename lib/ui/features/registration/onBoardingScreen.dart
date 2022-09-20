import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/resources/assets_manager.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/routing/navigation.dart';
import 'package:shopmobile/routing/routes.dart';

class Introduction extends StatelessWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("This is  statless");
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            image:
                SvgPicture.asset(ImageAssets.onBoarding1, fit: BoxFit.fitWidth),
            titleWidget: Text(
              'Get the Best Smartphone',
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            bodyWidget: Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting..',
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.center,
            ),
          ),
          PageViewModel(
            titleWidget: Text(
              'Great experince with our product',
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            image:
                SvgPicture.asset(ImageAssets.onBoarding2, fit: BoxFit.fitWidth),
            bodyWidget: Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting..',
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.center,
            ),
          ),
          PageViewModel(
            titleWidget: Text(
              'Get product from at home',
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            image:
                SvgPicture.asset(ImageAssets.onBoarding3, fit: BoxFit.fitWidth),
            bodyWidget: Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting..',
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.center,
            ),
          ),
        ],

        onDone: () {
          print("Done");
        },
        nextStyle: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(color: Colors.red)))),
        showBackButton: false,
        showSkipButton: false,
        controlsMargin: const EdgeInsets.symmetric(vertical: 20),
        skip: const Icon(Icons.skip_next),
        next: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          radius: 22.r,
          child: SvgPicture.asset(
            IconAssets.arrowRight,
            color: Colors.white,
          ),
        ),
        // done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        done: ElevatedButton(
          onPressed: () {
            sl<NavigationService>().navigateToAndRemove(login);
          },
          child: const FittedBox(child: Text("Get Started")),
        ),
        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            activeSize: const Size(10.0, 10.0),
            activeColor: Theme.of(context).primaryColor,
            color: ColorManager.lightPink,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
      ),
    );
  }
}
