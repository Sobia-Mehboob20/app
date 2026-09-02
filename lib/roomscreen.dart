import 'package:flutter/material.dart';
import 'room_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  // Currently selected category
  String selectedCategory = 'All';

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
          'Rooms',
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

      // ---------------- BODY ----------------
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // Heading
            const Text(
              'Find Your Perfect Stay',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F4A32),
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Experience comfort and luxury at Aurelia Grand',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            // ---------------- CATEGORY BUTTONS ----------------

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: Row(
                children: [
                  categoryButton(
                    text: 'All',
                  ),

                  categoryButton(
                    text: 'Deluxe',
                  ),

                  categoryButton(
                    text: 'Suite',
                  ),

                  categoryButton(
                    text: 'Family',
                  ),

                  categoryButton(
                    text: 'Executive',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ---------------- FIREBASE ROOMS ----------------

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('rooms')
                  .snapshots(),

              builder: (context, snapshot) {
                // Loading
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // Error
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                    ),
                  );
                }

                // No rooms
                if (!snapshot.hasData ||
                    snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('No rooms found'),
                  );
                }

                // All Firebase rooms
                final allRooms = snapshot.data!.docs;

                // Filter rooms
                final rooms = selectedCategory == 'All'
                    ? allRooms
                    : allRooms.where((doc) {
                        final data =
                            doc.data() as Map<String, dynamic>;

                        return data['type'] ==
                            selectedCategory;
                      }).toList();

                // No room in selected category
                if (rooms.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Text(
                        'No rooms available in this category',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                }

                // Display rooms
                return Column(
                  children: rooms.map((doc) {
                    final data =
                        doc.data() as Map<String, dynamic>;

                    return Padding(
                      padding:
                          const EdgeInsets.only(bottom: 18),

                      child: roomCard(
                        context,

                        // Firebase document ID
                        roomId: doc.id,

                        // Local image
                        image: getRoomImage(data['type']),

                        // Firebase data
                        roomName:
                            data['roomName'] ?? 'Room',

                        rating:
                            '${data['rating'] ?? 0}',

                        price:
                            'PKR ${data['price'] ?? 0}',

                        description:
                            data['description'] ??
                                'No description available',
                      ),
                    );
                  }).toList(),
                );
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // GET ROOM IMAGE
  // =========================================================

  String getRoomImage(String? type) {
    switch (type) {
      case 'Deluxe':
        return 'assets/images/deluxe.jpg';

      case 'Suite':
        return 'assets/images/suite.jpg';

      case 'Family':
        return 'assets/images/family.jpg';

      case 'Executive':
        return 'assets/images/executive.jpg';

      default:
        return 'assets/images/deluxe.jpg';
    }
  }

  // =========================================================
  // CATEGORY BUTTON
  // =========================================================

  Widget categoryButton({
    required String text,
  }) {
    final bool selected =
        selectedCategory == text;

    return Container(
      margin: const EdgeInsets.only(right: 8),

      child: ElevatedButton(
        // Change selected category
        onPressed: () {
          setState(() {
            selectedCategory = text;
          });
        },

        style: ElevatedButton.styleFrom(
          backgroundColor: selected
              ? const Color(0xFF5A6545)
              : const Color(0xFFFAF8F3),

          foregroundColor: selected
              ? Colors.white
              : const Color(0xFF3F4A32),

          elevation: 0,

          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 12,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),

        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // =========================================================
  // ROOM CARD
  // =========================================================

  Widget roomCard(
    BuildContext context, {
    required String roomId,
    required String image,
    required String roomName,
    required String rating,
    required String price,
    required String description,
  }) {
    return Card(
      color: const Color(0xFFFAF8F3),

      elevation: 3,

      shadowColor: Colors.black26,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          // ---------------- ROOM IMAGE ----------------

          ClipRRect(
            borderRadius:
                const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),

            child: Image.asset(
              image,

              width: double.infinity,

              height: 200,

              fit: BoxFit.cover,
            ),
          ),

          // ---------------- ROOM INFORMATION ----------------

          Padding(
            padding: const EdgeInsets.all(15),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                // Room name
                Text(
                  roomName,

                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3F4A32),
                  ),
                ),

                const SizedBox(height: 7),

                // Rating
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Color(0xFFB89450),
                      size: 20,
                    ),

                    const SizedBox(width: 5),

                    Text(
                      rating,

                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 7),

                // Description
                Text(
                  description,

                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 12),

                // Price + Button
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  crossAxisAlignment:
                      CrossAxisAlignment.center,

                  children: [
                    // Price
                    Text(
                      '$price / night',

                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3F4A32),
                      ),
                    ),

                    // View Details
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (context) =>
                                RoomDetailScreen(
                              roomId: roomId,
                              image: image,
                              roomName: roomName,
                              rating: rating,
                              price: price,
                              description:
                                  description,
                            ),
                          ),
                        );
                      },

                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF5A6545),

                        foregroundColor:
                            Colors.white,

                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 11,
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
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}