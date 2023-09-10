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

class _BuildSearchList extends StatelessWidget {
  const _BuildSearchList({required this.onPressed});

  final VoidCallback? onPressed;

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
          loaded: (result) => GridView.builder(
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
                    context.push('/detail/${wallpaper.id}');
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
          ),
          error: (message) => Center(
            child: Text(message),
          ),
        );
      }),
    );
  }
}
