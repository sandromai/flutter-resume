import 'package:business_card/screens/home_screen.dart';
import 'package:business_card/utils/app_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Business Card',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: AppColors.primary)),
      home: const HomeScreen(),
    );
  }
}
