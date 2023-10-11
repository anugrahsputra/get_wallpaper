import 'dart:async';
import 'dart:developer';

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
          SearchBarView(
            onChanged: (value) {
              setState(() {
                currentQuery = value;
              });
              onSearchQuery(value);
            },
          ),
          SizedBox(height: 20.h),
          ResultView(
            onPressed: () {
              setState(() {
                isLoadMore = true;
              });
              context.read<SearchWallpaperCubit>().loadMore(currentQuery);
              log('resultview: $currentQuery');
            },
          ),
        ],
      ),
    );
  }
}
