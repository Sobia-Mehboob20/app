import 'package:flutter/material.dart';
import 'room_booking_screen.dart';


class CheckAvailabilityScreen extends StatefulWidget {
  final String roomId;
  final String roomName;
  final String price;
  final String image;

  const CheckAvailabilityScreen({
    super.key,
    required this.roomId,
    required this.roomName,
    required this.price,
    required this.image,
  });

  @override
  State<CheckAvailabilityScreen> createState() =>
      _CheckAvailabilityScreenState();
}

class _CheckAvailabilityScreenState extends State<CheckAvailabilityScreen> {
  DateTime? checkInDate;
  DateTime? checkOutDate;

  int adults = 2;
  int children = 0;

  // ---------------- SELECT DATE ----------------

  Future<void> selectCheckInDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        checkInDate = pickedDate;
      });
    }
  }

  Future<void> selectCheckOutDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: checkInDate ?? DateTime.now(),
      firstDate: checkInDate ?? DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        checkOutDate = pickedDate;
      });
    }
  }

  // ---------------- FORMAT DATE ----------------

  String formatDate(DateTime? date) {
    if (date == null) {
      return 'Select Date';
    }

    return '${date.day}/${date.month}/${date.year}';
  }

  // ---------------- BUILD ----------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),

      // ---------------- APP BAR ----------------
      appBar: AppBar(
        backgroundColor: const Color(0xFF3F4A32),
        elevation: 0,

        leading: const BackButton(color: Colors.white),

        title: const Text(
          'Check Availability',
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ---------------- BODY ----------------
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ROOM NAME

            Text(
              widget.roomName,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F4A32),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              '${widget.price} / night',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB89450),
              ),
            ),

            const SizedBox(height: 25),

            // CHECK-IN
            const Text(
              'Check-in',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F4A32),
              ),
            ),

            const SizedBox(height: 8),

            GestureDetector(
              onTap: selectCheckInDate,

              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: const Color(0xFFFAF8F3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF5A6545)),
                ),

                child: Row(
                  children: [
                    const Icon(Icons.calendar_month, color: Color(0xFF5A6545)),

                    const SizedBox(width: 12),

                    Text(
                      formatDate(checkInDate),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // CHECK-OUT
            const Text(
              'Check-out',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F4A32),
              ),
            ),

            const SizedBox(height: 8),

            GestureDetector(
              onTap: selectCheckOutDate,

              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: const Color(0xFFFAF8F3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF5A6545)),
                ),

                child: Row(
                  children: [
                    const Icon(Icons.calendar_month, color: Color(0xFF5A6545)),

                    const SizedBox(width: 12),

                    Text(
                      formatDate(checkOutDate),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // GUESTS
            const Text(
              'Guests',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F4A32),
              ),
            ),

            const SizedBox(height: 12),

            // ADULTS
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),

              decoration: BoxDecoration(
                color: const Color(0xFFFAF8F3),
                borderRadius: BorderRadius.circular(12),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  const Text('Adults', style: TextStyle(fontSize: 16)),

                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (adults > 1) {
                            setState(() {
                              adults--;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove),
                      ),

                      Text(
                        '$adults',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          setState(() {
                            adults++;
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // CHILDREN
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),

              decoration: BoxDecoration(
                color: const Color(0xFFFAF8F3),
                borderRadius: BorderRadius.circular(12),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  const Text('Children', style: TextStyle(fontSize: 16)),

                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (children > 0) {
                            setState(() {
                              children--;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove),
                      ),

                      Text(
                        '$children',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          setState(() {
                            children++;
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            // CHECK AVAILABILITY BUTTON
            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () {
                  if (checkInDate == null || checkOutDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please select check-in and check-out dates',
                        ),
                      ),
                    );

                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RoomBookingScreen(
                        roomId: widget.roomId,
                        roomName: widget.roomName,
                        price: widget.price,
                        image: widget.image,
                        checkInDate: checkInDate!,
                        checkOutDate: checkOutDate!,
                        adults: adults,
                        children: children,
                      ),
                    ),
                  );
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5A6545),

                  foregroundColor: Colors.white,

                  padding: const EdgeInsets.symmetric(vertical: 15),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                child: const Text(
                  'Check Availability',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
