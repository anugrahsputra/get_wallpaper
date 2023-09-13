import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:get_wallpaper/presentation/presentation.dart';
import 'package:get_wallpaper/services/api_service.dart';

import 'data/repository/repository.dart';
import 'data/usecase/usecase.dart';
import 'utils/env.dart';

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

  /* =============> Repository <============= */
  locator.registerLazySingleton<CategorizedRepository>(
      () => CategorizedRepositoryImpl(locator()));
  locator.registerLazySingleton<ListWallpaperRepository>(
      () => ListWallpaperRepositoryImpl(locator()));
  locator.registerLazySingleton<DetailWallpaperRepository>(
      () => DetailWallpaperRepositoryImpl(locator()));
  locator.registerLazySingleton<SearchWallpaperRepository>(
      () => SearchwallpaperRepositoryImpl(locator()));

  /* =============> Usecase <============= */
  locator.registerLazySingleton(() => GetCategorizedWallpaper(locator()));
  locator.registerLazySingleton(() => GetListWallpaper(locator()));
  locator.registerLazySingleton(() => GetDetailWallpaper(locator()));

  /* =============> Cubit <============= */
  locator.registerFactory(() => CategorizedWallpaperCubit(locator()));
  locator.registerFactory(() => ListWallpaperCubit(locator()));
  locator.registerFactory(() => DetailWallpaperCubit(locator()));
  locator.registerFactory(() => SearchWallpaperCubit(locator()));
}
