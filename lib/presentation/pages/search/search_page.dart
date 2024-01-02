import 'package:cached_network_image/cached_network_image.dart';
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

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >
        _scrollController.position.maxScrollExtent - 200) {
      setState(() {
        currentPage++;
      });
      searchLoadMore(context, currentQuery, currentPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
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
              child: SearchResults(scrollController: _scrollController),
            ),
          ],
        ),
      ),
    );
  }
}
