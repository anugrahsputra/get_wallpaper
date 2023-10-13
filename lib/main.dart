import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_wallpaper/bloc_observer.dart';
import 'package:get_wallpaper/core/utils/routes.dart';
import 'package:get_wallpaper/injection.dart';
import 'package:get_wallpaper/presentation/presentation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator<ListWallpaperCubit>(),
        ),
        BlocProvider(
          create: (context) => locator<DetailWallpaperCubit>(),
        ),
        BlocProvider(
          create: (context) => locator<SearchWallpaperCubit>(),
        ),
        BlocProvider(
          create: (context) => locator<CategorizedWallpaperCubit>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 640),
        child: MaterialApp.router(
          title: 'Get Wallpaper',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: routes,
        ),
      ),
    );
  }
}
