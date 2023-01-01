import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shopmobile/data/auth_repo.dart';
import 'package:shopmobile/data/local_repo.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/models/logoutModel.dart';
import 'package:shopmobile/models/user.dart';
import 'package:shopmobile/routing/navigation.dart';
import 'package:shopmobile/routing/routes.dart';
import 'package:shopmobile/ui/features/Profile/profileProvider.dart';
import 'package:shopmobile/utils/appConfig.dart';
import 'package:shopmobile/utils/storage.dart';

class AuthProvider extends ChangeNotifier {
  //Login / Signup Controller
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //Signup Controller
  TextEditingController fullname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

//
  TextEditingController pinController = TextEditingController();
  TextEditingController phoneVerficationController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool loading = false;
  bool rememberMe = true;
  bool isObscure = true;
  bool hasError = false;

  String currentText = "";
  List<String> locations = ['059', '056']; // Option 2
  late String selectedLocation = locations[0]; // Option 2

  void remmberMe(bool value) {
    rememberMe = value;
    notifyListeners();
  }

  void visibility() {
    isObscure = !isObscure;
    notifyListeners();
  }

  void selectNumber(selected) {
    selectedLocation = selected;
    notifyListeners();
  }

  Future<void> loginProvider() async {
    if (formKey.currentState!.validate()) {
      // Start Loading
      loading = true;
      notifyListeners();
      // loginRepo => Login Request
      LoginResponse res = await sl<HttpAuth>().loginRepo(
          email: emailController.text, password: passwordController.text);
      //("This is $res");

      if (res.status == true && res.user != null) {

        // Stop Loading
        loading = false;
        notifyListeners();

        // Save User Information
        sl<SharedLocal>().setUser(res.user!);

        // Save Token
        sl<Storage>()
            .secureStorage
            .write(key: SharedPrefsConstant.TOKEN, value: res.user!.token);

        // Show snakBar
        AppConfig.showSnakBar("Logged");

        sl<NavigationService>().navigateToAndRemove(home);
      } else {
        // Stop Loading
        loading = false;
        notifyListeners();
        AppConfig.showSnakBar("${res.message}");
      }
    }
  }

  Future<void> SignupProvider() async {
    //(fullname.text);
    User user = User.SignUp(
        name: fullname.text,
        introPhone: selectedLocation,
        phone: phone.text,
        email: emailController.text,
        password: passwordController.text);
    if (formKey.currentState!.validate()) {
      loading = true;
      notifyListeners();
      LoginResponse res = await sl<HttpAuth>().SignupRepo(user: user);

      if (res.status == true) {
        loading = false;
        notifyListeners();

        AppConfig.showSnakBar("${res.message??"Account was created Successfully!!"}");
        sl<NavigationService>().navigateToAndRemove(login);
      } else {
        loading = false;
        notifyListeners();
        AppConfig.showSnakBar("${res.message??"Something Wrong, Try again"}");
      }
    }
  }
//0599023189
  Future<void> otpProvider() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      notifyListeners();
      var tempo = sl<SharedLocal>().getSignUpTempo();
      // //(!tempo!.contains("@"));
      LoginResponse res = tempo!.contains("@")
          ? await sl<HttpAuth>()
              .confirmCodeRepo(email: tempo, otp: pinController.text)
          : await sl<HttpAuth>().sendOTP(phone: tempo, otp: pinController.text);

      if (res.status == true) {
        loading = false;
        notifyListeners();
        AppConfig.showSnakBar("${res.message}");
        if (!tempo.contains("@")) {
          sl<SharedLocal>().setUser(res.user!);
          sl<Storage>()
              .secureStorage
              .write(key: SharedPrefsConstant.TOKEN, value: res.user!.token);
          sl<NavigationService>().navigateToAndRemove(home);
        } else {
          sl<NavigationService>().navigateToAndRemove(createNewPassword);
        }
      } else if (res.status != true) {
        loading = false;
        notifyListeners();
        AppConfig.showSnakBar(res.message!);
      } else {
        loading = false;
        notifyListeners();
        AppConfig.showSnakBar("Username or Password invalid");
      }
    }
  }

  Future<void> reSendProvider() async {
    var tempo = await sl<SharedLocal>().getSignUpTempo();
    LoginResponse res = await sl<HttpAuth>().reSendOTP(phone: tempo);

    if (res.status == true) {
      AppConfig.showSnakBar("${res.message}");
      pinController.clear();
      notifyListeners();
    } else if (res.status != true) {
      AppConfig.showSnakBar(res.message!);
    } else {
      AppConfig.showSnakBar("Somthing Wrong try later");
    }
  }

  Future<void> forgetProvider() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      notifyListeners();

      LoginResponse res =
          await sl<HttpAuth>().forgetRepo(email: emailController.text);
      //("This is $res");

      if (res.status == true) {
        loading = false;
        notifyListeners();

        sl<SharedLocal>().setSignUpTempo("${emailController.text}");
        AppConfig.showSnakBar("${res.message}");
        sl<NavigationService>().navigateToAndRemove(otp);
      } else if (res.status != true) {
        loading = false; //1234
        notifyListeners();
        AppConfig.showSnakBar(res.message!);
      } else {
        loading = false;
        notifyListeners();
        AppConfig.showSnakBar("Something Wrong, Try again");
      }
    }
  }

  Future<void> logoutProvider() async {
    LogoutModel res = await sl<HttpAuth>().logout();

    // //("This is $res");
    //yahya123456@gmail.com 123456    6
    //yahya12345612@gmail.com phone-> 1222222  pas -> yahya12345612     5
    //yahya12345612 123456

    if (res.status == true) {
      sl<Storage>().secureStorage.delete(key: SharedPrefsConstant.TOKEN);
      // sl<NavigationService>().navigateToAndRemove(login);
      // sl<NavigationService>().navigateToAndRemoveFinal();

      SchedulerBinding.instance?.addPostFrameCallback((_) async {
        Navigator.of(sl<NavigationService>().navigatorKey.currentContext!).pushNamedAndRemoveUntil(
            login,
                (Route<dynamic> route) => false);
      });

      sl<ProfileProvider>().clearUserData();

      AppConfig.showSnakBar("${res.message}");
    } else {
      AppConfig.showSnakBar("Something Wrong ");
    }
  }
}
// }
