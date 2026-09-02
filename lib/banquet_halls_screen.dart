
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'banquet_hall_details_screen.dart';

class BanquetHallsScreen extends StatelessWidget {
  const BanquetHallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),

      // ---------------- APP BAR ----------------

      appBar: AppBar(
        backgroundColor: const Color(0xFF3F4A32),
        elevation: 0,
        centerTitle: true,

        title: const Text(
          'Banquet Halls',
          style: TextStyle(
            color: Color(0xFFF5F0E8),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Color(0xFFF5F0E8),
        ),
      ),

      // ---------------- FIRESTORE ----------------

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('banquetHalls')
            .snapshots(),

        builder: (context, snapshot) {

          // Loading
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF3F4A32),
              ),
            );
          }

          // Error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            );
          }

          // No data
          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No banquet halls found.',
                style: TextStyle(
                  fontSize: 17,
                  color: Color(0xFF3F4A32),
                ),
              ),
            );
          }

          final halls = snapshot.data!.docs;

          // ---------------- SCREEN CONTENT ----------------

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                const Text(
                  'Celebrate Your Special Moments',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3F4A32),
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Choose from our elegant banquet halls for weddings, '
                  'corporate events, conferences and celebrations.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 20),

                // ---------------- FIRESTORE HALLS ----------------

                ...halls.map((hall) {

                  final data =
                      hall.data() as Map<String, dynamic>;

                  final String hallName =
                      data['hallName'] ?? 'Unknown Hall';

                  final String capacity =
                      data['capacity'] ?? 'Capacity unavailable';

                  final dynamic priceValue =
                      data['price'] ?? 0;

                  final String type =
                      data['type'] ?? 'Banquet Hall';

                  final String description =
                      data['description'] ?? '';

                  final String image =
                      data['image'] ??
                          'assets/images/grand_ballroom.jpg';

                  final bool available =
                      data['available'] ?? true;

                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20,
                    ),

                    child: _buildHallCard(
                      context,

                      image: image,
                      hallName: hallName,
                      capacity: capacity,

                      price:
                          'Starting from PKR $priceValue',

                      type: type,
                      description: description,
                      available: available,
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }

  // ---------------- HALL CARD ----------------

  Widget _buildHallCard(
    BuildContext context, {
    required String image,
    required String hallName,
    required String capacity,
    required String price,
    required String type,
    required String description,
    required bool available,
  }) {
    return Card(
      color: Colors.white,
      elevation: 4,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      clipBehavior: Clip.antiAlias,

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          // ---------------- IMAGE ----------------

          Image.asset(
            image,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,

            errorBuilder:
                (context, error, stackTrace) {

              return Container(
                height: 200,
                width: double.infinity,
                color: Colors.white,

                child: const Icon(
                  Icons.image,
                  size: 70,
                  color: Color(0xFF3F4A32),
                ),
              );
            },
          ),

          // ---------------- INFORMATION ----------------

          Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  hallName,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3F4A32),
                  ),
                ),

                const SizedBox(height: 10),

                // Capacity

                Row(
                  children: [

                    const Icon(
                      Icons.people_outline,
                      size: 20,
                      color: Color(0xFF3F4A32),
                    ),

                    const SizedBox(width: 6),

                    Text(
                      capacity,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Price

                Row(
                  children: [

                    const Icon(
                      Icons.payments_outlined,
                      size: 20,
                      color: Color(0xFF3F4A32),
                    ),

                    const SizedBox(width: 6),

                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Availability

                Row(
                  children: [

                    Icon(
                      available
                          ? Icons.check_circle_outline
                          : Icons.cancel_outlined,

                      size: 20,

                      color: const Color(
                        0xFF3F4A32,
                      ),
                    ),

                    const SizedBox(width: 6),

                    Text(
                      available
                          ? 'Available'
                          : 'Currently Unavailable',

                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // ---------------- BUTTON ----------------

                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(
                    onPressed: available
                        ? () {

                            Navigator.push(
                              context,

                              MaterialPageRoute(
                                builder: (context) =>
                                    BanquetHallDetailsScreen(
                                  hallName: hallName,
                                  image: image,
                                  capacity: capacity,
                                  price: price,
                                ),
                              ),
                            );
                          }
                        : null,

                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF3F4A32),

                      foregroundColor:
                          Colors.white,

                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 13,
                      ),

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          10,
                        ),
                      ),
                    ),

                    child: const Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
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