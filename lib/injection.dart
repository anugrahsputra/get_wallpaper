import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

import 'core/core.dart';
import 'data/datasource/api.dart';
import 'data/repository/repository.dart';
import 'domain/domain.dart';
import 'presentation/presentation.dart';

final locator = GetIt.instance;

Future<void> init() async {
  var dir = await getTemporaryDirectory();

  locator.registerFactory<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: Env.baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        sendTimeout: const Duration(seconds: 5),
      ),
    ),
    instanceName: "interceptor",
  );
  locator.registerFactory<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: Env.baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        sendTimeout: const Duration(seconds: 5),
      ),
    )..interceptors.addAll([
        CustomInterceptor(),
        DioCacheInterceptor(
          options: CacheOptions(
            store: HiveCacheStore(dir.path, hiveBoxName: 'cached_wallpapers'),
            priority: CachePriority.normal,
            maxStale: const Duration(days: 1),
            hitCacheOnErrorExcept: [],
          ),
        ),
      ]),
  );
  locator.registerFactory(() => DioClient(locator<Dio>()));

  locator.registerLazySingleton<NetworkHelper>(() => NetworkHelperImpl());

  locator.registerLazySingleton<WallpaperHandler>(
      () => WallpaperHandlerImpl(false));

  locator.registerLazySingleton<WallpaperRemoteDataSource>(
      () => WallpaperRemoteDataSourceImpl(locator()));

  /* =============> Bloc <============= */
  locator.registerFactory(() => NetworkInfoBloc());
  locator.registerFactory(() => SearchBloc(repository: locator()));
  locator.registerFactory(
    () => WallpapersBloc(
      getListRepo: locator<GetListWallpaper>(),
      categorizedRepo: locator<GetCategorizedWallpaper>(),
    ),
  );
  locator.registerFactory(
    () => DetailBloc(
      repository: locator<GetDetailWallpaper>(),
    ),
  );
  locator.registerFactory(
    () => SetWallpaperBloc(
      wallpaperHandler: locator<WallpaperHandler>(),
    ),
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
