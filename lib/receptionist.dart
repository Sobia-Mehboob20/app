import 'package:app/checkin-out.dart';
import 'package:app/hallbookingdetail.dart';
import 'package:app/roombookdetail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReceptionistDashboard extends StatelessWidget {
  const ReceptionistDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),

      appBar: AppBar(
        title: const Text(
          'Receptionist Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor:  Color(0xFF3F4A32),
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              'Welcome,Receptionist',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'View hotel booking and check-in details',
              style: TextStyle(
                color: Color.fromARGB(255, 11, 11, 11),
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 30),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,

                children: [

                  // ROOM BOOKING
                  _card(
                    context,
                    'Room Booking',
                    Icons.hotel,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const RoomBookingDetails(),
                        ),
                      );
                    },
                  ),

                  // HALL BOOKING
                  _card(
                    context,
                    'Hall Booking',
                    Icons.event,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const HallBookingDetails(),
                        ),
                      );
                    },
                  ),

                  // CHECK IN / CHECK OUT
                  _card(
                    context,
                    'Check-in / Check-out',
                    Icons.login,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const CheckInOutDetails(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),

      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Icon(
              icon,
              size: 48,
              color:  Color(0xFF3F4A32),
            ),

            const SizedBox(height: 12),

            Text(
              title,
              textAlign: TextAlign.center,

              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}