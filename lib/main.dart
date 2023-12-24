import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_wallpaper/bloc_observer.dart';
import 'package:get_wallpaper/injection.dart';
import 'package:get_wallpaper/presentation/presentation.dart';

import 'core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
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
          create: (context) => locator<SearchBloc>(),
        ),
        BlocProvider(
          create: (context) => locator<WallpapersBloc>(),
        ),
        BlocProvider(
          create: (context) => locator<DetailBloc>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 640),
        child: MaterialApp.router(
          title: 'Get Wallpaper',
          theme: AppThemes.light,
          darkTheme: AppThemes.dark,
          routerConfig: routes,
        ),
      ),
    );
  }
}
