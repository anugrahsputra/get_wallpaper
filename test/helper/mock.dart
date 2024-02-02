import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get_wallpaper/core/core.dart';
import 'package:get_wallpaper/data/data.dart';
import 'package:get_wallpaper/domain/domain.dart';
import 'package:get_wallpaper/presentation/presentation.dart';
import 'package:mockito/annotations.dart';

export 'mock.mocks.dart';

@GenerateNiceMocks([
  // External
  MockSpec<AsyncWallpaper>(),
  MockSpec<Dio>(),
  MockSpec<PlatformException>(),
  MockSpec<DioClient>(),

  // Utils
  MockSpec<WallpaperHandler>(),

  // Data/datasource
  MockSpec<WallpaperRemoteDataSource>(),

  // Data/model
  MockSpec<ImageSource>(),
  MockSpec<Wallpaper>(),

  // Domain/repository
  MockSpec<WallpaperRepository>(),

  // Domain/usecase
  MockSpec<GetDetailWallpaper>(),
  MockSpec<GetListWallpaper>(),
  MockSpec<GetSearchWallpaper>(),
  MockSpec<GetCategorizedWallpaper>(),

  // Presentation/bloc
  MockSpec<SearchBloc>(),
  MockSpec<WallpapersBloc>(),
  MockSpec<DetailBloc>(),
  MockSpec<SetWallpaperBloc>(),
])
void main(List<String> args) {}
