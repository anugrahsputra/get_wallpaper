import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_wallpaper/logic/categorized_wallpaper/categorized_wallpaper_cubit.dart';
import 'package:get_wallpaper/logic/list_wallpaper/list_wallpaper_cubit.dart';
import 'package:get_wallpaper/presentation/widgets/default_shimmer.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool userTapped = false;
  String selectedCategory = 'All';
  List<Map<String, String>> category = [
    {
      'name': 'Nature',
      'image':
          'https://images.pexels.com/photos/12879014/pexels-photo-12879014.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280'
    },
    {
      'name': 'Abstract',
      'image':
          'https://images.pexels.com/photos/2693208/pexels-photo-2693208.png?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280'
    },
    {
      'name': 'Animals',
      'image':
          'https://images.pexels.com/photos/158471/ibis-bird-red-animals-158471.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280'
    },
    {
      'name': 'Cars',
      'image':
          'https://images.pexels.com/photos/210019/pexels-photo-210019.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280'
    },
    {
      'name': 'City',
      'image':
          'https://images.pexels.com/photos/374870/pexels-photo-374870.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280'
    },
    {
      'name': 'Flowers',
      'image':
          'https://images.pexels.com/photos/462118/pexels-photo-462118.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280'
    },
    {
      'name': 'Food',
      'image':
          'https://images.pexels.com/photos/461198/pexels-photo-461198.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280'
    },
    {
      'name': 'Macro',
      'image':
          'https://images.pexels.com/photos/326055/pexels-photo-326055.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280'
    },
    {
      'name': 'Motorbikes',
      'image':
          'https://images.pexels.com/photos/235805/pexels-photo-235805.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280'
    },
    {
      'name': 'Music',
      'image':
          'https://images.pexels.com/photos/164829/pexels-photo-164829.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280'
    },
  ];

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
              _header(context),
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
                      child: Container(
                        height: 50.h,
                        width: 100.w,
                        margin: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(10),
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage('${cate['image']}'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '${cate['name']}',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                      ? buildListWallpaper()
                      : buildCuratedWallpaper()),
            ],
          ),
        ),
      ),
    );
  }

  buildListWallpaper() {
    return BlocBuilder<CategorizedWallpaperCubit, CategorizedWallpaperState>(
      builder: (context, state) {
        return state.when(
          initial: () => const DefaultShimmerHome(),
          loading: () => const DefaultShimmerHome(),
          loaded: (wallpapers) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: wallpapers.length,
              itemBuilder: (context, index) {
                final wallpaper = wallpapers[index];
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
              },
            );
          },
          error: (message) => Center(
            child: Text(message),
          ),
        );
      },
    );
  }

  Stack _header(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150.h,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        Container(
          height: 120.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Text(
              'Get Wallpaper',
              style: GoogleFonts.poppins(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ),
        Positioned(
          top: 90.h,
          left: 20.w,
          right: 20.w,
          child: Container(
            height: 50.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search wallpaper',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 20),
                    ),
                    onTap: () {
                      context.push('/search');
                    },
                    readOnly: true,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  buildCuratedWallpaper() {
    return BlocBuilder<ListWallpaperCubit, ListWallpaperState>(
      builder: (context, state) {
        return state.when(
          initial: () => const DefaultShimmerHome(),
          loading: () => const DefaultShimmerHome(),
          loaded: (wallpapers) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: wallpapers.length,
              itemBuilder: (context, index) {
                final wallpaper = wallpapers[index];
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
              },
            );
          },
          error: (message) => Center(
            child: Text(message),
          ),
        );
      },
    );
  }
}
