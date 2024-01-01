import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

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
    _scrollController.addListener(_onScroll);
    getCuratedWallpaper(context, currentPage);
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
      context
          .read<WallpapersBloc>()
          .add(LoadMore(selectedCategory, currentPage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            const SliverAppBar(
              expandedHeight: 150.0,
              primary: false,
              flexibleSpace: FlexibleSpaceBar(
                background: _Header(),
              ),
            ),
            SliverPersistentHeader(
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
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    color: AppColor.backgroundDark,
                    child: Row(
                      children: category.map((cate) {
                        return GestureDetector(
                          onTap: () {
                            DefaultCacheManager().emptyCache();
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
                              getCategoryWallpaper(
                                  context, categoryName, currentPage);
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
            ),
            SliverToBoxAdapter(
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
            ),
            SliverToBoxAdapter(
              child: userTapped
                  ? const _ListCategorizedWallpaper()
                  : const _ListCuratedWallpaper(),
            ),
          ],
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
