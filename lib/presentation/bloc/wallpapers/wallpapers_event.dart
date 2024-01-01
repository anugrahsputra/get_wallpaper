part of 'wallpapers_bloc.dart';

@freezed
class WallpapersEvent with _$WallpapersEvent {
  const factory WallpapersEvent.curated(int page) = Curated;
  const factory WallpapersEvent.category(String category, int page) = Category;
  const factory WallpapersEvent.loadMore(String category, int page) = LoadMore;
}
