import 'package:flutter/material.dart';
import 'our_story_screen.dart';
import 'restaurants_screen.dart';
import 'official_conferences.dart';
import 'decorations_screen.dart';
import 'health_club_screen.dart';
import 'customer_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aurelia Grand Hotel',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF68744A),
        ),
        useMaterial3: true,
      ),

      home: const CustomerDashboard(),

      routes: {
        '/customer-dashboard': (context) =>
            const CustomerDashboard(),

        '/our-story': (context) =>
            const OurStoryScreen(),

        '/restaurants': (context) =>
            const RestaurantsScreen(),

        '/official-conferences': (context) =>
            const OfficialConferences(),

        '/decorations': (context) =>
            const DecorationsScreen(),

        '/health-club': (context) =>
            const HealthClubScreen(),
      },
    );
  }
}