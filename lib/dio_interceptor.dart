// import 'package:dio/dio.dart';
// import 'package:mobile_shop/data/local_repo.dart';
// import 'package:mobile_shop/di.dart';
// import 'package:mobile_shop/utils/storage.dart';
//
// class DioInterceptor extends Interceptor  {
//   DioInterceptor(){
//     sl.get<Storage>().readToken(SharedPrefsConstant.TOKEN);
//   }
//   // final _prefsLocator = sl<Storage>();
//   // final _prefsLocator= sl.get<Storage>();
//   // var data = sl<Storage>().secureStorage.read(key: SharedPrefsConstant.TOKEN);
//   final _prefsLocator = sl.get<Storage>();
//
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     print("this is ONREQUEST ${_prefsLocator.}");
//     options.headers['Authorization'] = _prefsLocator.token;
//     super.onRequest(options, handler);
//   }//0597910429
//
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     // TODO: implement onResponse
//     super.onResponse(response, handler);
//   }
//
//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) {
//     // TODO: implement onError
//     super.onError(err, handler);
//   }
// }
