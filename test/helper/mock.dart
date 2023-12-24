import 'package:dio/dio.dart';
import 'package:get_wallpaper/data/data.dart';
import 'package:get_wallpaper/domain/domain.dart';
import 'package:mockito/annotations.dart';

export 'mock.mocks.dart';

@GenerateNiceMocks([
  // Data
  MockSpec<ApiService>(),
  MockSpec<WallpaperRepository>(),
  MockSpec<Dio>(),

  // Domain/usecase
  MockSpec<GetDetailWallpaper>(),
  MockSpec<GetListWallpaper>(),
  MockSpec<GetSearchWallpaper>(),
  MockSpec<GetCategorizedWallpaper>(),
])
void main(List<String> args) {}
