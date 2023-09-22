import 'package:flutter/material.dart';
import 'package:letters/presentation/widgets/letter_card.dart';
import 'package:letters/presentation/widgets/sliverbar.dart';

class LetterScreen extends StatefulWidget {
  const LetterScreen({super.key});

  @override
  State<LetterScreen> createState() => _LetterScreenState();
}

class _LetterScreenState extends State<LetterScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: CustomScrollView(
      slivers: [
        const SliverBar(),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => const LetterCard(),
            childCount: 10,
          ),
        )
      ],
    ));
  }
}
