import 'package:go_router/go_router.dart';

import '../../presentation/presentation.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const Homepage(),
    ),
    GoRoute(
      path: '/detail/:id',
      name: 'detail-wallpaper',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id'].toString());
        return DetailWallpaper(id: id);
      },
    ),
    GoRoute(
      path: '/search',
      name: 'search-wallpaper',
      builder: (context, state) => const SearchWallpaper(),
    ),
  ],
);
