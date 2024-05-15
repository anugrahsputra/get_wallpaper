import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sizer/sizer.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../../domain/domain.dart';
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
  PackageInfo _packageInfo = PackageInfo(
    appName: 'unknown',
    packageName: 'unknown',
    version: 'unknown',
    buildNumber: 'unknown',
    buildSignature: 'unknown',
  );

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    getCuratedWallpaper(context, currentPage);
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = GoogleFonts.inter(
      color: Colors.white,
    );
    final ThemeData theme = Theme.of(context);
    final TextStyle textStyleTheme = theme.textTheme.bodyMedium!;
    final List<Widget> aboutBoxChildren = <Widget>[
      const SizedBox(height: 24),
      RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                style: textStyleTheme,
                text:
                    "Get Wallpaper is a mobile application built using Flutter. "
                    'It allows users to browse, download, and set wallpapers from the internet. '
                    'Learn more about the app at '),
            TextSpan(
                style: textStyle.copyWith(color: theme.colorScheme.primary),
                text: 'https://github.com/anugrahsputra/get_wallpaper'),
            TextSpan(style: textStyleTheme, text: '.'),
          ],
        ),
      ),
    ];

    return MultiBlocListener(
      listeners: [
        BlocListener<NetworkInfoBloc, NetworkInfoState>(
          listener: (context, state) {
            if (state is Offline) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      'It seems that you\'re disconnected.',
                      style: textStyle,
                    ),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 10),
                  ),
                );
            }
          },
        ),
      ],
      child: Scaffold(
        drawer: Drawer(
          width: MediaQuery.sizeOf(context).width * 0.8,
          child: SingleChildScrollView(
            child: SafeArea(
              child: AboutListTile(
                icon: const Icon(Icons.info_rounded),
                applicationIcon: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    'assets/icon/ic_launcher.png',
                    width: 40,
                  ),
                ),
                applicationName: _packageInfo.appName,
                applicationVersion: _packageInfo.version,
                applicationLegalese: "\u{a9} 2023 Anugrah Surya Putra",
                aboutBoxChildren: aboutBoxChildren,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: 130,
                primary: true,
                centerTitle: true,
                title: Text(
                  'Get Wallpaper',
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                flexibleSpace: const FlexibleSpaceBar(
                  background: _Header(),
                ),
              ),
              buildCategoryHeader(context),
              buildCategoryTitle(),
              buildListWallpaper(),
              buildLoadMoreBtn(context)
            ],
          ),
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
              children: List.generate(
                categoryData.length,
                (i) => GestureDetector(
                  onTap: () {
                    DefaultCacheManager().removeFile('wallpaper');
                    setState(() {
                      userTapped = true;
                      selectedCategory = categoryData[i]['name']!;
                      currentPage = 1;
                      debugPrint('userTapped: $userTapped');
                    });
                    final categoryName = categoryData[i]['name']!;
                    if (categoryName == 'All') {
                      userTapped = false;
                      getCuratedWallpaper(context, currentPage);
                      debugPrint('back to curated');
                    } else {
                      getCategoryWallpaper(context, categoryName, currentPage);
                    }
                  },
                  child: _Category(
                    imageUrl: '${categoryData[i]['image']}',
                    name: '${categoryData[i]['name']}',
                  ),
                ),
              ),
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
