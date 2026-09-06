
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

  int get numberOfNights {
    final difference =
        widget.checkOutDate.difference(widget.checkInDate).inDays;

    return difference <= 0 ? 1 : difference;
  }

  double get priceNumber {
    return double.tryParse(
          widget.price.replaceAll(RegExp(r'[^0-9.]'), ''),
        ) ??
        0;
  }

  double get totalPrice {
    return priceNumber * numberOfNights;
  }

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> confirmBooking() async {
    if (isBooking) return;

    setState(() {
      isBooking = true;
    });

    try {
      final bookingRef =
          await FirebaseFirestore.instance.collection('roomBookings').add({
        'hotelName': 'Aurelia Grand',
        'bookingType': 'Room',

        'roomId': widget.roomId,
        'roomType': widget.roomName,
        'image': widget.image,

        'checkIn': Timestamp.fromDate(widget.checkInDate),
        'checkOut': Timestamp.fromDate(widget.checkOutDate),

        'adults': widget.adults,
        'children': widget.children,
        'nights': numberOfNights,

        'pricePerNight': priceNumber,
        'totalAmount': totalPrice,

        'paymentMethod': 'Not Paid',
        'paymentStatus': 'Pending',

        'bookingStatus': 'Pending',

        'createdAt': FieldValue.serverTimestamp(),
      });

      // Check in Debug Console that booking was actually saved.
      debugPrint('BOOKING SAVED: ${bookingRef.id}');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Room booking submitted successfully!',
          ),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      debugPrint('BOOKING ERROR: $e');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Booking failed: $e',
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isBooking = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),

      appBar: AppBar(
        backgroundColor: const Color(0xFF3F4A32),
        foregroundColor: Colors.white,
        title: const Text(
          'Room Booking',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ROOM IMAGE
            if (widget.image.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(15),

                child: Image.network(
                  widget.image,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,

                  errorBuilder:
                      (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey.shade300,

                      child: const Icon(
                        Icons.hotel,
                        size: 70,
                      ),
                    );
                  },
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

            const SizedBox(height: 8),

            Text(
              'Room ID: ${widget.roomId}',

              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            // BOOKING INFORMATION
            Card(
              color: Colors.white,
              elevation: 3,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Column(
                  children: [

                    _infoRow(
                      'Check-in',
                      formatDate(widget.checkInDate),
                    ),

                    _infoRow(
                      'Check-out',
                      formatDate(widget.checkOutDate),
                    ),

                    _infoRow(
                      'Adults',
                      widget.adults.toString(),
                    ),

                    _infoRow(
                      'Children',
                      widget.children.toString(),
                    ),

                    _infoRow(
                      'Nights',
                      numberOfNights.toString(),
                    ),

                    _infoRow(
                      'Price per night',
                      'PKR ${priceNumber.toStringAsFixed(0)}',
                    ),

                    const Divider(
                      height: 25,
                    ),

                    _infoRow(
                      'Total Amount',
                      'PKR ${totalPrice.toStringAsFixed(0)}',
                      bold: true,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // CONFIRM BOOKING BUTTON
            SizedBox(
              width: double.infinity,
              height: 52,

              child: ElevatedButton(
                onPressed:
                    isBooking ? null : confirmBooking,

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF3F4A32),

                  foregroundColor: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                ),

                child: isBooking
                    ? const SizedBox(
                        height: 24,
                        width: 24,

                        child:
                            CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
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
          ],
        ),
      ),
    );
  }

  Widget _infoRow(
    String title,
    String value, {
    bool bold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 7,
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: [
          Text(
            title,

            style: const TextStyle(
              fontSize: 15,
            ),
          ),

          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,

              style: TextStyle(
                fontSize: 15,
                fontWeight: bold
                    ? FontWeight.bold
                    : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}