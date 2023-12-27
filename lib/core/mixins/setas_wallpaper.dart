import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:get_wallpaper/injection.dart';

import '../core.dart';

mixin SetAsWallpaperMixin<T extends StatefulWidget> on State<T> {
  late bool goToHome;
  late WallpaperHandler _wallpaperHandler;
  String platformVersion = 'Unknown';
  String wallpaperUrlHome = 'Unknown';
  String wallpaperUrlLock = 'Unknown';
  String wallpaperUrlBoth = 'Unknown';

  @override
  void initState() {
    super.initState();
    _wallpaperHandler = locator<WallpaperHandler>();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion = await _wallpaperHandler.getPlatformVersion();

    if (!mounted) return;

    setState(() {
      platformVersion = platformVersion;
    });
  }

  Future<void> setWallpaperHome(String url) async {
    setState(() {
      wallpaperUrlHome = 'Loading';
    });

    String result =
        await _wallpaperHandler.setAsWallpaper(url, AsyncWallpaper.HOME_SCREEN);

    if (!mounted) return;

    setState(() {
      wallpaperUrlHome = result;
    });
  }

  Future<void> setWallpaperLock(String url) async {
    setState(() {
      wallpaperUrlLock = 'Loading';
    });
    String result =
        await _wallpaperHandler.setAsWallpaper(url, AsyncWallpaper.LOCK_SCREEN);

    if (!mounted) return;

    setState(() {
      wallpaperUrlLock = result;
    });
  }

  Future<void> setWallpaperBoth(String url) async {
    setState(() {
      wallpaperUrlBoth = 'Loading';
    });
    String result = await _wallpaperHandler.setAsWallpaper(
        url, AsyncWallpaper.BOTH_SCREENS);

    if (!mounted) return;

    setState(() {
      wallpaperUrlBoth = result;
    });
  }
}
