import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckInOutDetails extends StatelessWidget {
  const CheckInOutDetails({super.key});

  String formatDate(Timestamp timestamp) {
    final date = timestamp.toDate();
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),

      appBar: AppBar(
        backgroundColor: const Color(0xFF3F4A32),
        title: const Text(
          'Check-in / Check-out Details',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('roomBookings')
            .where(
              'checkOut',
              isGreaterThanOrEqualTo: Timestamp.now(),
            )
            .snapshots(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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
              child: Text(
                'No current check-in / check-out records found',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            );
          }

          final bookings = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: bookings.length,

            itemBuilder: (context, index) {
              final booking = bookings[index];

              final data =
                  booking.data() as Map<String, dynamic>;

              final status = data['status'] ?? '-';

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                color: const Color(0xFFFAF8F3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(18),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      Text(
                        data['roomName'] ?? 'Room',
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3F4A32),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        'Room ID: ${data['roomId'] ?? '-'}',
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Check-in: ${formatDate(data['checkIn'])}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Check-out: ${formatDate(data['checkOut'])}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Adults: ${data['adults'] ?? 0}',
                      ),

                      Text(
                        'Children: ${data['children'] ?? 0}',
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Status: $status',
                        style: TextStyle(
                          color: status == 'Confirmed'
                              ? Colors.green
                              : Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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