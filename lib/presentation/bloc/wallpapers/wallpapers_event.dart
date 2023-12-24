part of 'wallpapers_bloc.dart';

@freezed
class WallpapersEvent with _$WallpapersEvent {
  const factory WallpapersEvent.curated() = Curated;
  const factory WallpapersEvent.category(String category) = Category;
}
