import 'package:dio/dio.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/data/local_repo.dart';

class DioInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = sl<SharedLocal>().getUser()!.token;
    options.headers["lang"] = "${sl<SharedLocal>().getLanguage}";
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}
