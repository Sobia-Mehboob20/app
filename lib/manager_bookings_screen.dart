
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManagerBookingsScreen extends StatelessWidget {
  const ManagerBookingsScreen({super.key});

  static const Color green = Color(0xFF3F4A32);
  static const Color background = Color(0xFFF5F0E8);

  String formatDate(dynamic value) {
    if (value is Timestamp) {
      final date = value.toDate();
      return '${date.day}/${date.month}/${date.year}';
    }

    if (value is DateTime) {
      return '${value.day}/${value.month}/${value.year}';
    }

    return '-';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Bookings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFFF5F0E8),
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('roomBookings')
            .snapshots(),

        builder: (context, roomSnapshot) {
          if (roomSnapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (roomSnapshot.hasError) {
            return Center(
              child: Text(
                'Error loading room bookings\n${roomSnapshot.error}',
              ),
            );
          }

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('hallBookings')
                .snapshots(),

            builder: (context, hallSnapshot) {
              if (hallSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (hallSnapshot.hasError) {
                return Center(
                  child: Text(
                    'Error loading hall bookings\n${hallSnapshot.error}',
                  ),
                );
              }

              final roomBookings =
                  roomSnapshot.data?.docs ?? [];

              final hallBookings =
                  hallSnapshot.data?.docs ?? [];

              if (roomBookings.isEmpty &&
                  hallBookings.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        size: 65,
                        color: green,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'No Bookings Available',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: green,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Customer bookings will appear here.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // ---------------- ROOM BOOKINGS ----------------

                  if (roomBookings.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Text(
                        'Room Bookings',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: green,
                        ),
                      ),
                    ),

                  ...roomBookings.map((doc) {
                    final data =
                        doc.data() as Map<String, dynamic>;

                    return _roomBookingCard(data);
                  }),

                  // ---------------- HALL BOOKINGS ----------------

                  if (hallBookings.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 15,
                        bottom: 12,
                      ),
                      child: Text(
                        'Banquet Hall Bookings',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: green,
                        ),
                      ),
                    ),

                  ...hallBookings.map((doc) {
                    final data =
                        doc.data() as Map<String, dynamic>;

                    return _hallBookingCard(data);
                  }),
                ],
              );
            },
          );
        },
      ),
    );
  }

  // ============================================================
  // ROOM BOOKING CARD
  // ============================================================

  Widget _roomBookingCard(
      Map<String, dynamic> booking) {
    final String roomType =
        booking['roomType']?.toString() ?? 'Room';

    final String hotelName =
        booking['hotelName']?.toString() ??
            'Aurelia Grand';

    final String checkIn =
        formatDate(booking['checkIn']);

    final String checkOut =
        formatDate(booking['checkOut']);

    final String nights =
        booking['nights']?.toString() ?? '0';

    final String paymentStatus =
        booking['paymentStatus']?.toString() ??
            'Pending';

    final String bookingStatus =
        booking['bookingStatus']?.toString() ??
            'Pending';

    final dynamic amount =
        booking['totalAmount'] ?? 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color:
                        green.withValues(alpha: 0.1),
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.hotel,
                    color: green,
                    size: 25,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        roomType,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                          color: green,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        hotelName,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),

                _statusBadge(bookingStatus),
              ],
            ),

            const SizedBox(height: 18),
            const Divider(),
            const SizedBox(height: 10),

            _bookingInfo(
              Icons.login,
              'Check-in',
              checkIn,
            ),

            const SizedBox(height: 10),

            _bookingInfo(
              Icons.logout,
              'Check-out',
              checkOut,
            ),

            const SizedBox(height: 10),

            _bookingInfo(
              Icons.nights_stay_outlined,
              'Nights',
              nights,
            ),

            const SizedBox(height: 10),

            _bookingInfo(
              Icons.payment_outlined,
              'Payment',
              paymentStatus,
            ),

            const SizedBox(height: 15),

            _totalAmount(amount),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HALL BOOKING CARD
  // ============================================================

  Widget _hallBookingCard(
      Map<String, dynamic> booking) {
    final String hallName =
        booking['hallName']?.toString() ??
            'Banquet Hall';

    final String hotelName =
        booking['hotelName']?.toString() ??
            'Aurelia Grand';

    final String eventType =
        booking['eventType']?.toString() ?? '-';

    final String eventDate =
        formatDate(booking['eventDate']);

    final String guests =
        booking['guests']?.toString() ?? '0';

    final String seating =
        booking['seating']?.toString() ?? '-';

    final String decoration =
        booking['decoration']?.toString() ?? '-';

    final String paymentStatus =
        booking['paymentStatus']?.toString() ??
            'Pending';

    final String bookingStatus =
        booking['bookingStatus']?.toString() ??
            'Pending';

    final dynamic amount =
        booking['totalAmount'] ?? 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color:
                        green.withValues(alpha: 0.1),
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.event,
                    color: green,
                    size: 25,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        hallName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                          color: green,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        hotelName,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),

                _statusBadge(bookingStatus),
              ],
            ),

            const SizedBox(height: 18),
            const Divider(),
            const SizedBox(height: 10),

            _bookingInfo(
              Icons.event_note,
              'Event Type',
              eventType,
            ),

            const SizedBox(height: 10),

            _bookingInfo(
              Icons.calendar_today,
              'Event Date',
              eventDate,
            ),

            const SizedBox(height: 10),

            _bookingInfo(
              Icons.people_outline,
              'Guests',
              guests,
            ),

            const SizedBox(height: 10),

            _bookingInfo(
              Icons.table_restaurant_outlined,
              'Seating',
              seating,
            ),

            const SizedBox(height: 10),

            _bookingInfo(
              Icons.auto_awesome_outlined,
              'Decoration',
              decoration,
            ),

            const SizedBox(height: 10),

            _bookingInfo(
              Icons.payment_outlined,
              'Payment',
              paymentStatus,
            ),

            const SizedBox(height: 15),

            _totalAmount(amount),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // TOTAL AMOUNT
  // ============================================================

  Widget _totalAmount(dynamic amount) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),

      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: [
          const Text(
            'Total Amount',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),

          Text(
            'Rs. $amount',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: green,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BOOKING INFO
  // ============================================================

  Widget _bookingInfo(
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: green,
        ),

        const SizedBox(width: 10),

        Text(
          '$title:',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(width: 6),

        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // STATUS
  // ============================================================

  Widget _statusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),

      decoration: BoxDecoration(
        color: green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Text(
        status,
        style: const TextStyle(
          color: green,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}