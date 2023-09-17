import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/core.dart';
import 'data/api/api.dart';
import 'data/repository/repository.dart';
import 'domain/domain.dart';
import 'presentation/presentation.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerFactory<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: Env.baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      ),
    ),
  );

  locator.registerLazySingleton<ApiService>(() => ApiServiceImpl(locator()));

  /* =============> Cubit <============= */
  locator.registerFactory(() => CategorizedWallpaperCubit(locator()));
  locator.registerFactory(() => ListWallpaperCubit(locator()));
  locator.registerFactory(() => DetailWallpaperCubit(locator()));
  locator.registerFactory(() => SearchWallpaperCubit(locator()));

  /* =============> Usecase <============= */
  locator.registerLazySingleton(() => GetCategorizedWallpaper(locator()));
  locator.registerLazySingleton(() => GetListWallpaper(locator()));
  locator.registerLazySingleton(() => GetDetailWallpaper(locator()));
  locator.registerLazySingleton(() => GetSearchWallpaper(locator()));

  /* =============> Repository <============= */
  locator.registerLazySingleton<WallpaperRepository>(
      () => WallpaperRepositoryImpl(locator()));
}
