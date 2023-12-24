import 'package:flutter/material.dart';

abstract class AppColor {
  /* =====================> LIGHT COLOR <===================== */
  static Brightness get brightnessLight => Brightness.light;
  static Color get primaryLight => const Color(0xff375778);
  static Color get onPrimaryLight => const Color(0xffffffff);
  static Color get primaryContainerLight => const Color(0xffa4c4ed);
  static Color get onPrimaryContainerLight => const Color(0xff0e1014);
  static Color get secondaryLight => const Color(0xfff98d94);
  static Color get onSecondaryLight => const Color(0xff000000);
  static Color get secondaryContainerLight => const Color(0xffffc4c6);
  static Color get onSecondaryContainerLight => const Color(0xff141011);
  static Color get tertiaryLight => const Color(0xfff2c4c7);
  static Color get onTertiaryLight => const Color(0xff000000);
  static Color get tertiaryContainerLight => const Color(0xffffe3e5);
  static Color get onTertiaryContainerLight => const Color(0xff141313);
  static Color get errorLight => const Color(0xffb00020);
  static Color get onErrorLight => const Color(0xffffffff);
  static Color get errorContainerLight => const Color(0xfffcd8df);
  static Color get onErrorContainerLight => const Color(0xff141213);
  static Color get backgroundLight => const Color(0xfffafbfb);
  static Color get onBackgroundLight => const Color(0xff0e0e0e);
  static Color get surfaceLight => const Color(0xfffdfdfd);
  static Color get onSurfaceLight => const Color(0xff090909);
  static Color get surfaceVariantLight => const Color(0xffebebec);
  static Color get onSurfaceVariantLight => const Color(0xff121212);
  static Color get outlineLight => const Color(0xff818181);
  static Color get outlineVariantLight => const Color(0xffcdcdcd);
  static Color get shadowLight => const Color(0xff000000);
  static Color get scrimLight => const Color(0xff000000);
  static Color get inverseSurfaceLight => const Color(0xff111111);
  static Color get onInverseSurfaceLight => const Color(0xfff5f5f5);
  static Color get inversePrimaryLight => const Color(0xffc3d7eb);
  static Color get surfaceTintLight => const Color(0xff375778);

  /* =====================> DARK COLOR <===================== */
  static Brightness get brightnessDark => Brightness.dark;
  static Color get primaryDark => const Color(0xff5e7691);
  static Color get onPrimaryDark => const Color(0xfffbfcfd);
  static Color get primaryContainerDark => const Color(0xff375778);
  static Color get onPrimaryContainerDark => const Color(0xfff5f7fa);
  static Color get secondaryDark => const Color(0xffeba1a6);
  static Color get onSecondaryDark => const Color(0xff080606);
  static Color get secondaryContainerDark => const Color(0xffae424f);
  static Color get onSecondaryContainerDark => const Color(0xfffdf6f7);
  static Color get tertiaryDark => const Color(0xfff4cfd1);
  static Color get onTertiaryDark => const Color(0xff080808);
  static Color get tertiaryContainerDark => const Color(0xff96434f);
  static Color get onTertiaryContainerDark => const Color(0xfffbf6f7);
  static Color get errorDark => const Color(0xffcf6679);
  static Color get onErrorDark => const Color(0xff080405);
  static Color get errorContainerDark => const Color(0xffb1384e);
  static Color get onErrorContainerDark => const Color(0xfffdf6f7);
  static Color get backgroundDark => const Color(0xff131416);
  static Color get onBackgroundDark => const Color(0xfff3f3f4);
  static Color get surfaceDark => const Color(0xff131415);
  static Color get onSurfaceDark => const Color(0xfff7f7f7);
  static Color get surfaceVariantDark => const Color(0xff343637);
  static Color get onSurfaceVariantDark => const Color(0xfff2f2f2);
  static Color get outlineDark => const Color(0xff7b7b86);
  static Color get outlineVariantDark => const Color(0xff323237);
  static Color get shadowDark => const Color(0xff000000);
  static Color get scrimDark => const Color(0xff000000);
  static Color get inverseSurfaceDark => const Color(0xfff9fafb);
  static Color get onInverseSurfaceDark => const Color(0xff070707);
  static Color get inversePrimaryDark => const Color(0xff36404b);
  static Color get surfaceTintDark => const Color(0xff5e7691);
}
