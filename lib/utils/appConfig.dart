import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopmobile/data/local_repo.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/routing/routes.dart';
import 'package:shopmobile/utils/storage.dart';
import 'package:path_provider/path_provider.dart';
import '../routing/navigation.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as ch;

class AppConfig extends ChangeNotifier {
  Future<Timer> loadData() async {
    return Timer(const Duration(seconds: 3), onDoneLoading);
  }


  int? checkInt(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  Future<void> deleteCacheDir() async {
    Directory tempDir = await getTemporaryDirectory();

    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  }

  Future<void> deleteAppDir() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();

    if (appDocDir.existsSync()) {
      appDocDir.deleteSync(recursive: true);
    }
  }

  // final controller = PageController(viewportFraction: 0.8, keepPage: true);
  // List<Sub> searchList = [];


  onDoneLoading() async {
    final cleint = ch.StreamChatCore.of(
        sl<NavigationService>().navigatorKey.currentContext!)
        .client;

    var token = await sl<Storage>()
        .secureStorage
        .read(key: SharedPrefsConstant.TOKEN);
    var shared = sl<SharedLocal>();

    // bool _seen = sl<SharedLocal>().firstIntro;

    if (shared.firstIntro) {
      print("This is Token $token");
      if (token != null) {
        await cleint.connectUser(
          ch.User(
            id: shared.getUser()!.id.toString(),
            extraData: {
              'name': shared.getUser()!.name,
              'image': shared.getUser()!.image,
            },
          ),
          cleint.devToken("${shared.getUser()!.id}").rawValue,
        );
        sl<NavigationService>().navigateToAndRemove(home);
      } else {
        sl<NavigationService>().navigateToAndRemove(login);
      }
    } else {
      sl<SharedLocal>().firstIntro = true;
      sl<NavigationService>().navigateToAndRemove(intro);
    }

    // var data = sl<LocalRepo>().getUser();
    // sl<NavigationService>().navigateToAndRemove(intro);
    // SchedulerBinding.instance!.addPostFrameCallback((_) {
    //   data != null
    //       ? sl<NavigationService>().navigateToAndRemove(home)
    //       : sl<NavigationService>().navigateToAndRemove(login);
    // });
  }

  TextTheme getTextContext(BuildContext context) {
    return Theme
        .of(context)
        .textTheme;
  }

  static showSnakBar(String content) {
    return sl<NavigationService>()
        .snackbarKey
        .currentState
        ?.showSnackBar(SnackBar(content: Text(content.tr())));
  }


}
