import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HallBookingDetails extends StatelessWidget {
  const HallBookingDetails({super.key});

  // Safe date formatter
  String formatDate(dynamic value) {
    if (value == null) {
      return '-';
    }

    if (value is Timestamp) {
      final date = value.toDate();
      return '${date.day}/${date.month}/${date.year}';
    }

    if (value is DateTime) {
      return '${value.day}/${value.month}/${value.year}';
    }

    // If date is saved as String
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),

      appBar: AppBar(
        backgroundColor: const Color(0xFF3F4A32),
        title: const Text(
          'Hall Booking Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('hallBookings')
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
              child: Text(
                'Error: ${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No hall bookings found',
                style: TextStyle(fontSize: 18),
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

              final status =
                  data['status']?.toString() ?? 'Pending';

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

                      // Hall Name
                      Text(
                        data['hallName']?.toString() ?? 'Hall',
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3F4A32),
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        'Capacity: ${data['capacity'] ?? '-'}',
                      ),

                      const SizedBox(height: 7),

                      Text(
                        'Event Type: ${data['eventType'] ?? '-'}',
                      ),

                      const SizedBox(height: 7),

                      Text(
                        'Event Date: ${formatDate(data['eventDate'])}',
                      ),

                      const SizedBox(height: 7),

                      Text(
                        'Guests: ${data['guests'] ?? '-'}',
                      ),

                      const SizedBox(height: 7),

                      Text(
                        'Seating: ${data['seating'] ?? '-'}',
                      ),

                      const SizedBox(height: 7),

                      Text(
                        'Decoration: ${data['decoration'] ?? '-'}',
                      ),

                      const SizedBox(height: 15),

                      const Divider(),

                      const SizedBox(height: 10),

                      Text(
                        'Hall Price: PKR ${data['hallPrice'] ?? 0}',
                      ),

                      const SizedBox(height: 7),

                      Text(
                        'Decoration Price: PKR '
                        '${data['decorationPrice'] ?? 0}',
                      ),

                      const SizedBox(height: 7),

                      Text(
                        'Stage Price: PKR '
                        '${data['stagePrice'] ?? 0}',
                      ),

                      const SizedBox(height: 7),

                      Text(
                        'Sound Price: PKR '
                        '${data['soundPrice'] ?? 0}',
                      ),

                      const SizedBox(height: 12),

                      const Divider(),

                      const SizedBox(height: 10),

                      Text(
                        'Total Price: PKR '
                        '${data['totalPrice'] ?? 0}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3F4A32),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Status
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),

                        decoration: BoxDecoration(
                          color: status == 'Confirmed'
                              ? Colors.green.shade100
                              : Colors.orange.shade100,

                          borderRadius:
                              BorderRadius.circular(20),
                        ),

                        child: Text(
                          'Status: $status',
                          style: TextStyle(
                            color: status == 'Confirmed'
                                ? Colors.green.shade800
                                : Colors.orange.shade800,

                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Confirm Button
                      if (status != 'Confirmed') ...[
                        const SizedBox(height: 15),

                        SizedBox(
                          width: double.infinity,

                          child: ElevatedButton.icon(
                            onPressed: () async {
                              try {
                                await FirebaseFirestore
                                    .instance
                                    .collection('hallBookings')
                                    .doc(booking.id)
                                    .update({
                                  'status': 'Confirmed',
                                });

                                if (context.mounted) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Hall booking confirmed successfully',
                                      ),
                                    ),
                                  );
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Error: $e',
                                      ),
                                    ),
                                  );
                                }
                              }
                            },

                            icon: const Icon(Icons.check),

                            label: const Text(
                              'Confirm Booking',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF3F4A32),

                              foregroundColor: Colors.white,

                              padding:
                                  const EdgeInsets.symmetric(
                                vertical: 12,
                              ),

                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
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