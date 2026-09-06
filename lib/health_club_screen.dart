import 'package:flutter/material.dart';

class HealthClubScreen extends StatelessWidget {
  const HealthClubScreen({super.key});

  static const Color olive = Color(0xFF68744A);
  static const Color lightOlive = Color(0xFFE8EBDD);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Health Club',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: olive,
        foregroundColor: Colors.white,
         iconTheme: const IconThemeData(
          color: Color(0xFFF5F0E8),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ================= HERO IMAGE =================
            Image.asset(
              'assets/health_club/health_club.jpg',
              width: double.infinity,
              height: 1000,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 1000,
                  width: double.infinity,
                  color: lightOlive,
                  child: const Center(
                    child: Icon(
                      Icons.fitness_center,
                      size: 100,
                      color: olive,
                    ),
                  ),
                );
              },
            ),

            // ================= TITLE =================
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'AURELIA GRAND',
                    style: TextStyle(
                      color: olive,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Health Club',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Fitness • Wellness • Nutrition • Relaxation',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            // ================= PRICE CARD =================
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: lightOlive,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.payments_outlined,
                    color: olive,
                    size: 40,
                  ),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Health Club Access',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'PKR 10,000 per day',
                          style: TextStyle(
                            color: olive,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ================= DESCRIPTION =================
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Welcome to the Aurelia Grand Health Club, a premium fitness and wellness space designed to keep you active, refreshed and energized throughout your stay. The Health Club combines modern gym equipment, professional trainers, wellness activities and complimentary healthy refreshments in one comfortable environment.\n\n'
                'Guests can enjoy access to a wide range of major gym equipment, including treadmills, elliptical machines, stationary bikes, rowing machines, cross trainers, strength-training machines, cable machines, free weights, dumbbells, barbells, weight benches and functional training equipment. The gym is designed for both beginners and experienced fitness enthusiasts, allowing guests to follow their own workout routine in a clean and comfortable environment.\n\n'
                'Professional fitness trainers are available to guide guests with exercises, workout techniques and proper equipment usage. Trainers can help guests understand different exercises and maintain correct form during their workout sessions. Guests can also enjoy dedicated yoga sessions for stretching, flexibility, relaxation and mindfulness.\n\n'
                'The Health Club experience also includes complimentary welcome refreshments. Guests can enjoy fresh juices and energy boosters to stay refreshed before or after their workout. A selection of healthy gym food is also available inside the gym at no additional charge, including fresh fruits, protein shakes, assorted nuts and protein bars. These refreshments are provided to support guests with convenient and nutritious options during their fitness routine.\n\n'
                'The Health Club is more than just a gym. It provides a complete wellness experience where guests can exercise, relax, refresh and maintain their healthy lifestyle while staying at Aurelia Grand Hotel.',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ================= CATALOG TITLE =================
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'HEALTH CLUB CATALOG',
                style: TextStyle(
                  color: olive,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ================= CATALOG ITEMS =================
            _catalogCard(
              icon: Icons.fitness_center,
              title: 'Premium Gym Equipment',
              description:
                  'Treadmills, elliptical machines, stationary bikes, rowing machines, cross trainers, free weights, dumbbells, barbells, weight benches, cable machines and functional training equipment.',
            ),

            _catalogCard(
              icon: Icons.person,
              title: 'Professional Trainers',
              description:
                  'Experienced fitness trainers are available to assist guests with workouts, exercise techniques, equipment usage and proper workout form.',
            ),

            _catalogCard(
              icon: Icons.self_improvement,
              title: 'Yoga & Wellness',
              description:
                  'Yoga sessions designed for flexibility, stretching, relaxation, mindfulness and maintaining physical and mental wellness.',
            ),

            _catalogCard(
              icon: Icons.local_drink,
              title: 'Welcome Fresh Juices',
              description:
                  'Enjoy complimentary fresh juices and refreshing energy boosters as part of your Health Club experience.',
            ),

            _catalogCard(
              icon: Icons.apple,
              title: 'Complimentary Healthy Food',
              description:
                  'Fresh fruits, protein shakes, assorted nuts and protein bars are available inside the gym completely free of additional charges.',
            ),

            _catalogCard(
              icon: Icons.spa,
              title: 'Complete Wellness Experience',
              description:
                  'A comfortable and premium environment where guests can exercise, refresh, relax and maintain their fitness routine during their stay.',
            ),

            const SizedBox(height: 20),

            // ================= PAYMENT NOTICE =================
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: olive,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(18),
                color: Colors.white,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: olive,
                        size: 28,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Payment & Entrance',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: olive,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),

                  Text(
                    '• Health Club charges are PKR 10,000 per day.\n\n'
                    '• Payment will be made physically at the time of check-in at the reception desk.\n\n'
                    '• After completing check-in and payment, the guest will receive a Health Club entrance card from the reception desk.\n\n'
                    '• The entrance card should be presented when accessing the Health Club.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ================= BOTTOM BRANDING =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              color: olive,
              child: const Column(
                children: [
                  Text(
                    'AURELIA GRAND HOTEL',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your Stay, Your Wellness, Your Experience.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= CATALOG CARD =================
  static Widget _catalogCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            spreadRadius: 1,
            color: Colors.black.withOpacity(0.08),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: lightOlive,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: olive,
              size: 30,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}