import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_wallpaper/presentation/presentation.dart';
import 'package:get_wallpaper/presentation/widgets/back_button.dart';
import 'package:get_wallpaper/presentation/widgets/set_as_button.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/models/model.dart';

part 'detail_wallpaper.component.dart';

class DetailWallpaper extends StatefulWidget {
  final int? id;
  const DetailWallpaper({super.key, this.id});

  @override
  State<DetailWallpaper> createState() => _DetailWallpaperState();
}

class _DetailWallpaperState extends State<DetailWallpaper> {
  late bool goToHome;
  String _platformVersion = 'Unknown';
  String _wallpaperUrlHome = 'Unknown';
  String _wallpaperUrlLock = 'Unknown';
  String _wallpaperUrlBoth = 'Unknown';

  @override
  void initState() {
    super.initState();
    goToHome = false;
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    try {
      platformVersion =
          await AsyncWallpaper.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> setWallpaperHome(String url) async {
    setState(() {
      _wallpaperUrlHome = 'Loading';
    });
    String result;

    try {
      result = await AsyncWallpaper.setWallpaper(
        url: url,
        wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
        goToHome: goToHome,
        toastDetails: ToastDetails.success(),
        errorToastDetails: ToastDetails.error(),
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }

    if (!mounted) return;

    setState(() {
      _wallpaperUrlHome = result;
    });
  }

  Future<void> setWallpaperLock(String url) async {
    setState(() {
      _wallpaperUrlLock = 'Loading';
    });
    String result;

    try {
      result = await AsyncWallpaper.setWallpaper(
        url: url,
        wallpaperLocation: AsyncWallpaper.LOCK_SCREEN,
        goToHome: goToHome,
        toastDetails: ToastDetails.success(),
        errorToastDetails: ToastDetails.error(),
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }

    if (!mounted) return;

    setState(() {
      _wallpaperUrlLock = result;
    });
  }

  Future<void> setWallpaperBoth(String url) async {
    setState(() {
      _wallpaperUrlBoth = 'Loading';
    });
    String result;

    try {
      result = await AsyncWallpaper.setWallpaper(
        url: url,
        wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
        goToHome: goToHome,
        toastDetails: ToastDetails.success(),
        errorToastDetails: ToastDetails.error(),
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }
    if (!mounted) return;

    setState(() {
      _wallpaperUrlBoth = result;
    });
  }

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
                        alt: wallpaper.alt,
                        photographerName: wallpaper.photographer,
                        onPressed: () => _dialogBuilder(context, wallpaper),
                      )),
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

  Future<void> _dialogBuilder(BuildContext context, WallpaperModel? wallpaper) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black.withOpacity(0.5),
          title: Text('Set Wallpaper for $_platformVersion'),
          titleTextStyle: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SetAsButtonWidget(
                child: _wallpaperUrlHome == 'Loading'
                    ? const CircularProgressIndicator.adaptive()
                    : Text(
                        'Home Screen',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                onPressed: () {
                  setWallpaperHome(wallpaper!.src.portrait);
                  context.pop();
                  // log(wallpaper!.src.portrait);
                },
              ),
              SizedBox(height: 5.h),
              SetAsButtonWidget(
                child: _wallpaperUrlLock == 'Loading'
                    ? const CircularProgressIndicator.adaptive()
                    : Text(
                        'Lock Screen',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                onPressed: () {
                  setWallpaperLock(wallpaper!.src.portrait);
                  context.pop();
                },
              ),
              SizedBox(height: 5.h),
              SetAsButtonWidget(
                child: _wallpaperUrlBoth == 'Loading'
                    ? const CircularProgressIndicator.adaptive()
                    : Text(
                        'Both',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                onPressed: () {
                  setWallpaperBoth(wallpaper!.src.portrait);
                  context.pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
