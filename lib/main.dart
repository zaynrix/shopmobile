// ignore_for_file: deprecated_member_use

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
import 'package:shopmobile/ui/features/chat/app.dart';
import 'package:shopmobile/ui/features/home/homeProvider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() async {

  var client = StreamChatClient(apiKey);

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
        child: MyApp(
          streamChatClient: client,
        ),
      ),
    ),
  );
}


///TODO: Fix chat installation :)
class MyApp extends StatelessWidget {
  MyApp({required this.streamChatClient});
  StreamChatClient streamChatClient;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          builder: (context, child) {
            return StreamChat(
                client: streamChatClient,
                child: ChannelsBloc(child: UsersBloc(child: child!)));
          },
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
