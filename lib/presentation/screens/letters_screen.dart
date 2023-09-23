import 'package:flutter/material.dart';
import 'package:letters/models/letter.dart';
import 'package:letters/presentation/presentation.dart'
    show SliverBar, LetterCard;
import 'package:letters/services/services.dart' show LetterService;

class LettersScreen extends StatefulWidget {
  const LettersScreen({super.key});

  @override
  State<LettersScreen> createState() => _LettersScreenState();
}

class _LettersScreenState extends State<LettersScreen> {
  List<Letter> letters = [];
  bool isLoading = true;
  bool fetchState = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final data = await LetterService.getLetters();
      setState(() {
        letters = data.$1.reversed.toList();
        fetchState = data.$2;
        isLoading = false;
      });
    });
  }

  // if user pulls down to refresh, we want to fetch letters again
  Future<void> _refresh() {
    return Future.delayed(const Duration(seconds: 2), () async {
      // in this case, we omit setting new isLoading state to true 'coz
      // refresh indicator already shows a loading indicator
      // the list is reversed so that the latest letter is at the top

      final data = await LetterService.getLetters();
      setState(() {
        letters = data.$1.reversed.toList();
        fetchState = data.$2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
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
          if (isLoading)
            const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          if (!isLoading && !fetchState)
            SliverFillRemaining(
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
            ),
          if (!isLoading && fetchState)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => LetterCard(
                  letter: letters[index],
                ),
                childCount: letters.length,
              ),
            )
        ],
      ),
    );
  }
}
