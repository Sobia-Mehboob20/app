
import 'package:flutter/material.dart';

class Amenities extends StatefulWidget {
  const Amenities({super.key});

  @override
  State<Amenities> createState() => _AmenitiesState();
}

class _AmenitiesState extends State<Amenities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 60, 30,0),

        child: Column(
          children: [
            const Text(
              "What Our Hotel Provides",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "Enjoy our comfortable facilities and services",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 70),

            // Row 1
            Row(
              children: [
                Expanded(
                  child: amenityTile(
                    Icons.wifi,
                    "Free Wi-Fi",
                    "High-speed internet",
                  ),
                ),

                const SizedBox(width: 25),

                Expanded(
                  child: amenityTile(
                    Icons.local_parking,
                    "Parking",
                    "Safe parking for guests",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Row 2
            Row(
              children: [
                Expanded(
                  child: amenityTile(
                    Icons.pool,
                    "Swimming Pool",
                    "Relax and enjoy",
                  ),
                ),

                const SizedBox(width: 25),

                Expanded(
                  child: amenityTile(
                    Icons.fitness_center,
                    "Gym",
                    "Modern fitness facilities",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Row 3
            Row(
              children: [
                Expanded(
                  child: amenityTile(
                    Icons.local_laundry_service,
                    "Laundry Service",
                    "Convenient laundry service",
                  ),
                ),

                const SizedBox(width: 25),

                Expanded(
                  child: amenityTile(
                    Icons.room_service,
                    "Room Service",
                    "Service at your room",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Row 4
            Row(
              children: [
                Expanded(
                  child: amenityTile(
                    Icons.support_agent,
                    "24/7 Support",
                    "We're always here to help",
                  ),
                ),

                const Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget amenityTile(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Container(
      height: 75,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),

        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),

      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),

        leading: Icon(
          icon,
          color: const Color(0xFF3F4A32),
          size: 28,
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.black,
          ),
        ),

        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}

