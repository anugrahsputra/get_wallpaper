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
    Key? key,
    required this.wallpaper,
  }) : super(key: key);

  final Wallpaper wallpaper;

  @override
  State<_WallpaperDetails> createState() => _WallpaperDetailsState();
}

class _WallpaperDetailsState extends State<_WallpaperDetails> {
  late bool goToHome;
  late WallpaperHandler _wallpaperHandler;
  String _platformVersion = 'Unknown';
  String _wallpaperUrlHome = 'Unknown';
  String _wallpaperUrlLock = 'Unknown';
  String _wallpaperUrlBoth = 'Unknown';

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

  Future<void> setWallpaperHome(String url) async {
    setState(() {
      _wallpaperUrlHome = 'Loading';
    });

    String result =
        await _wallpaperHandler.setAsWallpaper(url, AsyncWallpaper.HOME_SCREEN);

    if (!mounted) return;

    setState(() {
      _wallpaperUrlHome = result;
    });
  }

  Future<void> setWallpaperLock(String url) async {
    setState(() {
      _wallpaperUrlLock = 'Loading';
    });
    String result =
        await _wallpaperHandler.setAsWallpaper(url, AsyncWallpaper.LOCK_SCREEN);

    if (!mounted) return;

    setState(() {
      _wallpaperUrlLock = result;
    });
  }

  Future<void> setWallpaperBoth(String url) async {
    setState(() {
      _wallpaperUrlBoth = 'Loading';
    });
    String result = await _wallpaperHandler.setAsWallpaper(
        url, AsyncWallpaper.BOTH_SCREENS);

    if (!mounted) return;

    setState(() {
      _wallpaperUrlBoth = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 15.h),
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height * 0.4,
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
                  children: [
                    SetAsButtonWidget(
                      child: _wallpaperUrlHome == 'Loading'
                          ? const CircularProgressIndicator.adaptive()
                          : Text(
                              'Home Screen',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                      onPressed: () {
                        setWallpaperHome(widget.wallpaper.src.portrait);
                        context.pop();
                      },
                    ),
                    SizedBox(height: 5.h),
                    SetAsButtonWidget(
                      child: _wallpaperUrlLock == 'Loading'
                          ? const CircularProgressIndicator.adaptive()
                          : Text(
                              'Lock Screen',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                      onPressed: () {
                        setWallpaperLock(widget.wallpaper.src.portrait);
                        context.pop();
                      },
                    ),
                    SizedBox(height: 5.h),
                    SetAsButtonWidget(
                      child: _wallpaperUrlBoth == 'Loading'
                          ? const CircularProgressIndicator.adaptive()
                          : Text(
                              'Both',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                      onPressed: () {
                        setWallpaperBoth(widget.wallpaper.src.portrait);
                        context.pop();
                      },
                    ),
                  ],
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
  }
}
