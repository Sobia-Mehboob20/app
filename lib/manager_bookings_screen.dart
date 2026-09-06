
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManagerBookingsScreen extends StatelessWidget {
  const ManagerBookingsScreen({super.key});

  static const Color green = Color(0xFF3F4A32);
  static const Color background = Color(0xFFF5F0E8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        title: const Text(
          'Bookings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
         iconTheme: const IconThemeData(
          color: Color(0xFFF5F0E8),
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('bookings')
            .snapshots(),

        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading bookings\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                ),
              ),
            );
          }

          // No bookings
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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

          final bookings = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking =
                  bookings[index].data() as Map<String, dynamic>;

              return _bookingCard(booking);
            },
          );
        },
      ),
    );
  }

  Widget _bookingCard(Map<String, dynamic> booking) {
    final String roomType =
        booking['roomType']?.toString() ?? 'Room';

    final String hotelName =
        booking['hotelName']?.toString() ?? 'Aurelia Grand';
String formatDate(dynamic date) {
  if (date is Timestamp) {
    final DateTime d = date.toDate();
    return '${d.day}/${d.month}/${d.year}';
  }

  return 'Not available';
}

final String checkIn = formatDate(booking['checkIn']);
final String checkOut = formatDate(booking['checkOut']);
    

    final String nights =
        booking['nights']?.toString() ?? '0';

    final String paymentStatus =
        booking['paymentStatus']?.toString() ?? 'Pending';

    final String bookingStatus =
        booking['bookingStatus']?.toString() ?? 'Pending';

    final dynamic amount = booking['totalAmount'];

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Room name and booking status
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        roomType,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
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

            // Check in
            _bookingInfo(
              Icons.login,
              'Check-in',
              checkIn,
            ),

            const SizedBox(height: 10),

            // Check out
            _bookingInfo(
              Icons.logout,
              'Check-out',
              checkOut,
            ),

            const SizedBox(height: 10),

            // Nights
            _bookingInfo(
              Icons.nights_stay_outlined,
              'Nights',
              nights,
            ),

            const SizedBox(height: 10),

            // Payment status
            _bookingInfo(
              Icons.payment_outlined,
              'Payment',
              paymentStatus,
            ),

            const SizedBox(height: 15),

            // Total amount
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Amount',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),

                  Text(
                    'Rs. ${amount ?? 0}',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: green,
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

