import 'package:flutter/material.dart';

class SliverBar extends StatelessWidget {
  final double? expandedHeight;
  final Widget? title;
  final String? image;
  const SliverBar({super.key, this.expandedHeight, this.title, this.image});

  @override
  SliverAppBar build(BuildContext context) {
    return SliverAppBar(
      title: title,
      floating: true,
      snap: true,
      collapsedHeight: 56,
      expandedHeight: expandedHeight ?? 200,
      flexibleSpace: Stack(
        clipBehavior: Clip.none,
        children: [
          FlexibleSpaceBar(
            background: Image.asset(
              image ?? 'assets/bg/abstract-1.jpeg',
              fit: BoxFit.cover,
            ),
            stretchModes: const [
              StretchMode.zoomBackground,
              StretchMode.blurBackground,
              StretchMode.fadeTitle,
            ],
          ),
          Positioned(
            bottom: -15,
            left: 10,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          Positioned(
            bottom: -5,
            left: 46,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
      stretch: true,
    );
  }
}
