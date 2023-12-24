part of 'search_wallpaper_bloc.dart';

@freezed
class SearchEvent with _$SearchEvent {
  factory SearchEvent.started() = Started;
  factory SearchEvent.searchQuery(String query, int page) = SearchQuery;
}
