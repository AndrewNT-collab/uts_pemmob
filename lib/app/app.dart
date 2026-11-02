import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';

class EFBSApp extends StatelessWidget {
  const EFBSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Endfield Blueprint System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF17191B),
      ),
      home: const HomeScreen(),
    );
  }
}