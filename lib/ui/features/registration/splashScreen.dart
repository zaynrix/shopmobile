import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/resources/assets_manager.dart';
import 'package:shopmobile/utils/appConfig.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    sl<AppConfig>().loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(ImageAssets.splashLogoSvg),
            // const CircularProgressIndicator(
            //   valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            // ),
          ],
        ),
      ),
    );
  }
}
