import 'package:flutter_test/flutter_test.dart';
import 'package:get_wallpaper/presentation/presentation.dart';

import '../../../dummy_data/dummy_data.dart';

void main() {
  group('DetailWallpaperState', () {
    test('.initial() should returns correct instance', () {
      const state = DetailWallpaperState.initial();
      expect(state, const DetailWallpaperState.initial());
    });

    test('.loading() should returns correct instance', () {
      const state = DetailWallpaperState.loading();
      expect(state, const DetailWallpaperState.loading());
    });

    test('.loaded() should returns correct instance', () {
      const state = DetailWallpaperState.loaded(tWallpaper);
      expect(state, const DetailWallpaperState.loaded(tWallpaper));
    });

    test('.error() should returns correct instance', () {
      const message = 'Error Message';
      const state = DetailWallpaperState.error(message);
      expect(state, const DetailWallpaperState.error(message));
    });
  });
}
