part of 'search_page.dart';

class _BuildSearchBar extends StatelessWidget {
  const _BuildSearchBar({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search wallpaper',
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 0,
          ),
        ),
      ),
    );
  }
}

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.when(
          initial: () {
            return Lottie.asset(
              'assets/search_initials.json',
              repeat: false,
            );
          },
          loading: () {
            return const DefaultShimmerSearch();
          },
          loaded: (wallpaper) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: wallpaper.length - 1,
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
          },
          error: (message) {
            return Center(
              child: Text(message),
            );
          },
        );
      },
    );
  }
}

class _BuildGridView extends StatelessWidget {
  const _BuildGridView({
    required this.onPressed,
    required this.result,
  });

  final void Function()? onPressed;
  final List<Wallpaper> result;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: result.length + 1,
      itemBuilder: (context, index) {
        if (index < result.length) {
          final wallpaper = result[index];
          return GestureDetector(
            onTap: () {
              context.go('/detail/${wallpaper.id}');
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                wallpaper.src.portrait,
                fit: BoxFit.cover,
              ),
            ),
          );
        } else {
          return Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[200],
              child: TextButton(
                onPressed: onPressed,
                child: const Text('Load More'),
              ),
            ),
          );
        }
      },
    );
  }
}

class SearchBarView extends StatefulWidget {
  const SearchBarView({super.key, required this.onChanged});

  final dynamic Function(String) onChanged;

  @override
  State<SearchBarView> createState() => _SearchBarViewState();
}

class _SearchBarViewState extends State<SearchBarView> {
  final TextEditingController _searchCtrl = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  Timer? debounce;

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(() {
      setState(() {});
    });
    clearSearch();
  }

  void onSearchQuery(String query) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<SearchWallpaperCubit>().searchWallpaper(query);
    });
  }

  void searchQuery(String query) {
    if (_searchCtrl.text.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 500), () {
        context.read<SearchWallpaperCubit>().searchWallpaper(query);
      });
    } else {
      clearSearch();
    }
  }

  void clearSearch() {
    setState(() {
      _searchCtrl.clear();
      context.read<SearchWallpaperCubit>().clearSearch();
    });
  }

  @override
  void dispose() {
    debounce?.cancel();
    _searchFocus.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              clearSearch();
              context.pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          _BuildSearchBar(
            controller: _searchCtrl,
            focusNode: _searchFocus,
            onChanged: widget.onChanged,
          ),
          if (_searchCtrl.text.isNotEmpty)
            IconButton(
              onPressed: () => clearSearch(),
              icon: const Icon(Icons.clear),
            ),
        ],
      ),
    );
  }
}

class ResultView extends StatefulWidget {
  const ResultView({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  bool isLoadMore = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<SearchWallpaperCubit, SearchWallpaperState>(
          builder: (context, state) {
        return state.when(
          initial: () => Lottie.asset(
            'assets/search_initials.json',
            repeat: false,
          ),
          loading: () => const DefaultShimmerSearch(),
          loaded: (result) => _BuildGridView(
            onPressed: widget.onPressed,
            result: result,
          ),
          error: (message) => Center(
            child: Text(message),
          ),
        );
      }),
    );
  }
}
