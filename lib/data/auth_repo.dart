import 'package:dio/dio.dart';
import 'package:shopmobile/data/apiConstant.dart';
import 'package:shopmobile/data/local_repo.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/models/logoutModel.dart';
import 'package:shopmobile/models/user.dart';
import 'package:shopmobile/utils/storage.dart';

class HttpAuth {
  final Dio client;

  HttpAuth({required this.client});


  // -------------------- Login Repository ----------------

  Future<LoginResponse> loginRepo({String? email, String? password}) async {
    Response response = await client.post(
      '${ApiConstant.authLogin}',
      data: {"email": email, "password": password},
    );

    LoginResponse users = LoginResponse.fromJson(response.data);
    return users;
  }


  // -------------------- Signup Repository ----------------

  Future<LoginResponse> SignupRepo({User? user}) async {
    print(user!.name);
    print("${user.introPhone}${user.phone}");
    Response response = await client.post(
      '${ApiConstant.authSignup}',
      data: {
        "email": "${user.email}",
        "phone": "${user.introPhone}${user.phone}",
        "name": "${user.name}",
        "password": "${user.password}",
      },
    );
print("www ${response.data}");
    LoginResponse users = LoginResponse.fromJson(response.data);
    return users;
  }


  // -------------------- OTP Code ----------------

  Future<LoginResponse> sendOTP({
    String? phone,
    String? otp,
  }) async {
    print("sendOTP");

    Response response = await client.put(
      '${ApiConstant.otpCode}',
      data: {
        "code": "$otp",
        "mobile": "$phone",
      },
    );

    LoginResponse users = LoginResponse.fromJson(response.data);
    return users;
  }


  // -------------------- Re-OTP Code ----------------

  Future<LoginResponse> reSendOTP({
    String? phone,
  }) async {
    Response response = await client.post(
      '${ApiConstant.resendCode}',
      data: {
        "mobile": "$phone",
      },
    );
    LoginResponse users = LoginResponse.fromJson(response.data);
    return users;
  }


  // -------------------- Forget Password ----------------

  Future<LoginResponse> forgetRepo({String? email}) async {
    Response response = await client
        .post('${ApiConstant.forgetPassword}', data: {"email": email});

    LoginResponse users = LoginResponse.fromJson(response.data);
    return users;
  }


  // -------------------- Confirm Code OTP ----------------

  Future<LoginResponse> confirmCodeRepo({String? email, String? otp}) async {
    print("Forget");
    Response response = await client.post(
      '${ApiConstant.confirmCodePassword}',
      data: {
        "code": "$otp", //1234
        "email": "$email",
      },
    );

    LoginResponse users = LoginResponse.fromJson(response.data);
    return users;
  }


  // -------------------- Logout ----------------

  Future<LogoutModel> logout({String? email, String? otp}) async {
    var token =
        await sl<Storage>().secureStorage.read(key: SharedPrefsConstant.TOKEN);
    Response response = await client.post('${ApiConstant.logout}',
        options: Options(
          headers: <String, String>{
            "Authorization": "${token}",
            "lang": "${sl<SharedLocal>().getLanguage}",
          },
        ));

    LogoutModel logoutModel = LogoutModel.fromJson(response.data);
    return logoutModel;
  }


  // -------------------- Change Password Repository ----------------

  Future<LoginResponse> changePassword(
      {String? currentPassword, String? newPassword}) async {
    var token =
        await sl<Storage>().secureStorage.read(key: SharedPrefsConstant.TOKEN);
    Response response = await client.post(
      '${ApiConstant.changePassword}',
      data: {
        "current_password": "$currentPassword",
        "new_password": "$newPassword",
      },
      options: Options(
        headers: <String, String>{
          "Authorization": "$token",
          "lang": "${sl<SharedLocal>().getLanguage}",
        },
      ),
    );

    LoginResponse users = LoginResponse.fromJson(response.data);
    return users;
  }
}
