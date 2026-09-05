import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

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
          'Customers',
          style: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('role', isEqualTo: 'Customer')
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
            return Center(
              child: Text(
                'Error loading customers',
                style: TextStyle(
                  color: green,
                  fontSize: 16,
                ),
              ),
            );
          }

          // No customers
          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 60,
                    color: green,
                  ),

                  SizedBox(height: 12),

                  Text(
                    'No customers found',
                    style: TextStyle(
                      color: green,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            );
          }

          final customers = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),

            itemCount: customers.length,

            itemBuilder: (context, index) {
              final customer = customers[index];

              final data =
                  customer.data() as Map<String, dynamic>;

              final name = data['name'] ?? 'No Name';
              final email = data['email'] ?? 'No Email';
              final role = data['role'] ?? 'Customer';

              return Card(
                color: Colors.white,
                elevation: 2,

                margin: const EdgeInsets.only(
                  bottom: 12,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),

                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),

                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor:
                        green.withOpacity(0.12),

                    child: const Icon(
                      Icons.person_outline,
                      color: green,
                    ),
                  ),

                  title: Text(
                    name.toString(),
                    style: const TextStyle(
                      color: green,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),

                  subtitle: Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                    ),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        Text(
                          email.toString(),
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),

                        const SizedBox(height: 3),

                        Text(
                          role.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: green,
                          ),
                        ),
                      ],
                    ),
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