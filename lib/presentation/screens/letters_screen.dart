import 'package:flutter/material.dart';
import 'package:letters/presentation/presentation.dart'
    show SliverBar, LetterCard;

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
        SliverBar(
          title: Text(
            'Letters',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => LetterCard(),
            childCount: 10,
          ),
        ),
      ],
    ));
  }
}
