import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DefaultShimmerHome extends StatelessWidget {
  const DefaultShimmerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 196, 196, 196),
            highlightColor: const Color.fromARGB(255, 241, 241, 241),
            child: Container(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}

class DefaultShimmerSearch extends StatelessWidget {
  const DefaultShimmerSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 196, 196, 196),
            highlightColor: const Color.fromARGB(255, 241, 241, 241),
            child: Container(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
