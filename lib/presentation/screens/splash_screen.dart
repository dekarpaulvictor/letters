import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:letters/presentation/screens.dart';
import 'package:letters/utils/extensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
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
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(bottom: 20),
              child: const CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
