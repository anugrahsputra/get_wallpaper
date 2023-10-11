import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/data.dart';

class DefaultDialog {
  late BuildContext context;
  DefaultDialog(this.context);

  Future<void> dialog(
    context, {
    required Wallpaper? wallpaper,
    required String text,
    required List<Widget> children,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          backgroundColor: Colors.black.withOpacity(0.5),
          title: Text(text),
          titleTextStyle: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        );
      },
    );
  }
}
