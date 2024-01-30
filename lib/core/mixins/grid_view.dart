import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/data.dart';
import '../../presentation/presentation.dart';

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
                memCacheHeight: 600,
                memCacheWidth: 400,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: const Color.fromARGB(255, 196, 196, 196),
                  highlightColor: const Color.fromARGB(255, 241, 241, 241),
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                cacheManager: CacheManager(
                  Config(
                    'wallpaper',
                    stalePeriod: const Duration(days: 7),
                  ),
                ),
              )),
        );
      },
    );
  }

  Widget pagedGridView(PagingController pageController) {
    return PagedGridView(
      shrinkWrap: true,
      pagingController: pageController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      builderDelegate: PagedChildBuilderDelegate<Wallpaper>(
        itemBuilder: (context, item, index) {
          final wallpapers = item;
          return GestureDetector(
            onTap: () {
              context.go('/detail/${wallpapers.id}');
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: wallpapers.src.portrait,
                  memCacheHeight: 600,
                  memCacheWidth: 400,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: const Color.fromARGB(255, 196, 196, 196),
                    highlightColor: const Color.fromARGB(255, 241, 241, 241),
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  cacheManager: CacheManager(
                    Config(
                      'wallpaper',
                      stalePeriod: const Duration(days: 7),
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }
}
