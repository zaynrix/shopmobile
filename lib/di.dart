import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmobile/interceptors/dio_connectivity_request_retrier.dart';
import 'package:shopmobile/interceptors/retry_interceptor.dart';
import 'package:shopmobile/utils/storage.dart';
import 'package:shopmobile/data/auth_repo.dart';
import 'package:shopmobile/data/cart_repo.dart';
import 'package:shopmobile/data/home_repo.dart';
import 'package:shopmobile/data/local_repo.dart';
import 'package:shopmobile/utils/appConfig.dart';
import 'package:shopmobile/data/apiConstant.dart';
import 'package:shopmobile/data/profile_repo.dart';
import 'package:shopmobile/routing/navigation.dart';
import 'package:shopmobile/data/category_repo.dart';
import 'package:shopmobile/data/favourite_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopmobile/ui/features/auth_provider.dart';
import 'package:shopmobile/ui/features/cart/cartProvider.dart';
import 'package:shopmobile/ui/features/home/homeProvider.dart';
import 'package:shopmobile/ui/features/explor/explorProvider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shopmobile/ui/features/Profile/profileProvider.dart';
import 'package:shopmobile/ui/features/category/categoryProvider.dart';
import 'package:shopmobile/ui/features/favorite/favoriteProvider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  Dio client = Dio(BaseOptions(
    receiveDataWhenStatusError: true,
    connectTimeout: 50000,
    receiveTimeout: 30000,
    responseType: ResponseType.json,
    baseUrl: '${ApiConstant.url}',
    contentType: 'application/json',
  ));

  client.interceptors.add(RetryOnConnectionChangeInterceptor(
    requestRetrier: DioConnectivityRequestRetrier(
      dio: client,
      connectivity: Connectivity(),
    ),
  ));
  sl.registerLazySingleton<HttpAuth>(() => HttpAuth(client: sl()));
  sl.registerLazySingleton<HomeRepo>(() => HomeRepo(client: sl()));
  sl.registerLazySingleton<FavouriteRepo>(() => FavouriteRepo(client: sl()));
  sl.registerLazySingleton<CartRepo>(() => CartRepo(client: sl()));
  sl.registerLazySingleton<ProfileRepo>(() => ProfileRepo(client: sl()));
  sl.registerLazySingleton<CategoryRepo>(() => CategoryRepo(client: sl()));

  sl.registerLazySingleton<SharedLocal>(
    () => SharedLocal(
      sharedPreferences: sl(),
    ),
  );
  FlutterSecureStorage secureStorage = await FlutterSecureStorage();
  sl.registerLazySingleton<Storage>(
    () => Storage(
      secureStorage: sl(),
    ),
  );

  sl.registerLazySingleton<Dio>(() => client);

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<FlutterSecureStorage>(() => secureStorage);
  sl.registerLazySingleton(() => NavigationService());
  sl.registerLazySingleton(() => FavouriteProvider());
  sl.registerLazySingleton(() => HomeProvider());
  sl.registerLazySingleton(() => ProfileProvider());
  sl.registerLazySingleton(() => ExploreProvider());
  sl.registerLazySingleton(() => AppConfig());
  sl.registerLazySingleton(() => AuthProvider());
  sl.registerLazySingleton(() => CartProvider());
  sl.registerLazySingleton(() => CategoryProvider());
}

// class CustomInterceptor extends Interceptor {
//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     print("onRequest");
//     return super.onRequest(options, handler);
//   }
//
//   @override
//   Future? onResponse(Response response, ResponseInterceptorHandler handler) {
//     print("onResponse");
//     return null;
//   }
//
//   @override
//   Future onError(DioError err, ErrorInterceptorHandler handler) async {
//     print("onError: ${err.response!.statusCode}");
//     return handler.next(err); // <--- THE TIP IS HERE
//   }
// }
