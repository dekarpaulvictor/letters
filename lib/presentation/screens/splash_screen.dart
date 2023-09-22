import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:letters/presentation/presentation.dart' show LetterScreen;
import 'package:letters/utils/extensions.dart';

/// Splash Screen
///
/// This is the first screen that is shown when the app is launched. We can use
/// this to check if the user is logged in or not and then navigate to the
/// appropriate screen and also repair our cache, if needed.
///
/// Also note that we are using the [flutter_animate](https://pub.dev/packages/flutter_animate)
/// package to animate the text and the progress indicator.
///
/// Above functionalities are out of scope for this test. So we will just
/// navigate to the [LetterScreen] after a delay of 3 seconds.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    /// We ensure the navigation happens after the first frame is rendered.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        context.pushAndRemoveUntil(const LetterScreen());
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.primary,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => context.pushAndRemoveUntil(const LetterScreen()),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Letters.',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ).animate().fade().scale(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 24,
              height: 24,
              margin: const EdgeInsets.only(bottom: 20),
              child: const CircularProgressIndicator(
                color: Colors.white,
              )
                  .animate()
                  .then(
                    duration: const Duration(seconds: 2),
                  )
                  .swap(
                    builder: (context, child) =>
                        const Icon(Icons.check).animate().shimmer(
                      colors: [
                        Colors.white,
                        Theme.of(context).colorScheme.primary,
                      ],
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
