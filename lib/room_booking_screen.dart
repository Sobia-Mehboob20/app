import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomBookingDetails extends StatelessWidget {
  const RoomBookingDetails({super.key});

  // ================= FORMAT DATE =================

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

    return value.toString();
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),

      // ================= APP BAR =================

      appBar: AppBar(
        backgroundColor: const Color(0xFF3F4A32),
        foregroundColor: Colors.white,

        title: const Text(
          'Room Booking Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ================= FIRESTORE =================

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('bookings')
            .snapshots(),

        builder: (context, snapshot) {
          // LOADING
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // ERROR
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

          // NO DATA
          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'No bookings found',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          // ================= ONLY ROOM BOOKINGS =================

          final bookings = snapshot.data!.docs.where((doc) {
            final data =
                doc.data() as Map<String, dynamic>;

            return data['bookingType'] == 'Room';
          }).toList();

          // NO ROOM BOOKINGS
          if (bookings.isEmpty) {
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

          // ================= BOOKING LIST =================

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: bookings.length,

            itemBuilder: (context, index) {
              final booking = bookings[index];

              final data =
                  booking.data()
                      as Map<String, dynamic>;

              final status =
                  data['bookingStatus']
                      ?.toString() ??
                  'Pending';

              return Card(
                margin:
                    const EdgeInsets.only(bottom: 16),

                elevation: 4,

                color:
                    const Color(0xFFFAF8F3),

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(15),
                ),

                child: Padding(
                  padding:
                      const EdgeInsets.all(18),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      // ================= ROOM NAME =================

                      Text(
                        data['roomType']
                                ?.toString() ??
                            'Room',

                        style:
                            const TextStyle(
                          fontSize: 21,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              Color(0xFF3F4A32),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Room ID: '
                        '${data['roomId'] ?? '-'}',
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Hotel: '
                        '${data['hotelName'] ?? '-'}',
                      ),

                      const SizedBox(height: 15),

                      const Divider(),

                      const SizedBox(height: 10),

                      // ================= DATES =================

                      Text(
                        'Check-in: '
                        '${formatDate(data['checkIn'])}',
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Check-out: '
                        '${formatDate(data['checkOut'])}',
                      ),

                      const SizedBox(height: 8),

                      // ================= GUESTS =================

                      Text(
                        'Adults: '
                        '${data['adults'] ?? '-'}',
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Children: '
                        '${data['children'] ?? '-'}',
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Nights: '
                        '${data['nights'] ?? '-'}',
                      ),

                      const SizedBox(height: 15),

                      const Divider(),

                      const SizedBox(height: 10),

                      // ================= PRICE =================

                      Text(
                        'Price Per Night: PKR '
                        '${data['pricePerNight'] ?? 0}',
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Payment Method: '
                        '${data['paymentMethod'] ?? '-'}',
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Payment Status: '
                        '${data['paymentStatus'] ?? '-'}',
                      ),

                      const SizedBox(height: 12),

                      Text(
                        'Total Amount: PKR '
                        '${data['totalAmount'] ?? 0}',

                        style:
                            const TextStyle(
                          fontSize: 17,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              Color(0xFF3F4A32),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // ================= STATUS =================

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),

                        decoration:
                            BoxDecoration(
                          color: status ==
                                  'Confirmed'
                              ? Colors.green
                                  .shade100
                              : status ==
                                      'Rejected'
                                  ? Colors.red
                                      .shade100
                                  : Colors.orange
                                      .shade100,

                          borderRadius:
                              BorderRadius.circular(
                                  20),
                        ),

                        child: Text(
                          'Status: $status',

                          style:
                              TextStyle(
                            fontWeight:
                                FontWeight.bold,

                            color: status ==
                                    'Confirmed'
                                ? Colors.green
                                    .shade800
                                : status ==
                                        'Rejected'
                                    ? Colors.red
                                        .shade800
                                    : Colors.orange
                                        .shade800,
                          ),
                        ),
                      ),

                      // ================= CONFIRM BUTTON =================

                      if (status == 'Pending') ...[
                        const SizedBox(height: 15),

                        SizedBox(
                          width: double.infinity,

                          child:
                              ElevatedButton.icon(
                            onPressed: () async {
                              try {
                                await FirebaseFirestore
                                    .instance
                                    .collection(
                                        'bookings')
                                    .doc(
                                        booking.id)
                                    .update({
                                  'bookingStatus':
                                      'Confirmed',
                                });

                                if (context
                                    .mounted) {
                                  ScaffoldMessenger
                                      .of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Room booking confirmed successfully',
                                      ),
                                    ),
                                  );
                                }
                              } catch (e) {
                                if (context
                                    .mounted) {
                                  ScaffoldMessenger
                                      .of(context)
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

                            icon: const Icon(
                              Icons.check,
                            ),

                            label: const Text(
                              'Confirm Booking',
                              style: TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            style:
                                ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(
                                      0xFF3F4A32),

                              foregroundColor:
                                  Colors.white,

                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                vertical: 12,
                              ),

                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius
                                        .circular(
                                            10),
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