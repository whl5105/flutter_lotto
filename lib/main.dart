import 'package:flutter/material.dart';
import 'package:flutter_lotto/screens/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Pretendard',
        useMaterial3: false,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontWeight: FontWeight.w400), //Regular
        ),
      ),
      home: const HomeScreen(),
    );
  }
}