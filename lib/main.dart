import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';
import 'loginScreen.dart';
import 'receptionist.dart';
import 'role.dart';
import 'roomscreen.dart';
import 'banquet_halls_screen.dart';
import 'special_offers_screen.dart';
import 'manager_dashboard.dart';

import 'our_story_screen.dart';
import 'restaurants_screen.dart';
import 'official_conferences.dart';
import 'decorations_screen.dart';
import 'health_club_screen.dart';
import 'customer_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const AureliaGrandApp());
}

class AureliaGrandApp extends StatelessWidget {
  const AureliaGrandApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aurelia Grand Hotel',

      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F0E8),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5A6545),
        ),
      ),

      home: const SplashScreen(),

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

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Role(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/logo.jpg',
              width: 200,
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            "AURELIA HOTEL",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5A6545),
            ),
          ),
        ],
      ),
    );
  }
}

class TemporaryHomeScreen extends StatelessWidget {
  const TemporaryHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F0E8),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Aurelia Grand',
          style: TextStyle(
            color: Color(0xFF3F4A32),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Aurelia Grand',
                style: TextStyle(
                  color: Color(0xFF3F4A32),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Hotel • Events • Dining • Wellness',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const RoomsScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.hotel),
                  label: const Text('Rooms'),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const BanquetHallsScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.celebration),
                  label: const Text('Banquet Halls'),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const SpecialOffersScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.local_offer),
                  label: const Text('Special Offers'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Rooms'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('rooms')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No rooms found'),
            );
          }

          final rooms = snapshot.data!.docs;

          return ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final room = rooms[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(
                    Icons.hotel,
                    size: 35,
                  ),
                  title: Text(
                    'Room ${room['roomNumber']}',
                  ),
                  subtitle: Text(
                    'Type: ${room['type']}\n'
                    'Price: ${room['price']}\n'
                    'Status: ${room['status']}',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}