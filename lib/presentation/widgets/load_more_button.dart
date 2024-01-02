import 'package:flutter/material.dart';

import '../../core/core.dart';

class LoadMoreBtn extends StatefulWidget {
  const LoadMoreBtn({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  State<LoadMoreBtn> createState() => _LoadMoreBtnState();
}

class _LoadMoreBtnState extends State<LoadMoreBtn> {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: widget.onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.refresh,
            color: AppColor.backgroundDark,
          ),
          const SizedBox(width: 10),
          Text(
            'Load More',
            style: TextStyle(
              color: AppColor.backgroundDark,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
