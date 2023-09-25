import 'package:flutter/material.dart';
import 'package:letters/models/letter.dart';
import 'package:letters/presentation/presentation.dart' show ViewLetterScreen;
import 'package:letters/utils/extensions.dart';

class LetterCard extends StatelessWidget {
  const LetterCard({super.key, required this.letter});

  final Letter letter;

  @override
  Widget build(BuildContext context) {
    final summary = letter.body
        .substring(100, letter.body.length > 200 ? 200 : letter.body.length);
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
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: context.width * 0.7,
                  ),
                  child: Text(
                    letter.title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const Spacer(),
                Text(
                  '${letter.timeToRead} min read',
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
              '${letter.body.substring(0, 100)}...',
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
                  placeholder:
                      const AssetImage("assets/images/abstract-1.jpeg"),
                  image: NetworkImage(
                    letter.image,
                  ),
                  imageErrorBuilder: (_, __, ___) => SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Error loading image',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.red,
                                ),
                          ),
                        ],
                      )),
                  placeholderErrorBuilder: (_, __, ___) => const SizedBox(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              '$summary...',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          // TextButton
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GestureDetector(
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
          ),
          const Divider(),
        ],
      ),
    );
  }
}
