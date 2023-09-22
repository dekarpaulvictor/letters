import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'presentation/presentation.dart' show SplashScreen;

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Letters',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.light, seedColor: Colors.teal),
        useMaterial3: true,
        textTheme: GoogleFonts.nunitoTextTheme(),
      ),
      home: const SplashScreen(),
    );
  }
}
