import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_wallpaper/core/core.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lottie/lottie.dart';

import '../../../domain/domain.dart';
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

  final PagingController<int, Wallpaper> _pageController = PagingController(
    firstPageKey: 1,
  );

  @override
  void initState() {
    super.initState();
    _pageController.addPageRequestListener((pageKey) {
      context.read<SearchBloc>().add(More(currentQuery, pageKey));
    });
  }

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
                pageController: _pageController,
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
