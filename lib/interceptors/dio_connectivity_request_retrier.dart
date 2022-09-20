import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:shopmobile/data/apiConstant.dart';

class DioConnectivityRequestRetrier {
  final Dio dio;
  final Connectivity connectivity;

  DioConnectivityRequestRetrier({
    required this.dio,
    required this.connectivity,
  });

  // Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
  //   StreamSubscription? streamSubscription;
  //   final responseCompleter = Completer<Response>();
  //
  //   streamSubscription = connectivity.onConnectivityChanged.listen(
  //     (connectivityResult) async {
  //       if (connectivityResult != ConnectivityResult.none) {
  //         print("This is IF $connectivityResult ${ConnectivityResult.none}");
  //         streamSubscription!.cancel();
  //         // Complete the completer instead of returning
  //         responseCompleter.complete(
  //           dio.request(
  //             requestOptions.path,
  //             cancelToken: requestOptions.cancelToken,
  //             data: requestOptions.data,
  //             onReceiveProgress: requestOptions.onReceiveProgress,
  //             onSendProgress: requestOptions.onSendProgress,
  //             queryParameters: requestOptions.queryParameters,
  //             options: Options(
  //                 headers: requestOptions.headers,
  //                 extra: requestOptions.extra,
  //                 contentType: requestOptions.contentType,
  //                 followRedirects: requestOptions.followRedirects,
  //                 listFormat: requestOptions.listFormat,
  //                 maxRedirects: requestOptions.maxRedirects,
  //                 method: requestOptions.method,
  //                 receiveDataWhenStatusError:
  //                     requestOptions.receiveDataWhenStatusError,
  //                 receiveTimeout: requestOptions.receiveTimeout,
  //                 requestEncoder: requestOptions.requestEncoder,
  //                 responseDecoder: requestOptions.responseDecoder,
  //                 responseType: requestOptions.responseType,
  //                 sendTimeout: requestOptions.sendTimeout,
  //                 validateStatus: requestOptions.validateStatus),
  //           ),
  //         );
  //       }
  //       print("This outside if ${connectivityResult.name}");
  //     },
  //   );
  //   print("This outside ");
  //   return responseCompleter.future;
  // }
  /**   receiveDataWhenStatusError: true,
    connectTimeout: 50000,
    receiveTimeout: 30000,
    responseType: ResponseType.json,
    baseUrl: '${ApiConstant.url}',
    contentType: 'application/json',
    * */
  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    late StreamSubscription streamSubscription;
    final responseCompleter = Completer<Response>();

    streamSubscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) async {
        if (connectivityResult != ConnectivityResult.none) {
          streamSubscription.cancel();
          // Complete the completer instead of returning
          responseCompleter.complete(
            dio.request(
              requestOptions.path,
options: Options(

  receiveDataWhenStatusError: true,
  receiveTimeout: 30000,
  responseType: ResponseType.json,
  // baseUrl: '${ApiConstant.url}',
  contentType: 'application/json',

),
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
              // options: requestOptions,
            ),
          );
        }
      },
    );

    return responseCompleter.future;
  }
}

// extension _AsOptions on RequestOptions {
//   Options asOptions() {
//     return Options(
//       method: method,
//       sendTimeout: sendTimeout,
//       receiveTimeout: receiveTimeout,
//       extra: extra,
//       headers: headers,
//       responseType: responseType,
//       contentType: contentType,
//       validateStatus: validateStatus,
//       receiveDataWhenStatusError: receiveDataWhenStatusError,
//       followRedirects: followRedirects,
//       maxRedirects: maxRedirects,
//       requestEncoder: requestEncoder,
//       responseDecoder: responseDecoder,
//       listFormat: listFormat,
//     );
//   }
// }
