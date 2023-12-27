part of 'homepage.dart';

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 100.h,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(14),
              bottomRight: Radius.circular(14),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 100.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(14),
              bottomRight: Radius.circular(14),
            ),
          ),
          child: Text(
            'Get Wallpaper',
            style: GoogleFonts.poppins(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        Positioned(
          top: 75.h,
          left: 20.w,
          right: 20.w,
          child: InkWell(
            onTap: () {
              context.push('/search');
            },
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
                  const Expanded(
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        filled: false,
                        hintText: 'Search wallpaper',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 20),
                      ),
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

class _ListCategorizedWallpaper extends StatelessWidget with GridViewMixin {
  const _ListCategorizedWallpaper();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WallpapersBloc, WallpapersState>(
      builder: (context, state) {
        if (state is Loading) {
          return const DefaultShimmerHome();
        } else if (state is CategoryLoaded) {
          final result = state.wallpaper;
          return buildGridView(result);
        } else {
          return const Center(
            child: Text("Something went wrong"),
          );
        }
      },
    );
  }
}

class _ListCuratedWallpaper extends StatelessWidget with GridViewMixin {
  const _ListCuratedWallpaper();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WallpapersBloc, WallpapersState>(
      builder: (context, state) {
        if (state is Loading) {
          return const DefaultShimmerHome();
        } else if (state is CuratedLoaded) {
          final result = state.wallpaper;
          return buildGridView(result);
        } else {
          return const Center(
            child: Text('Sometthing went wrong'),
          );
        }
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
