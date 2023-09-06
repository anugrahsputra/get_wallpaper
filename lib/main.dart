import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_wallpaper/cubit/categorized_wallpaper/categorized_wallpaper_cubit.dart';
import 'package:get_wallpaper/cubit/detail_wallpaper/detail_wallpaper_cubit.dart';
import 'package:get_wallpaper/cubit/list_wallpaper/list_wallpaper_cubit.dart';
import 'package:get_wallpaper/cubit/search_wallpaper/search_wallpaper_cubit.dart';
import 'package:get_wallpaper/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ListWallpaperCubit(),
        ),
        BlocProvider(
          create: (context) => DetailWallpaperCubit(),
        ),
        BlocProvider(
          create: (context) => SearchWallpaperCubit(),
        ),
        BlocProvider(
          create: (context) => CategorizedWallpaperCubit(),
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
