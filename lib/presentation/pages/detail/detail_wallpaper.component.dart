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
        if (state is WallpaperError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.fromLTRB(5.w, 5.h, 5.w, 5.h),
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
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buildSetAsButton('Home Screen'),
                          SizedBox(height: 5.h),
                          buildSetAsButton('Lock Screen'),
                          SizedBox(height: 5.h),
                          buildSetAsButton('Both Screen'),
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

  Widget buildSetAsButton(String text) {
    return SetAsButtonWidget(
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
      onPressed: () {
        context.read<SetWallpaperBloc>().add(text == 'Home Screen'
            ? SetHome(widget.wallpaper.src.portrait)
            : text == 'Lock Screen'
                ? SetLock(widget.wallpaper.src.portrait)
                : SetBoth(widget.wallpaper.src.portrait));
        context.pop();
      },
    );
  }
}
