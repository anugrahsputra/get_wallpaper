import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class BackButtonWidget extends StatelessWidget {
  final Color color;
  const BackButtonWidget({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            context.pop();
          },
          icon:  Icon(
            Icons.arrow_back_ios,
            color: color,
          ),
        ),
        Text(
          'Back',
          style: GoogleFonts.inter(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
