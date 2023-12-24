part of 'homepage.dart';

class _WallpaperView extends StatelessWidget {
  const _WallpaperView({
    required this.userTapped,
  });

  final bool userTapped;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: userTapped
          ? BlocBuilder<WallpapersBloc, WallpapersState>(
              builder: (context, state) {
                if (state is Loading) {
                  return const DefaultShimmerHome();
                } else if (state is CategoryLoaded) {
                  final result = state.wallpaper;
                  return _ListCategorizedWallpaper(result);
                } else {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                }
              },
            )
          : BlocBuilder<WallpapersBloc, WallpapersState>(
              builder: (context, state) {
                if (state is Loading) {
                  return const DefaultShimmerHome();
                } else if (state is CuratedLoaded) {
                  final result = state.wallpaper;
                  return _ListCuratedWallpaper(result);
                } else {
                  return const Center(
                    child: Text('Sometthing went wrong'),
                  );
                }
              },
            ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
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
}

class _Category extends StatelessWidget {
  const _Category({required this.imageUrl, required this.name});

  final String? imageUrl, name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 100.w,
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(10),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl!),
          fit: BoxFit.cover,
        ),
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
          name!,
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
    );
  }
}

class _ListCategorizedWallpaper extends StatelessWidget {
  const _ListCategorizedWallpaper(this.wallpaper);

  final List<Wallpaper> wallpaper;

  @override
  Widget build(BuildContext context) {
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
      itemCount: wallpaper.length,
      itemBuilder: (context, index) {
        final wallpapers = wallpaper[index];
        return GestureDetector(
          onTap: () {
            context.go('/detail/${wallpapers.id}');
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              wallpapers.src.portrait,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}

class _ListCuratedWallpaper extends StatelessWidget {
  final List<Wallpaper> wallpaper;
  const _ListCuratedWallpaper(this.wallpaper);

  @override
  Widget build(BuildContext context) {
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
      itemCount: wallpaper.length,
      itemBuilder: (context, index) {
        final wallpapers = wallpaper[index];
        return GestureDetector(
          onTap: () {
            context.go('/detail/${wallpapers.id}');
          },
          child: WallpaperCard(wallpapers: wallpapers),
        );
      },
    );
  }
}

class WallpaperCard extends StatelessWidget {
  WallpaperCard({
    super.key,
    required this.wallpapers,
  });

  final GlobalKey _imageKey = GlobalKey();
  final Wallpaper wallpapers;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: wallpapers,
      child: Flow(
        delegate: ParallaxFlowDelegate(
          scrollable: Scrollable.of(context),
          listItemContext: context,
          backgroundImageKey: _imageKey,
        ),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              wallpapers.src.portrait,
              fit: BoxFit.cover,
              key: _imageKey,
            ),
          ),
        ],
      ),
    );
  }
}
