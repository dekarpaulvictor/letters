import 'package:flutter/material.dart';
import 'package:letters/models/letter.dart';
import 'package:letters/presentation/widgets/sliverbar.dart';

class ViewLetterScreen extends StatefulWidget {
  final Letter letter;
  const ViewLetterScreen({super.key, required this.letter});

  @override
  State<ViewLetterScreen> createState() => _ViewLetterScreenState();
}

class _ViewLetterScreenState extends State<ViewLetterScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: [
          SliverBar(
            expandedHeight: 200,
            image: widget.letter.image,
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.letter.title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.letter.body,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${widget.letter.timeToRead} min read',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
