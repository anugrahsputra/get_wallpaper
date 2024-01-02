part of 'search_page.dart';

class BuildSearchBar extends StatelessWidget {
  const BuildSearchBar({
    super.key,
    this.onSubmitted,
  });

  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: TextField(
        onSubmitted: onSubmitted,
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
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 0,
          ),
        ),
      ),
    );
  }
}

class SearchResults extends StatelessWidget with GridViewMixin {
  SearchResults({
    super.key,
    required this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.when(
          initial: () => Align(
            alignment: Alignment.center,
            child: Lottie.asset('assets/search_initials.json'),
          ),
          loading: () => const DefaultShimmerSearch(),
          loaded: (wallpaper) {
            if (wallpaper.isNotEmpty) {
              return Column(
                children: [
                  buildGridView(wallpaper),
                  const SizedBox(height: 10),
                  LoadMoreBtn(
                    onPressed: onPressed,
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text('No results found'),
              );
            }
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
