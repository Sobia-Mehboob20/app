import 'package:flutter/material.dart';
import 'check_availability_screen.dart';

class RoomDetailScreen extends StatelessWidget {
  final String roomId;
  final String image;
  final String roomName;
  final String rating;
  final String price;
  final String description;
   
  const RoomDetailScreen({
    super.key,
    required this.roomId,
    required this.image,
    required this.roomName,
    required this.rating,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: const Color(0xFF3F4A32),
        elevation: 0,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFF5F0E8)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Room Details',
          style: TextStyle(
            color: Color(0xFFF5F0E8),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,
      ),

      // ================= BODY =================
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= ROOM IMAGE =================

            Padding(
              padding: const EdgeInsets.all(16),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),

                child: Image.asset(
                  image,

                  width: double.infinity,

                  height: 230,

                  fit: BoxFit.cover,

                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 230,
                      width: double.infinity,
                      color: Colors.grey.shade300,

                      child: const Icon(
                        Icons.hotel,
                        size: 70,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),

            // ================= ROOM NAME + PRICE =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // Room name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        roomName,

                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3F4A32),
                        ),
                      ),

                      const SizedBox(height: 5),

                       Text(
                        'Room $roomId',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),

                  // Price
                  Text(
                    price,

                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5A6545),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ================= RATING =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),

              child: Row(
                children: [
                  const Icon(Icons.star, color: Color(0xFFB89450), size: 20),

                  const SizedBox(width: 5),

                  Text(
                    rating,

                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(width: 7),

                  const Text(
                    '(124 Reviews)',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ================= ROOM DETAILS =================
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),

              child: Text(
                'Room Details',

                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F4A32),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ================= FEATURES =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: [
                  roomFeature(Icons.bed, 'King Bed'),

                  roomFeature(Icons.people, '2 Guests'),

                  roomFeature(Icons.square_foot, '35 m²'),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ================= DESCRIPTION =================
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),

              child: Text(
                'Description',

                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F4A32),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),

              child: Text(
                description,

                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ================= AMENITIES =================
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),

              child: Text(
                'Amenities',

                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F4A32),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),

              child: Wrap(
                spacing: 10,
                runSpacing: 10,

                children: [
                  amenity(Icons.wifi, 'Free Wi-Fi'),

                  amenity(Icons.tv, 'Smart TV'),

                  amenity(Icons.ac_unit, 'Air Conditioning'),

                  amenity(Icons.local_parking, 'Parking'),

                  amenity(Icons.room_service, 'Room Service'),

                  amenity(Icons.coffee, 'Coffee'),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ================= BOOK NOW =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),

              child: SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckAvailabilityScreen(
                           roomId: roomId,
                          roomName: roomName,
                          price: price,
                          image: image,
                        ),
                      ),
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A6545),

                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),

                  child: const Text(
                    'Check Availability',

                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // ROOM FEATURE
  // =====================================================

  static Widget roomFeature(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF5A6545), size: 28),

        const SizedBox(height: 6),

        Text(text, style: const TextStyle(fontSize: 13)),
      ],
    );
  }

  // =====================================================
  // AMENITY
  // =====================================================

  static Widget amenity(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),

      decoration: BoxDecoration(
        color: const Color(0xFFFAF8F3),

        borderRadius: BorderRadius.circular(12),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,

        children: [
          Icon(icon, size: 19, color: const Color(0xFF5A6545)),

          const SizedBox(width: 6),

          Text(text, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
