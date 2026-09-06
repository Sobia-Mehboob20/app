
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManagerReportsScreen extends StatelessWidget {
  const ManagerReportsScreen({super.key});

  static const Color green = Color(0xFF3F4A32);
  static const Color background = Color(0xFFF5F0E8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Reports',
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
                'Error loading reports\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('No report data available'),
            );
          }

          final bookings = snapshot.data!.docs;

          int totalBookings = bookings.length;
          int confirmedBookings = 0;
          int paidBookings = 0;
          double totalRevenue = 0;

          // Calculate report
          for (var doc in bookings) {
            final data = doc.data() as Map<String, dynamic>;

            final bookingStatus =
                data['bookingStatus']?.toString().toLowerCase() ?? '';

            final paymentStatus =
                data['paymentStatus']?.toString().toLowerCase() ?? '';

            if (bookingStatus == 'confirmed') {
              confirmedBookings++;
            }

            if (paymentStatus == 'paid') {
              paidBookings++;
            }

            final amount = data['totalAmount'];

            if (amount is num) {
              totalRevenue += amount.toDouble();
            }
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  'Booking Report',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: green,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'Overview of hotel bookings and payments',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 25),

                // Total Bookings
                _reportCard(
                  icon: Icons.calendar_month,
                  title: 'Total Bookings',
                  value: totalBookings.toString(),
                ),

                const SizedBox(height: 15),

                // Confirmed Bookings
                _reportCard(
                  icon: Icons.check_circle_outline,
                  title: 'Confirmed Bookings',
                  value: confirmedBookings.toString(),
                ),

                const SizedBox(height: 15),

                // Paid Bookings
                _reportCard(
                  icon: Icons.payment,
                  title: 'Paid Bookings',
                  value: paidBookings.toString(),
                ),

                const SizedBox(height: 15),

                // Total Revenue
                _reportCard(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'Total Revenue',
                  value: 'Rs. ${totalRevenue.toStringAsFixed(0)}',
                ),

                const SizedBox(height: 25),

                // Information box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: green,
                      ),

                      const SizedBox(width: 12),

                      const Expanded(
                        child: Text(
                          'Reports are generated automatically '
                          'from the booking records stored in Firebase.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _reportCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(13),

            decoration: BoxDecoration(
              color: green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),

            child: Icon(
              icon,
              color: green,
              size: 28,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),

          Text(
            value,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: green,
            ),
          ),
        ],
      ),
    );
  }
}

