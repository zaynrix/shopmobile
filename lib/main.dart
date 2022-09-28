import 'package:flutter_offline/flutter_offline.dart';
import 'package:shopmobile/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopmobile/routing/router.dart';
import 'package:shopmobile/routing/routes.dart';
import 'package:shopmobile/routing/navigation.dart';
import 'package:shopmobile/resources/theme_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/ui/features/home/homeProvider.dart';

void main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, statusBarBrightness: Brightness.dark),
  );
  runApp(
    ChangeNotifierProvider<HomeProvider>(
      create: (context) => HomeProvider(),
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        path: 'assets/translations',
        startLocale: Locale("en"),
        fallbackLocale: const Locale("en"),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          scaffoldMessengerKey: sl<NavigationService>().snackbarKey,
          debugShowCheckedModeBanner: false,
          title: 'Mobile Shop',
          theme: getApplicationTheme(),
          navigatorKey: sl<NavigationService>().navigatorKey,
          initialRoute: splash,
          onGenerateRoute: RouterX.generateRoute,
        );
      },
    );
  }
}
