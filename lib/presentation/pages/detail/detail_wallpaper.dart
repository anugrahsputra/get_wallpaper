import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../../injection.dart';
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
    TextStyle textStyle = GoogleFonts.inter(
      color: Colors.white,
    );

    return BlocListener<NetworkInfoBloc, NetworkInfoState>(
      listener: (context, state) {
        if (state is Offline) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('You are offline', style: textStyle),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            forceMaterialTransparency: true,
            titleSpacing: 0,
            leading: IconButton(
              onPressed: () {
                context.pop();
                clear(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: Text(
              'Back',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold),
            ),
          ),
          body: const WallpaperView()),
    );
  }
}

class WallpaperView extends StatelessWidget {
  const WallpaperView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(
      builder: (context, state) {
        if (state is DetailLoading) {
          return Center(
            child: LoadingAnimationWidget.bouncingBall(
              color: AppColor.primaryLight,
              size: 100,
            ),
          );
        } else if (state is DetailLoaded) {
          final wallpaper = state.wallpaper;
          return Stack(
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
          );
        } else if (state is DetailError) {
          return Center(child: Text(state.message.errorMessage));
        } else {
          return const Center(child: Text('Unknown'));
        }
      },
    );
  }
}
