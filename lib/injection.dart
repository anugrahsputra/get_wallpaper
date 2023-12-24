import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/core.dart';
import 'data/datasource/api.dart';
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

  locator.registerLazySingleton<WallpaperHandler>(
      () => WallpaperHandlerImpl(false));

  locator.registerLazySingleton<ApiService>(() => ApiServiceImpl(locator()));

  /* =============> Bloc <============= */
  locator.registerFactory(() => SearchBloc(repository: locator()));
  locator.registerFactory(
    () => WallpapersBloc(
        getListRepo: locator<GetListWallpaper>(),
        categorizedRepo: locator<GetCategorizedWallpaper>()),
  );
  locator.registerFactory(
    () => DetailBloc(repository: locator<GetDetailWallpaper>()),
  );

  /* =============> Usecase <============= */
  locator.registerLazySingleton(() => GetCategorizedWallpaper(locator()));
  locator.registerLazySingleton(() => GetListWallpaper(locator()));
  locator.registerLazySingleton(() => GetDetailWallpaper(locator()));
  locator.registerLazySingleton(() => GetSearchWallpaper(locator()));

  /* =============> Repository <============= */
  locator.registerLazySingleton<WallpaperRepository>(
      () => WallpaperRepositoryImpl(locator()));
}
