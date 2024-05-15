import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:sizer/sizer.dart';

import '../injection.dart';
import 'core/core.dart';
import 'presentation/presentation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CustomLog.initialize(showLog: !kReleaseMode);
  await init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      DefaultCacheManager().removeFile("wallpaper");
    }
  }

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
        BlocProvider(
          create: (context) => locator<SetWallpaperBloc>(),
        ),
        BlocProvider(
          create: (context) =>
              locator<NetworkInfoBloc>()..add(const CheckConnection()),
        ),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Get Wallpaper',
            theme: AppThemes.dark,
            routerConfig: routes,
          );
        },
      ),
    );
  }
}
