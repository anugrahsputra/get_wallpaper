import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_wallpaper/presentation/presentation.dart';
import 'package:go_router/go_router.dart';

import '../../data/data.dart';

mixin GridViewMixin {
  Widget buildGridView(List<Wallpaper> wallpaper) {
    return DefaultGridView(
      itemCount: wallpaper.length,
      itemBuilder: (context, index) {
        final wallpapers = wallpaper[index];
        return GestureDetector(
          onTap: () {
            context.go('/detail/${wallpapers.id}');
          },
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: wallpapers.src.portrait,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )),
        );
      },
    );
  }
}
