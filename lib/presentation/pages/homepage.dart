import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_wallpaper/logic/list_wallpaper/list_wallpaper_cubit.dart';
import 'package:get_wallpaper/presentation/pages/detail_wallpaper.dart';
import 'package:shimmer/shimmer.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
        child: BlocBuilder<ListWallpaperCubit, ListWallpaperState>(
          builder: (context, state) {
            return state.when(
              initial: () => _buildLoading(),
              loading: () => _buildLoading(),
              loaded: (wallpapers) {
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: wallpapers.length,
                  itemBuilder: (context, index) {
                    final wallpaper = wallpapers[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailWallpaper(id: wallpaper.id)));
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
        ),
      ),
    );
  }

  _buildLoading() {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 196, 196, 196),
            highlightColor: const Color.fromARGB(255, 241, 241, 241),
            child: Container(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
