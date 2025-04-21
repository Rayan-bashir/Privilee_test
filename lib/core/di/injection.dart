import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:new_project/core/constants/app_consts.dart';
import 'package:new_project/core/di/injection.config.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async {
  getIt.init();
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        'accept': 'application/json',
        'content-type': 'application/json',
      },
      baseUrl: AppConsts.baseUrl,
    ),
  );
  dio.interceptors.addAll([
    // TODO: create interceptor for refresh token
    // PrettyDioLogger(),
    // sl<AccessTokenInterceptor>()
  ]);
  getIt.registerLazySingleton<Dio>(() => dio);
}
