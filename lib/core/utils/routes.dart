import 'package:go_router/go_router.dart';

import '../../presentation/presentation.dart';

abstract class AppRoutes {
  static GoRouter get router => GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => const Homepage(),
            routes: [
              GoRoute(
                path: 'detail/:id',
                name: 'detail-wallpaper',
                builder: (context, state) {
                  final id = int.parse(state.pathParameters['id'].toString());
                  return DetailWallpaper(id: id);
                },
              ),
            ],
          ),
          GoRoute(
            path: 'search',
            name: 'search-wallpaper',
            builder: (context, state) => const SearchWallpaper(),
            routes: [
              GoRoute(
                path: 'detail/:id',
                name: 'detail-wallpaper',
                builder: (context, state) {
                  final id = int.parse(state.pathParameters['id'].toString());
                  return DetailWallpaper(id: id);
                },
              ),
            ],
          ),
        ],
      );
}

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const Homepage(),
      routes: [
        GoRoute(
          path: 'detail/:id',
          name: 'detail-wallpaper',
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id'].toString());
            return DetailWallpaper(id: id);
          },
        ),
        GoRoute(
          path: 'search',
          name: 'search-wallpaper',
          builder: (context, state) => const SearchWallpaper(),
        ),
      ],
    ),
  ],
);
