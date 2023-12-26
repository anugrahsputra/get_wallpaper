import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/data.dart';

mixin GridViewMixin {
  Widget buildGridView(List<Wallpaper> wallpaper) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: wallpaper.length,
      itemBuilder: (context, index) {
        final wallpapers = wallpaper[index];
        return GestureDetector(
          onTap: () {
            context.go('/detail/${wallpapers.id}');
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              wallpapers.src.portrait,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
