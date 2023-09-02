import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_wallpaper/logic/detail_wallpaper/detail_wallpaper_cubit.dart';

class DetailWallpaper extends StatelessWidget {
  final int? id;
  const DetailWallpaper({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    context.read<DetailWallpaperCubit>().getWallpaperDetail(id!);
    return Scaffold(
        body: BlocBuilder<DetailWallpaperCubit, DetailWallpaperState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(
            child: CircularProgressIndicator(),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          loaded: (wallpaper) {
            return Stack(
              children: [
                Image.network(
                  wallpaper.src.portrait,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
          error: (message) => Center(
            child: Text(message),
          ),
        );
      },
    ));
  }
}
