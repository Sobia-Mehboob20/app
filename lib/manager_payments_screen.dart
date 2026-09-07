import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManagerPaymentsScreen extends StatelessWidget {
  const ManagerPaymentsScreen({super.key});

  static const Color green = Color(0xFF3F4A32);
  static const Color background = Color(0xFFF5F0E8);

  String formatDate(dynamic date) {
    if (date is Timestamp) {
      final DateTime d = date.toDate();
      return '${d.day}/${d.month}/${d.year}';
    }

    if (date is DateTime) {
      return '${date.day}/${date.month}/${date.year}';
    }

    return 'Not available';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          'Payments',
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
            return Center(
              child: Text('Error: ${roomSnapshot.error}'),
            );
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
                return Center(
                  child: Text('Error: ${hallSnapshot.error}'),
                );
              }

              final payments = [
                ...roomSnapshot.data!.docs.map((doc) {
                  return {
                    ...(doc.data() as Map<String, dynamic>),
                    '_type': 'Room',
                  };
                }),
                ...hallSnapshot.data!.docs.map((doc) {
                  return {
                    ...(doc.data() as Map<String, dynamic>),
                    '_type': 'Event',
                  };
                }),
              ];

              if (payments.isEmpty) {
                return const Center(
                  child: Text(
                    'No payments found',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }

              payments.sort((a, b) {
                final aTime = a['createdAt'];
                final bTime = b['createdAt'];

                if (aTime is Timestamp && bTime is Timestamp) {
                  return bTime.compareTo(aTime);
                }

                return 0;
              });

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: payments.length,
                itemBuilder: (context, index) {
                  final payment = payments[index];
                  final bool isEvent = payment['_type'] == 'Event';

                  final String name = isEvent
                      ? payment['hallName']?.toString() ?? 'Hall'
                      : payment['roomType']?.toString() ?? 'Room';

                  final String paymentStatus =
                      payment['paymentStatus']?.toString() ?? 'Pending';

                  final String paymentMethod =
                      payment['paymentMethod']?.toString() ?? 'Not Paid';

                  final dynamic totalAmount = payment['totalAmount'];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 15),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                isEvent ? Icons.event : Icons.hotel,
                                color: green,
                                size: 30,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                paymentStatus,
                                style: TextStyle(
                                  color: paymentStatus.toLowerCase() == 'paid'
                                      ? Colors.green
                                      : Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          if (isEvent) ...[
                            _infoRow(
                              Icons.calendar_today,
                              'Event Date',
                              formatDate(payment['eventDate']),
                            ),
                            _infoRow(
                              Icons.category,
                              'Event Type',
                              payment['eventType']?.toString() ?? '-',
                            ),
                          ] else ...[
                            _infoRow(
                              Icons.login,
                              'Check-in',
                              formatDate(payment['checkIn']),
                            ),
                            _infoRow(
                              Icons.logout,
                              'Check-out',
                              formatDate(payment['checkOut']),
                            ),
                          ],

                          _infoRow(
                            Icons.payment,
                            'Payment Method',
                            paymentMethod,
                          ),

                          _infoRow(
                            Icons.attach_money,
                            'Total Amount',
                            'Rs. ${totalAmount ?? 0}',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: green,
          ),
          const SizedBox(width: 10),
          Text(
            '$title: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}