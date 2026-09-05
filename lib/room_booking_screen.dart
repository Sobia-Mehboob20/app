import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomBookingScreen extends StatefulWidget {
  final String roomId;
  final String roomName;
  final String price;
  final String image;

  final DateTime checkInDate;
  final DateTime checkOutDate;

  final int adults;
  final int children;

  const RoomBookingScreen({
    super.key,
    required this.roomId,
    required this.roomName,
    required this.price,
    required this.image,
    required this.checkInDate,
    required this.checkOutDate,
    required this.adults,
    required this.children,
  });

  @override
  State<RoomBookingScreen> createState() => _RoomBookingScreenState();
}

class _RoomBookingScreenState extends State<RoomBookingScreen> {
  bool isBooking = false;

  // ---------------- FORMAT DATE ----------------

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  // ---------------- CALCULATE NIGHTS ----------------

  int get numberOfNights {
    return widget.checkOutDate.difference(widget.checkInDate).inDays;
  }

  // ---------------- GET PRICE ----------------

  double get priceNumber {
    return double.tryParse(
          widget.price
              .replaceAll('PKR', '')
              .replaceAll(',', '')
              .trim(),
        ) ??
        0;
  }

  // ---------------- TOTAL PRICE ----------------

  double get totalPrice {
    return priceNumber * numberOfNights;
  }

  // =====================================================
  // SAVE BOOKING TO FIREBASE
  // =====================================================

  Future<void> confirmBooking() async {
    setState(() {
      isBooking = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('roomBookings')
          .add({
        'roomId': widget.roomId,
        'roomName': widget.roomName,
        'checkIn': Timestamp.fromDate(widget.checkInDate),
        'checkOut': Timestamp.fromDate(widget.checkOutDate),
        'adults': widget.adults,
        'children': widget.children,
        'numberOfNights': numberOfNights,
        'pricePerNight': priceNumber,
        'totalPrice': totalPrice,
        'status': 'confirmed',
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Booking saved successfully!'),
        ),
      );

      setState(() {
        isBooking = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isBooking = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Booking failed: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),

      // ---------------- APP BAR ----------------

      appBar: AppBar(
        backgroundColor: const Color(0xFF3F4A32),
        elevation: 0,

        leading: const BackButton(
          color: Colors.white,
        ),

        title: const Text(
          'Book Your Room',
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
            // ROOM IMAGE

            ClipRRect(
              borderRadius: BorderRadius.circular(15),

              child: Image.asset(
                widget.image,

                width: double.infinity,
                height: 190,

                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            // ROOM NAME

            Text(
              widget.roomName,

              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F4A32),
              ),
            ),

            const SizedBox(height: 20),

            // ================= BOOKING INFORMATION =================

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: const Color(0xFFFAF8F3),
                borderRadius: BorderRadius.circular(15),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text(
                    'Booking Details',

                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3F4A32),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // CHECK-IN

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [
                      const Text(
                        'Check-in',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      Text(
                        formatDate(widget.checkInDate),

                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // CHECK-OUT

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [
                      const Text(
                        'Check-out',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      Text(
                        formatDate(widget.checkOutDate),

                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // GUESTS

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [
                      const Text(
                        'Guests',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      Text(
                        '${widget.adults} Adults, '
                        '${widget.children} Children',

                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // NIGHTS

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [
                      const Text(
                        'Nights',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      Text(
                        '$numberOfNights',

                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ================= PRICE SUMMARY =================

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: const Color(0xFFFAF8F3),
                borderRadius: BorderRadius.circular(15),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  const Text(
                    'Price Summary',

                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3F4A32),
                    ),
                  ),

                  const SizedBox(height: 18),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [
                      const Text(
                        'Room Price',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      Text(
                        'PKR ${priceNumber.toStringAsFixed(0)}',
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [
                      const Text(
                        'Nights',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      Text(
                        '× $numberOfNights',
                      ),
                    ],
                  ),

                  const Divider(height: 25),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [
                      const Text(
                        'Total',

                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        'PKR ${totalPrice.toStringAsFixed(0)}',

                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3F4A32),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ================= CONFIRM BOOKING =================

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed:
                    isBooking ? null : confirmBooking,

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF5A6545),

                  foregroundColor: Colors.white,

                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 16,
                  ),

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                ),

                child: isBooking
                    ? const SizedBox(
                        height: 22,
                        width: 22,

                        child:
                            CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Confirm Booking',

                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}