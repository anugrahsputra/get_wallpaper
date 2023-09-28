import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../data/data.dart';
import '../../presentation.dart';

part 'search_page.component.dart';

class SearchWallpaper extends StatefulWidget {
  const SearchWallpaper({super.key});

  @override
  State<SearchWallpaper> createState() => _SearchWallpaperState();
}

class _SearchWallpaperState extends State<SearchWallpaper> {
  final TextEditingController _searchCtrl = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  String currentQuery = '';
  bool isLoadMore = false;
  Timer? debounce;

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(() {
      setState(() {});
    });
    clearSearch();
  }

  void onSearchQuery(String query) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<SearchWallpaperCubit>().searchWallpaper(query);
    });
  }

  void searchQuery(String query) {
    if (_searchCtrl.text.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 500), () {
        context.read<SearchWallpaperCubit>().searchWallpaper(query);
      });
    } else {
      clearSearch();
    }
  }

  void clearSearch() {
    setState(() {
      _searchCtrl.clear();
      context.read<SearchWallpaperCubit>().clearSearch();
    });
  }

  @override
  void dispose() {
    debounce?.cancel();
    _searchFocus.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    clearSearch();
                    context.pop();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                _BuildSearchBar(
                  controller: _searchCtrl,
                  focusNode: _searchFocus,
                  onChanged: (value) {
                    setState(() {
                      currentQuery = value;
                    });
                    onSearchQuery(value);
                  },
                ),
                if (_searchCtrl.text.isNotEmpty)
                  IconButton(
                    onPressed: () => clearSearch(),
                    icon: const Icon(Icons.clear),
                  ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: BlocBuilder<SearchWallpaperCubit, SearchWallpaperState>(
                builder: (context, state) {
              return state.when(
                initial: () => Lottie.asset(
                  'assets/search_initials.json',
                  repeat: false,
                ),
                loading: () => const DefaultShimmerSearch(),
                loaded: (result) => _BuildGridView(
                    onPressed: () {
                      setState(() {
                        isLoadMore = true;
                      });
                      context
                          .read<SearchWallpaperCubit>()
                          .loadMore(currentQuery);
                    },
                    result: result),
                error: (message) => Center(
                  child: Text(message),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
