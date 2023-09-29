import 'package:flutter_test/flutter_test.dart';
import 'package:get_wallpaper/data/data.dart';
import 'package:get_wallpaper/presentation/presentation.dart';

void main() {
  group('SearchWallpaperState', () {
    test('.initial() should returns correct instance', () {
      const state = SearchWallpaperState.initial();
      expect(state, const SearchWallpaperState.initial());
    });

    test('.loading() should returns correct instance', () {
      const state = SearchWallpaperState.loading();
      expect(state, const SearchWallpaperState.loading());
    });

    test('.loaded() should returns correct instance', () {
      final tWallpapers = <Wallpaper>[];
      final state = SearchWallpaperState.loaded(tWallpapers);
      expect(state, SearchWallpaperState.loaded(tWallpapers));
    });

    test('.error() should returns correct instance', () {
      const message = "Error message";
      const state = SearchWallpaperState.error(message);
      expect(state, const SearchWallpaperState.error(message));
    });
  });
}
