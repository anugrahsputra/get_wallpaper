import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  String selectedCategory = 'All';
  List<Map<String, String>> category = categoryData;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      getCuratedWallpaper(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Header(),
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
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
                      getCategoryWallpaper(context, categoryName);
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
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Flexible(
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
