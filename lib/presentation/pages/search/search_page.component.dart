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
