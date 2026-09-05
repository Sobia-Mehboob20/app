import 'banquet_availability_screen.dart';
import 'package:flutter/material.dart';

class BanquetHallDetailsScreen extends StatelessWidget {
  final String hallName;
  final String image;
  final String capacity;
  final String price;

  const BanquetHallDetailsScreen({
    super.key,
    required this.hallName,
    required this.image,
    required this.capacity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),

      appBar: AppBar(
        backgroundColor: const Color(0xFF3F4A32),
        elevation: 0,
        title: const Text(
          'Hall Details',
          style: TextStyle(
            color: Color(0xFFF5F0E8),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFF5F0E8)),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- IMAGE ----------------

            Image.asset(
              image,
              height: 260,
              width: double.infinity,
              fit: BoxFit.cover,

              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 260,
                  width: double.infinity,
                  color: Colors.white,
                  child: const Icon(
                    Icons.image,
                    size: 80,
                    color: Color(0xFF3F4A32),
                  ),
                );
              },
            ),

            // ---------------- DETAILS ----------------
            Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hallName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3F4A32),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      const Icon(
                        Icons.people_outline,
                        color: Color(0xFF3F4A32),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        capacity,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(
                        Icons.payments_outlined,
                        color: Color(0xFF3F4A32),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // ---------------- ABOUT ----------------
                  const Text(
                    'About This Hall',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3F4A32),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Our elegant banquet hall is designed for memorable '
                    'celebrations and special events. With beautiful '
                    'interiors, comfortable seating and modern facilities, '
                    'it is an ideal venue for weddings, corporate events, '
                    'conferences and family celebrations.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ---------------- FACILITIES ----------------
                  const Text(
                    'Facilities',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3F4A32),
                    ),
                  ),

                  const SizedBox(height: 15),

                  _facilityItem(Icons.wifi, 'Free Wi-Fi'),

                  _facilityItem(Icons.mic, 'Sound System'),

                  _facilityItem(Icons.videocam, 'Projector & Screen'),

                  _facilityItem(Icons.local_parking, 'Parking Available'),

                  _facilityItem(Icons.celebration, 'Event Decoration'),

                  const SizedBox(height: 30),

                  // ---------------- BUTTON ----------------
                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton(
                      onPressed: () {
                        // We will connect the
                        // availability screen here next.import 'package:flutter/material.dart';
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BanquetAvailabilityScreen(
                              hallName: hallName,
                              image: image,
                              capacity: capacity,
                              price: price,
                            ),
                          ),
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3F4A32),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      child: const Text(
                        'Check Availability',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

  // ---------------- FACILITY ITEM ----------------

  static Widget _facilityItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),

      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF3F4A32), size: 22),

          const SizedBox(width: 12),

          Text(
            text,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
