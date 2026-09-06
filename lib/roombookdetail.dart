import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomBookingDetails extends StatelessWidget {
  const RoomBookingDetails({super.key});

  String formatDate(Timestamp timestamp) {
    final date = timestamp.toDate();
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> confirmBooking(
    BuildContext context,
    String bookingId,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('roomBookings')
          .doc(bookingId)
          .update({
        'bookingStatus': 'Confirmed',
      });

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Room booking confirmed successfully',
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error confirming booking: $e',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),

      appBar: AppBar(
        backgroundColor: const Color(0xFF3F4A32),
        foregroundColor: Colors.white,
        title: const Text(
          'Room Booking Details',
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
            .collection('roomBookings')
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
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Error: ${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No room bookings found',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
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
                  data['bookingStatus'] ?? 'Pending';

              return Card(
                margin: const EdgeInsets.only(
                  bottom: 16,
                ),
                color: const Color(0xFFFAF8F3),

                elevation: 3,

                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(15),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(18),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      // Room Name
                      Text(
                        data['roomType'] ?? 'Room',

                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3F4A32),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Hotel Name
                      Text(
                        'Hotel: ${data['hotelName'] ?? 'Aurelia Grand'}',
                      ),

                      const SizedBox(height: 5),

                      // Room ID
                      Text(
                        'Room ID: ${data['roomId'] ?? '-'}',
                      ),

                      const SizedBox(height: 5),

                      // Check In
                      Text(
                        'Check-in: ${data['checkIn'] != null ? formatDate(data['checkIn']) : '-'}',
                      ),

                      const SizedBox(height: 5),

                      // Check Out
                      Text(
                        'Check-out: ${data['checkOut'] != null ? formatDate(data['checkOut']) : '-'}',
                      ),

                      const SizedBox(height: 5),

                      // Adults
                      Text(
                        'Adults: ${data['adults'] ?? 0}',
                      ),

                      const SizedBox(height: 5),

                      // Children
                      Text(
                        'Children: ${data['children'] ?? 0}',
                      ),

                      const SizedBox(height: 5),

                      // Nights
                      Text(
                        'Nights: ${data['nights'] ?? 0}',
                      ),

                      const SizedBox(height: 5),

                      // Price Per Night
                      Text(
                        'Price per Night: PKR ${data['pricePerNight'] ?? 0}',
                      ),

                      const SizedBox(height: 5),

                      // Total Amount
                      Text(
                        'Total Amount: PKR ${data['totalAmount'] ?? 0}',

                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 5),

                      // Payment Method
                      Text(
                        'Payment Method: ${data['paymentMethod'] ?? 'Not Paid'}',
                      ),

                      const SizedBox(height: 5),

                      // Payment Status
                      Text(
                        'Payment Status: ${data['paymentStatus'] ?? 'Pending'}',
                      ),

                      const SizedBox(height: 10),

                      // Booking Status
                      Text(
                        'Booking Status: $status',

                        style: TextStyle(
                          color: status == 'Confirmed'
                              ? Colors.green
                              : Colors.orange,

                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Confirm Button
                      if (status != 'Confirmed')
                        SizedBox(
                          width: double.infinity,

                          child: ElevatedButton(
                            onPressed: () {
                              confirmBooking(
                                context,
                                booking.id,
                              );
                            },

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
                              'Confirm Booking',

                              style: TextStyle(
                                fontSize: 16,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                      // Confirmed Message
                      if (status == 'Confirmed')
                        Container(
                          width: double.infinity,

                          padding:
                              const EdgeInsets.all(12),

                          decoration: BoxDecoration(
                            color:
                                Colors.green.shade50,

                            borderRadius:
                                BorderRadius.circular(
                              10,
                            ),
                          ),

                          child: const Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),

                              SizedBox(width: 8),

                              Text(
                                'Booking Confirmed',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ],
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