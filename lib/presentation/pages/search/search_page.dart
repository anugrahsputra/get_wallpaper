import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_wallpaper/core/core.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../presentation.dart';

part 'search_page.component.dart';

class SearchWallpaper extends StatefulWidget {
  const SearchWallpaper({super.key});

  @override
  State<SearchWallpaper> createState() => _SearchWallpaperState();
}

class _SearchWallpaperState extends State<SearchWallpaper> with Wallpapers {
  String currentQuery = '';
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              titleSpacing: 0,
              floating: true,
              snap: true,
              leading: IconButton(
                onPressed: () {
                  setState(() {
                    currentQuery = '';
                  });
                  context.pop();
                  clear(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: BuildSearchBar(
                onSubmitted: (value) {
                  setState(() {
                    currentQuery = value;
                  });
                  submit(context, currentQuery, currentPage);
                },
              ),
            ),
            SliverToBoxAdapter(
              child: SearchResults(
                onPressed: () => setState(
                  () {
                    currentPage++;
                    searchLoadMore(context, currentQuery, currentPage);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
