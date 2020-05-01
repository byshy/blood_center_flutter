import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'data/api_provider.dart';
import 'data/local_provider.dart';
import 'models/user.dart';

/// sl: service locator
final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<LocalProvider>(
        () => LocalProvider(
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton<ApiProvider>(
        () => ApiProvider(
      client: sl(),
    ),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  Dio client = Dio(
    BaseOptions(),
  );

  sl.registerLazySingleton<Dio>(() => client);

  refreshToken();
}

refreshToken() async {
  User user = sl<LocalProvider>().getUser();
  if (user != null) {
    print('token: ${user.token}');
    sl<Dio>().options.headers = {'Authorization': 'JWT ${user.token}'};
  }
}
