import 'package:flutter/material.dart';
import 'package:letters/models/letter.dart';
import 'package:letters/presentation/presentation.dart'
    show SliverBar, LetterCard;
import 'package:letters/services/services.dart' show LetterService;

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
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverBar(
          title: Text(
            'Letters',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        FutureBuilder<(List<Letter>, bool)>(
          future: LetterService.getLetters(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            }
            final data = snapshot.data;

            if (data == null || !data.$2) {
              return SliverFillRemaining(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline,
                          color: Theme.of(context).colorScheme.error),
                      const SizedBox(width: 8),
                      const Text('Error getting letters'),
                    ],
                  ),
                ),
              );
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => LetterCard(
                  letter: data.$1[index],
                ),
                childCount: data.$1.length,
              ),
            );
          },
        ),
      ],
    ));
  }
}
