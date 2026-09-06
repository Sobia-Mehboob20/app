import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManagerPaymentsScreen extends StatelessWidget {
  const ManagerPaymentsScreen({super.key});

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
          'Payments',
          style: TextStyle(
            color: Colors.white,
            fontSize: 19,
          ),
        ),
         iconTheme: const IconThemeData(
          color: Color(0xFFF5F0E8),
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('bookings')
            .orderBy('createdAt', descending: true)
            .snapshots(),

        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: green,
              ),
            );
          }

          // Error
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Error loading payments.',
                style: TextStyle(
                  color: green,
                  fontSize: 16,
                ),
              ),
            );
          }

          // No payments
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(25),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Icon(
                      Icons.payment_outlined,
                      size: 70,
                      color: green.withValues(alpha: 0.7),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'No Payments Available',
                      style: TextStyle(
                        fontSize: 20,
                        color: green,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Customer payments will appear here.',
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final payments = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),

            itemCount: payments.length,

            itemBuilder: (context, index) {
              final payment =
                  payments[index].data() as Map<String, dynamic>;

              return _paymentCard(payment);
            },
          );
        },
      ),
    );
  }

  // =========================================================
  // PAYMENT CARD
  // =========================================================
String formatDate(dynamic date) {
  if (date is Timestamp) {
    final DateTime d = date.toDate();
    return '${d.day}/${d.month}/${d.year}';
  }

  if (date is DateTime) {
    return '${date.day}/${date.month}/${date.year}';
  }

  if (date is String && date.isNotEmpty) {
    return date;
  }

  return '-';
}
  Widget _paymentCard(Map<String, dynamic> payment) {
    final String paymentStatus =
        payment['paymentStatus'] ?? 'Pending';

    final String paymentMethod =
        payment['paymentMethod'] ?? 'Not specified';

    final String roomType =
        payment['roomType'] ?? 'Room';

    final String checkIn = formatDate(payment['checkIn']);

    final String checkOut = formatDate(payment['checkOut']);

    final dynamic totalAmount =
        payment['totalAmount'] ?? 0;

    return Card(
      color: Colors.white,
      elevation: 2,

      margin: const EdgeInsets.only(bottom: 14),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // -------------------------------------------------
            // ROOM + PAYMENT STATUS
            // -------------------------------------------------

            Row(
              children: [
                Expanded(
                  child: Text(
                    roomType,

                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: green,
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),

                  decoration: BoxDecoration(
                    color: paymentStatus.toLowerCase() == 'paid'
                        ? Colors.green.shade100
                        : Colors.orange.shade100,

                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Text(
                    paymentStatus,

                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,

                      color: paymentStatus.toLowerCase() == 'paid'
                          ? Colors.green.shade700
                          : Colors.orange.shade700,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // -------------------------------------------------
            // PAYMENT METHOD
            // -------------------------------------------------

            _paymentInfo(
              Icons.credit_card_outlined,
              'Payment Method',
              paymentMethod,
            ),

            // -------------------------------------------------
            // CHECK IN
            // -------------------------------------------------

            _paymentInfo(
              Icons.login,
              'Check-in',
              checkIn,
            ),

            // -------------------------------------------------
            // CHECK OUT
            // -------------------------------------------------

            _paymentInfo(
              Icons.logout,
              'Check-out',
              checkOut,
            ),

            const Divider(height: 20),

            // -------------------------------------------------
            // TOTAL
            // -------------------------------------------------

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                const Text(
                  'Total Amount',

                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),

                Text(
                  'Rs. $totalAmount',

                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // PAYMENT INFORMATION
  // =========================================================

  Widget _paymentInfo(
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),

      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: green,
          ),

          const SizedBox(width: 10),

          Text(
            '$title: ',

            style: const TextStyle(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),

          Expanded(
            child: Text(
              value,

              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}