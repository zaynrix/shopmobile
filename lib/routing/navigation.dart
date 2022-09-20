import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<ScaffoldMessengerState> snackbarKey =
  GlobalKey<ScaffoldMessengerState>();
  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final GlobalKey<NavigatorState> navigatorKey =
  new GlobalKey<NavigatorState>();

  navigateTo(String routeName, {Object? args}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: args,);
  }
//123123123
  navigateToAndRemove(String routeName) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
          (Route<dynamic> route) => false,
    );
  }

  pop(){
    navigatorKey.currentState!.pop();
  }
}