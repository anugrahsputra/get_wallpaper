import 'package:flutter_test/flutter_test.dart';
import 'package:get_wallpaper/data/data.dart';

import '../../helper/mock.dart';

void main() {
  late WallpaperRemoteDataSourceImpl dataSource;
  late MockDioClient mockDioClient;

  setUp(() {
    mockDioClient = MockDioClient();
    dataSource = WallpaperRemoteDataSourceImpl(mockDioClient);
  });

  group('listWallpaper', () {});
}
