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
        title: const Text(
          'Reports',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: green,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('roomBookings')
            .snapshots(),
        builder: (context, roomSnapshot) {
          if (roomSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (roomSnapshot.hasError) {
            return Center(child: Text('Error: ${roomSnapshot.error}'));
          }

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('hallBookings')
                .snapshots(),
            builder: (context, hallSnapshot) {
              if (hallSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (hallSnapshot.hasError) {
                return Center(child: Text('Error: ${hallSnapshot.error}'));
              }

              final allBookings = [
                ...roomSnapshot.data!.docs,
                ...hallSnapshot.data!.docs,
              ];

              int totalBookings = allBookings.length;
              int confirmedBookings = 0;
              double totalRevenue = 0;

              for (final doc in allBookings) {
                final data = doc.data() as Map<String, dynamic>;

                final bookingStatus = data['bookingStatus']
                    ?.toString()
                    .toLowerCase();

                if (bookingStatus == 'confirmed') {
                  confirmedBookings++;
                }

                final amount = data['totalAmount'];

                if (amount is num) {
                  totalRevenue += amount.toDouble();
                }
              }

              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const Text(
                    'Booking Report',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  _reportCard(
                    icon: Icons.book_online,
                    title: 'Total Bookings',
                    value: totalBookings.toString(),
                  ),

                  _reportCard(
                    icon: Icons.check_circle,
                    title: 'Confirmed Bookings',
                    value: confirmedBookings.toString(),
                  ),

                  _reportCard(
                    icon: Icons.attach_money,
                    title: 'Total Revenue',
                    value: 'Rs. ${totalRevenue.toStringAsFixed(0)}',
                  ),
                ],
              );
            },
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
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon, size: 40, color: green),

            const SizedBox(width: 20),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
