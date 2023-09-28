import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/categories_data.dart';
import '../../../data/data.dart';
import '../../presentation.dart';

part 'homepage.component.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool userTapped = false;
  String selectedCategory = 'All';
  List<Map<String, String>> category = categoryData;

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      _getData();
      setState(() {});
    }
  }

  _getData() {
    context.read<ListWallpaperCubit>().getWallpaper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Header(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: category.map((cate) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          userTapped = true;
                          selectedCategory = cate['name']!;
                        });
                        final categoryName = cate['name']!;
                        context
                            .read<CategorizedWallpaperCubit>()
                            .categoryWallpaper(categoryName);
                      },
                      child: _Category(
                        imageUrl: '${cate['image']}',
                        name: '${cate['name']}',
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  selectedCategory,
                  style: GoogleFonts.inter(
                      fontSize: 20.sp, fontWeight: FontWeight.w600),
                ),
              ),
              Flexible(
                child: userTapped
                    ? BlocBuilder<CategorizedWallpaperCubit,
                        CategorizedWallpaperState>(
                        builder: (context, state) {
                          return state.when(
                            initial: () => const DefaultShimmerHome(),
                            loading: () => const DefaultShimmerHome(),
                            loaded: (wallpapers) =>
                                _ListCategorizedWallpaper(wallpapers),
                            error: (message) => Center(
                              child: Text(message),
                            ),
                          );
                        },
                      )
                    : BlocBuilder<ListWallpaperCubit, ListWallpaperState>(
                        builder: (context, state) {
                          return state.when(
                            initial: () => const DefaultShimmerHome(),
                            loading: () => const DefaultShimmerHome(),
                            loaded: (wallpapers) => _ListCuratedWallpaper(
                              wallpapers,
                            ),
                            error: (message) => Center(
                              child: Text(message),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
