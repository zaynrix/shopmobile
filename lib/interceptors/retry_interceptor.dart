import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shopmobile/interceptors/dio_connectivity_request_retrier.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });

  @override
  Future onError(DioError err, ErrorInterceptorHandler) async {
    if (_shouldRetry(err)) {
      try {
        print("sould retry");
        return requestRetrier.scheduleRequestRetry(err.requestOptions,handler: ErrorInterceptorHandler);
      } catch (e) {
        // return super.onError(err, ErrorInterceptorHandler);


        // Let any new error from the retrier pass through
        return e;
      }
    }
    // Let the error pass through if it's not the error we're looking for
    return err;
  }

  bool _shouldRetry(DioError dioError) {
    return dioError.type == DioErrorType.other &&
        dioError.error != null &&
        dioError.error is SocketException;
  }
}
