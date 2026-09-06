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

  // ---------------- FORMATTED DATE ----------------

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
    return hallPrice +
        decorationPrice +
        stagePrice +
        soundPrice;
  }

  // ---------------- SAVE BOOKING ----------------

  Future<void> saveBooking() async {
    if (isSaving) return;

    setState(() {
      isSaving = true;
    });

    try {
      // IMPORTANT:
      // Hall bookings are saved in hallBookings collection
      final bookingRef = await FirebaseFirestore.instance
          .collection('hallBookings')
          .add({
        // ---------------- COMMON BOOKING INFORMATION ----------------

        'bookingType': 'Event',
        'hotelName': 'Aurelia Grand',

        // ---------------- HALL INFORMATION ----------------

        'hallName': widget.hallName,
        'capacity': widget.capacity,

        // ---------------- EVENT INFORMATION ----------------

        'eventDate': Timestamp.fromDate(widget.eventDate),
        'eventType': widget.eventType,
        'guests': widget.guests,
        'seating': widget.seating,
        'decoration': widget.decoration,

        'stageRequired': widget.stageRequired,
        'soundSystemRequired': widget.soundSystemRequired,

        // ---------------- PRICE INFORMATION ----------------

        'hallPrice': hallPrice,
        'decorationPrice': decorationPrice,
        'stagePrice': stagePrice,
        'soundPrice': soundPrice,
        'totalAmount': totalPrice,

        // ---------------- PAYMENT INFORMATION ----------------

        'paymentMethod': 'Not Paid',
        'paymentStatus': 'Pending',

        // ---------------- BOOKING STATUS ----------------

        'bookingStatus': 'Pending',

        // ---------------- CREATED TIME ----------------

        'createdAt': FieldValue.serverTimestamp(),
      });

      debugPrint('HALL BOOKING SAVED: ${bookingRef.id}');

      if (!mounted) return;

      setState(() {
        isSaving = false;
      });

      // ---------------- SUCCESS MESSAGE ----------------

      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color(0xFFF5F0E8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Text(
              'Booking Submitted',
              style: TextStyle(
                color: Color(0xFF3F4A32),
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
              'Your event booking request has been submitted '
              'successfully.\n\n'
              'Your booking is currently Pending and will be '
              'confirmed by the receptionist.',
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
              ),
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

      // Go back after successful booking
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (error) {
      debugPrint('HALL BOOKING ERROR: $error');

      if (!mounted) return;

      setState(() {
        isSaving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Booking failed: $error',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
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
        title: const Text(
          'Event Booking',
          style: TextStyle(
            color: Color(0xFFF5F0E8),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFFF5F0E8),
        ),
      ),

      // ---------------- BODY ----------------

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- BOOKING SUMMARY ----------------

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
                _infoRow(
                  'Banquet Hall',
                  widget.hallName,
                ),

                _infoRow(
                  'Event Type',
                  widget.eventType,
                ),

                _infoRow(
                  'Event Date',
                  formattedDate,
                ),

                _infoRow(
                  'Guests',
                  '${widget.guests}',
                ),

                _infoRow(
                  'Seating',
                  widget.seating,
                ),

                _infoRow(
                  'Decoration',
                  widget.decoration,
                ),

                _infoRow(
                  'Stage',
                  widget.stageRequired
                      ? 'Required'
                      : 'Not Required',
                ),

                _infoRow(
                  'Sound System',
                  widget.soundSystemRequired
                      ? 'Required'
                      : 'Not Required',
                ),
              ],
            ),

            const SizedBox(height: 25),

            // ---------------- PRICE DETAILS ----------------

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
                _priceRow(
                  'Hall',
                  hallPrice,
                ),

                _priceRow(
                  'Decoration',
                  decorationPrice,
                ),

                _priceRow(
                  'Stage',
                  stagePrice,
                ),

                _priceRow(
                  'Sound System',
                  soundPrice,
                ),

                const Divider(
                  color: Color(0xFF3F4A32),
                ),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
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

            // ---------------- BOOKING STATUS ----------------

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),

              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.orange.shade300,
                ),
              ),

              child: Row(
                children: [
                  Icon(
                    Icons.pending_actions,
                    color: Colors.orange.shade800,
                  ),

                  const SizedBox(width: 10),

                  const Expanded(
                    child: Text(
                      'Booking Status: Pending\n'
                      'The receptionist will confirm your booking.',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ---------------- CONFIRM BUTTON ----------------

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed: isSaving ? null : saveBooking,

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3F4A32),
                  foregroundColor: Colors.white,

                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),

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
                        'Submit Booking',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ---------------- INFO CARD ----------------

  Widget _infoCard({
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(14),

        border: Border.all(
          color: const Color(0xFF3F4A32),
        ),
      ),

      child: Column(
        children: children,
      ),
    );
  }

  // ---------------- INFO ROW ----------------

  Widget _infoRow(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Expanded(
            child: Text(
              title,

              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
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

  Widget _priceRow(
    String title,
    double price,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: [
          Text(
            title,

            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),

          Text(
            'PKR ${price.toStringAsFixed(0)}',

            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}