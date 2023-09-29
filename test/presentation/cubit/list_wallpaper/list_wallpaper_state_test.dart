import 'package:flutter_test/flutter_test.dart';
import 'package:get_wallpaper/data/data.dart';
import 'package:get_wallpaper/presentation/presentation.dart';

void main() {
  group('ListWallpaperState', () {
    test('.initial() should returns correct instance', () {
      const state = ListWallpaperState.initial();
      expect(state, const ListWallpaperState.initial());
    });

    test('.loading() should returns correct instance', () {
      const state = ListWallpaperState.loading();
      expect(state, const ListWallpaperState.loading());
    });

    test('.loaded() should returns correct instance', () {
      final tWallpapers = <Wallpaper>[];
      final state = ListWallpaperState.loaded(tWallpapers);
      expect(state, ListWallpaperState.loaded(tWallpapers));
    });

    test('.error() should returns correct instance', () {
      const message = "Error message";
      const state = ListWallpaperState.error(message);
      expect(state, const ListWallpaperState.error(message));
    });
  });
}
