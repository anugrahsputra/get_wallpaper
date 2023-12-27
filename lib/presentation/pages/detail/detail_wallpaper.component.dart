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

class _WallpaperDetailsState extends State<_WallpaperDetails>
    with SetAsWallpaperMixin {
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
                  text: 'Set Wallpaper for $platformVersion',
                  children: [
                    SetAsButtonWidget(
                      child: wallpaperUrlHome == 'Loading'
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
                      child: wallpaperUrlLock == 'Loading'
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
                      child: wallpaperUrlBoth == 'Loading'
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
