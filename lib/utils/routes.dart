import 'package:get_wallpaper/presentation/pages/detail_wallpaper.dart';
import 'package:get_wallpaper/presentation/pages/homepage.dart';
import 'package:go_router/go_router.dart';

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
  ],
);
