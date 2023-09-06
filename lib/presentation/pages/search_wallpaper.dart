import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_wallpaper/presentation/presentation.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

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
      context.read<SearchWallpaperCubit>().clearSearch();
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
                Expanded(
                  child: TextField(
                    controller: _searchCtrl,
                    focusNode: _searchFocus,
                    onChanged: (value) {
                      setState(() {
                        currentQuery = value;
                      });
                      onSearchQuery(currentQuery);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search wallpaper',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 0,
                      ),
                    ),
                  ),
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
          buildSearchList(),
        ],
      ),
    );
  }

  buildSearchList() {
    return Expanded(
      child: BlocBuilder<SearchWallpaperCubit, SearchWallpaperState>(
          builder: (context, state) {
        return state.when(
          initial: () => Lottie.asset(
            'assets/search_initials.json',
            repeat: false,
          ),
          loading: () => const DefaultShimmerSearch(),
          loaded: (result) => GridView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: result.length + 1,
            itemBuilder: (context, index) {
              if (index < result.length) {
                final wallpaper = result[index];
                return GestureDetector(
                  onTap: () {
                    context.push('/detail/${wallpaper.id}');
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      wallpaper.src.portrait,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[200],
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          isLoadMore = true;
                        });
                        context
                            .read<SearchWallpaperCubit>()
                            .loadMore(currentQuery);
                      },
                      child: const Text('Load More'),
                    ),
                  ),
                );
              }
            },
          ),
          error: (message) => Center(
            child: Text(message),
          ),
        );
      }),
    );
  }
}
