import 'package:flutter/material.dart';
import 'package:letters/models/letter.dart';
import 'package:letters/presentation/presentation.dart' show SliverBar;
import 'package:letters/utils/extensions.dart';

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
                  // Back button
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(
                        widget.letter.image,
                      ),
                    ),
                    title: Text(
                      widget.letter.author,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    subtitle: Text(
                      widget.letter.date.format,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    trailing: Text(
                      '${widget.letter.timeToRead} min read',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
