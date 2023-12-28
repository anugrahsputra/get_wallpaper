part of 'detail_wallpaper.dart';

class _WallpaperImage extends StatelessWidget {
  const _WallpaperImage({required this.src});

  final String? src;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      src!,
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
    );
  }
}

class _WallpaperDetails extends StatefulWidget {
  const _WallpaperDetails({
    required this.wallpaper,
  });

  final Wallpaper wallpaper;

  @override
  State<_WallpaperDetails> createState() => _WallpaperDetailsState();
}

class _WallpaperDetailsState extends State<_WallpaperDetails> {
  late bool goToHome;
  late WallpaperHandler _wallpaperHandler;
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    _wallpaperHandler = locator<WallpaperHandler>();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion = await _wallpaperHandler.getPlatformVersion();

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SetWallpaperBloc, SetWallpaperState>(
      listener: (context, state) {
        state.whenOrNull(
          wallpaperHome: (result) => context.pop(),
          wallpaperLock: (result) => context.pop(),
          wallpaperBoth: (result) => context.pop(),
          wallpaperError: (message) => ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.red,
              ),
            ),
        );
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 15.h),
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.wallpaper.alt,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Photo by ${widget.wallpaper.photographer}',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    DefaultDialog(context).dialog(
                      context,
                      wallpaper: widget.wallpaper,
                      text: 'Set Wallpaper for $_platformVersion',
                      content: state is WallpaperLoading
                          ? LoadingAnimationWidget.bouncingBall(
                              color: AppColor.onPrimaryContainerDark,
                              size: 25,
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SetAsButtonWidget(
                                  child: Text(
                                    'Home Screen',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  onPressed: () {
                                    context.read<SetWallpaperBloc>().add(
                                        SetHome(widget.wallpaper.src.portrait));
                                  },
                                ),
                                SizedBox(height: 5.h),
                                SetAsButtonWidget(
                                  child: Text(
                                    'Lock Screen',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  onPressed: () {
                                    context.read<SetWallpaperBloc>().add(
                                        SetLock(widget.wallpaper.src.portrait));
                                  },
                                ),
                                SizedBox(height: 5.h),
                                SetAsButtonWidget(
                                  child: Text(
                                    'Both',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  onPressed: () {
                                    context.read<SetWallpaperBloc>().add(
                                        SetBoth(widget.wallpaper.src.portrait));
                                  },
                                ),
                              ],
                            ),
                    );
                  },
                  child: Text(
                    'Set As Wallpaper',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
