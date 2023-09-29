import 'package:flutter_test/flutter_test.dart';
import 'package:get_wallpaper/data/data.dart';
import 'package:get_wallpaper/presentation/presentation.dart';

void main() {
  group('CategorizedWallpaperState', () {
    test('.initial() should returns correct instance', () {
      const state = CategorizedWallpaperState.initial();
      expect(state, const CategorizedWallpaperState.initial());
    });

    test('.loading() should returns correct instance', () {
      const state = CategorizedWallpaperState.loading();
      expect(state, const CategorizedWallpaperState.loading());
    });

    test('.loaded() should returns correct instance', () {
      final tWallpapers = <Wallpaper>[];
      final state = CategorizedWallpaperState.loaded(tWallpapers);
      expect(state, CategorizedWallpaperState.loaded(tWallpapers));
    });

    test('.error() should returns correct instance', () {
      const message = "Error message";
      const state = CategorizedWallpaperState.error(message);
      expect(state, const CategorizedWallpaperState.error(message));
    });
  });
}
