import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/services.dart';

import '../core.dart';

abstract class WallpaperHandler {
  Future<String> getPlatformVersion();
  Future<String> setAsWallpaper(String url, int location);
}

class WallpaperHandlerImpl implements WallpaperHandler {
  late bool goToHome;

  WallpaperHandlerImpl(this.goToHome);

  @override
  Future<String> getPlatformVersion() async {
    try {
      return await AsyncWallpaper.platformVersion ?? "unknown platform version";
    } on PlatformException {
      return "error getting platform version";
    }
  }

  @override
  Future<String> setAsWallpaper(String url, int location) async {
    String result;

    try {
      result = await AsyncWallpaper.setWallpaper(
        url: url,
        wallpaperLocation: location,
        goToHome: goToHome,
        toastDetails: ToastDetails(
          message: 'Wallpaper Set',
          backgroundColor: AppColor.onBackgroundLight,
        ),
        errorToastDetails: ToastDetails.error(),
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }
    return result;
  }
}
