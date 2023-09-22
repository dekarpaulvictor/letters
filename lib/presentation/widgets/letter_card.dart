import 'package:flutter/material.dart';
import 'package:letters/models/letter.dart';
import 'package:letters/presentation/presentation.dart' show ViewLetterScreen;
import 'package:letters/utils/extensions.dart';

class LetterCard extends StatelessWidget {
  const LetterCard({super.key, required this.letter});

  final Letter letter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
              children: [
                Text(
                  'This is exciting',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                Text(
                  '2 min read',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            height: 150,
            width: context.width,
            child: Align(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: FadeInImage(
                  placeholder: const AssetImage("assets/bg/abstract-1.jpeg"),
                  image: const NetworkImage(
                    "https://images.unsplash.com/photo-1517991104123-1d56a6e81ed9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80",
                  ),
                  imageErrorBuilder: (_, __, ___) => const SizedBox(),
                  placeholderErrorBuilder: (_, __, ___) => const SizedBox(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod, nisl eget aliquam ultricies, nunc nisl ultricies nunc, eget aliquam nisl nisl eget nisl.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          // TextButton
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => context.push(
                    ViewLetterScreen(
                      letter: letter,
                    ),
                  ),
                  child: Text(
                    "Read more",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => context.showSnackBar("Added to favorites"),
                  child: Icon(
                    Icons.favorite_border,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () => context.showSnackBar("Added to bookmarks"),
                  child: Icon(
                    Icons.bookmark_border,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
