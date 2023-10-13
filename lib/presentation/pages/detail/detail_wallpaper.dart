import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../../injection.dart';
import '../../presentation.dart';

part 'detail_wallpaper.component.dart';

class DetailWallpaper extends StatefulWidget {
  final int? id;
  const DetailWallpaper({super.key, this.id});

  @override
  State<DetailWallpaper> createState() => _DetailWallpaperState();
}

class _DetailWallpaperState extends State<DetailWallpaper> {
  @override
  Widget build(BuildContext context) {
    context.read<DetailWallpaperCubit>().getWallpaperDetail(widget.id!);
    return Scaffold(
      body: BlocBuilder<DetailWallpaperCubit, DetailWallpaperState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (wallpaper) {
              return Stack(
                children: [
                  _WallpaperImage(
                    src: wallpaper.src.portrait,
                  ),
                  const Positioned(
                    top: 40,
                    left: 20,
                    child: BackButtonWidget(),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 20,
                    right: 20,
                    child: _WallpaperDetails(
                      wallpaper: wallpaper,
                    ),
                  ),
                ],
              );
            },
            error: (message) => Center(
              child: Text(message),
            ),
          );
        },
      ),
    );
  }
}
