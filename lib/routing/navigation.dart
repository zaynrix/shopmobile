import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();

  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  navigateTo(String routeName, {Object? args}) {
    return navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: args,
    );
  }

  navigateToAndRemove(String routeName,{Object? arg}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arg
    );
  }

  pop() {
    return navigatorKey.currentState!.pop();
  }
}
