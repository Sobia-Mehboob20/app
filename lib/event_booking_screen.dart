import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventBookingScreen extends StatefulWidget {
  final String hallName;
  final String capacity;
  final String price;
  final DateTime eventDate;
  final String eventType;
  final int guests;
  final String seating;
  final String decoration;
  final bool stageRequired;
  final bool soundSystemRequired;

  const EventBookingScreen({
    super.key,
    required this.hallName,
    required this.capacity,
    required this.price,
    required this.eventDate,
    required this.eventType,
    required this.guests,
    required this.seating,
    required this.decoration,
    required this.stageRequired,
    required this.soundSystemRequired,
  });

  @override
  State<EventBookingScreen> createState() => _EventBookingScreenState();
}

class _EventBookingScreenState extends State<EventBookingScreen> {
  bool isSaving = false;

  String get formattedDate {
    return '${widget.eventDate.day}/'
        '${widget.eventDate.month}/'
        '${widget.eventDate.year}';
  }

  // ---------------- PRICE CALCULATION ----------------

  double get hallPrice {
    if (widget.hallName == 'Grand Ballroom') {
      return 150000;
    } else if (widget.hallName == 'Royal Hall') {
      return 100000;
    } else {
      return 70000;
    }
  }

  double get decorationPrice {
    if (widget.decoration == 'Basic') {
      return 10000;
    } else if (widget.decoration == 'Premium') {
      return 25000;
    } else {
      return 45000;
    }
  }

  double get stagePrice {
    return widget.stageRequired ? 15000 : 0;
  }

  double get soundPrice {
    return widget.soundSystemRequired ? 10000 : 0;
  }

  double get totalPrice {
    return hallPrice + decorationPrice + stagePrice + soundPrice;
  }

  // ---------------- SAVE BOOKING ----------------

 // ---------------- SAVE BOOKING ----------------

Future<void> saveBooking() async {
  setState(() {
    isSaving = true;
  });

  try {
    await FirebaseFirestore.instance.collection('bookings').add({
      // Common booking information
      'bookingType': 'Event',
      'hotelName': 'Aurelia Grand',

      // These common fields help the Manager screens
      'roomType': widget.hallName,
      'checkIn': Timestamp.fromDate(widget.eventDate),
      'checkOut': Timestamp.fromDate(widget.eventDate),
      'nights': 1,

      // Event information
      'hallName': widget.hallName,
      'capacity': widget.capacity,
      'eventDate': Timestamp.fromDate(widget.eventDate),
      'eventType': widget.eventType,
      'guests': widget.guests,
      'seating': widget.seating,
      'decoration': widget.decoration,
      'stageRequired': widget.stageRequired,
      'soundSystemRequired': widget.soundSystemRequired,

      // Price information
      'hallPrice': hallPrice,
      'decorationPrice': decorationPrice,
      'stagePrice': stagePrice,
      'soundPrice': soundPrice,
      'totalAmount': totalPrice,

      // Payment information
      'paymentMethod': 'Not Paid',
      'paymentStatus': 'Pending',

      // Booking status
      'bookingStatus': 'Confirmed',

      // Created time
      'createdAt': FieldValue.serverTimestamp(),
    });

    if (!mounted) return;

    setState(() {
      isSaving = false;
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF5F0E8),

          title: const Text(
            'Booking Confirmed',
            style: TextStyle(
              color: Color(0xFF3F4A32),
              fontWeight: FontWeight.bold,
            ),
          ),

          content: const Text(
            'Your event booking has been saved successfully.',
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Color(0xFF3F4A32),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  } catch (error) {
    if (!mounted) return;

    setState(() {
      isSaving = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Booking failed: $error'),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),

      appBar: AppBar(
        backgroundColor: const Color(0xFF3F4A32),
        elevation: 0,

        title: const Text(
          'Event Booking',
          style: TextStyle(
            color: Color(0xFFF5F0E8),
            fontWeight: FontWeight.bold,
          ),
        ),

        iconTheme: const IconThemeData(color: Color(0xFFF5F0E8)),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              'Booking Summary',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F4A32),
              ),
            ),

            const SizedBox(height: 20),

            _infoCard(
              children: [
                _infoRow('Banquet Hall', widget.hallName),

                _infoRow('Event Type', widget.eventType),

                _infoRow('Event Date', formattedDate),

                _infoRow('Guests', '${widget.guests}'),

                _infoRow('Seating', widget.seating),

                _infoRow('Decoration', widget.decoration),

                _infoRow(
                  'Stage',
                  widget.stageRequired ? 'Required' : 'Not Required',
                ),

                _infoRow(
                  'Sound System',
                  widget.soundSystemRequired ? 'Required' : 'Not Required',
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              'Price Details',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F4A32),
              ),
            ),

            const SizedBox(height: 12),

            _infoCard(
              children: [
                _priceRow('Hall', hallPrice),

                _priceRow('Decoration', decorationPrice),

                _priceRow('Stage', stagePrice),

                _priceRow('Sound System', soundPrice),

                const Divider(color: Color(0xFF3F4A32)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3F4A32),
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

            const SizedBox(height: 35),

            // ---------------- CONFIRM BUTTON ----------------
            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: isSaving ? null : saveBooking,

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3F4A32),

                  foregroundColor: Colors.white,

                  padding: const EdgeInsets.symmetric(vertical: 16),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                child: isSaving
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
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
          ],
        ),
      ),
    );
  }

  // ---------------- INFO CARD ----------------

  Widget _infoCard({required List<Widget> children}) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),

        border: Border.all(color: const Color(0xFF3F4A32)),
      ),

      child: Column(children: children),
    );
  }

  // ---------------- INFO ROW ----------------

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,

              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,

                color: Color(0xFF3F4A32),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- PRICE ROW ----------------

  Widget _priceRow(String title, double price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),

          Text(
            'PKR ${price.toStringAsFixed(0)}',
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
