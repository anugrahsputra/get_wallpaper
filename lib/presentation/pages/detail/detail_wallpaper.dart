import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../presentation.dart';

part 'detail_wallpaper.component.dart';

class DetailWallpaper extends StatefulWidget {
  final int? id;
  const DetailWallpaper({super.key, this.id});

  @override
  State<DetailWallpaper> createState() => _DetailWallpaperState();
}

class _DetailWallpaperState extends State<DetailWallpaper> with Wallpapers {
  Color dominantColor = Colors.white;

  @override
  void initState() {
    super.initState();
    getDetailWallpaper(context, widget.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        titleSpacing: 0,
        title: Text(
          'Back',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          return state.maybeWhen(
            initial: () => Center(
                child: LoadingAnimationWidget.bouncingBall(
              color: Colors.deepPurple,
              size: 100,
            )),
            loading: () => Center(
                child: LoadingAnimationWidget.bouncingBall(
              color: Colors.deepPurple,
              size: 100,
            )),
            loaded: (wallpaper) {
              return Hero(
                tag: wallpaper,
                child: Stack(
                  children: [
                    _WallpaperImage(
                      src: wallpaper.src.portrait,
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
                ),
              );
            },
            orElse: () => const Center(
              child: Text('Something went wrong'),
            ),
          );
        },
      ),
    );
  }
}
