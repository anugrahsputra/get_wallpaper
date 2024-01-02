import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../core/core.dart';
import '../../../data/categories_data.dart';
import '../../../data/data.dart';
import '../../presentation.dart';

part 'homepage.component.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with Wallpapers {
  bool userTapped = false;
  int currentPage = 1;
  String selectedCategory = 'All';
  List<Map<String, String>> category = categoryData;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getCuratedWallpaper(context, currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            const SliverAppBar(
              expandedHeight: 140,
              primary: false,
              flexibleSpace: FlexibleSpaceBar(
                background: _Header(),
              ),
            ),
            buildCategoryHeader(context),
            buildCategoryTitle(),
            buildListWallpaper(),
            buildLoadMoreBtn(context),
          ],
        ),
      ),
    );
  }

  Widget buildLoadMoreBtn(BuildContext context) {
    return SliverToBoxAdapter(
      child: FilledButton(
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
        onPressed: () {
          setState(
            () {
              currentPage++;
              wallpaperLoadMore(context, selectedCategory, currentPage);
            },
          );
        },
      ),
    );
  }

  Widget buildListWallpaper() {
    return SliverToBoxAdapter(
      child: userTapped
          ? const _ListCategorizedWallpaper()
          : const _ListCuratedWallpaper(),
    );
  }

  Widget buildCategoryTitle() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          selectedCategory,
          style: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget buildCategoryHeader(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: _SliverAppBarDelegate(
        minHeight: 50,
        maxHeight: 80,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: AppColor.backgroundDark,
            child: Row(
              children: category.map((cate) {
                return GestureDetector(
                  onTap: () {
                    DefaultCacheManager().removeFile('wallpaper');
                    setState(() {
                      userTapped = true;
                      selectedCategory = cate['name']!;
                      currentPage = 1;
                      debugPrint('userTapped: $userTapped');
                    });
                    final categoryName = cate['name']!;
                    if (categoryName == 'All') {
                      userTapped = false;
                      getCuratedWallpaper(context, currentPage);
                      debugPrint('back to curated');
                    } else {
                      getCategoryWallpaper(context, categoryName, currentPage);
                    }
                  },
                  child: _Category(
                    imageUrl: '${cate['image']}',
                    name: '${cate['name']}',
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
