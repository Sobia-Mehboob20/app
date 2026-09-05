
import 'package:flutter/material.dart';
import 'customize_setup_screen.dart';
class BanquetAvailabilityScreen extends StatefulWidget {
  final String hallName;
  final String image;
  final String capacity;
  final String price;

  const BanquetAvailabilityScreen({
    super.key,
    required this.hallName,
    required this.image,
    required this.capacity,
    required this.price,
  });

  @override
  State<BanquetAvailabilityScreen> createState() =>
      _BanquetAvailabilityScreenState();
}

class _BanquetAvailabilityScreenState
    extends State<BanquetAvailabilityScreen> {

  DateTime? selectedDate;

  String selectedEventType = 'Wedding';

  int guests = 100;

  // ---------------- SELECT DATE ----------------

  Future<void> selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  // ---------------- DATE FORMAT ----------------

  String get formattedDate {
    if (selectedDate == null) {
      return 'Select Event Date';
    }

    return '${selectedDate!.day}/'
        '${selectedDate!.month}/'
        '${selectedDate!.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),

      // ---------------- APP BAR ----------------

      appBar: AppBar(
        backgroundColor: const Color(0xFF3F4A32),
        elevation: 0,

        title: const Text(
          'Check Availability',
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

            // ---------------- HALL NAME ----------------

            Text(
              widget.hallName,
              style: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F4A32),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              widget.capacity,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 25),

            // ---------------- EVENT DATE ----------------

            const Text(
              'Event Date',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F4A32),
              ),
            ),

            const SizedBox(height: 10),

            GestureDetector(
              onTap: selectDate,

              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 17,
                ),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF3F4A32),
                  ),
                ),

                child: Row(
                  children: [

                    const Icon(
                      Icons.calendar_month,
                      color: Color(0xFF3F4A32),
                    ),

                    const SizedBox(width: 12),

                    Text(
                      formattedDate,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),

                    const Spacer(),

                    const Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xFF3F4A32),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ---------------- EVENT TYPE ----------------

            const Text(
              'Event Type',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F4A32),
              ),
            ),

            const SizedBox(height: 10),

            Container(
              width: double.infinity,

              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF3F4A32),
                ),
              ),

              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedEventType,

                  isExpanded: true,

                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Color(0xFF3F4A32),
                  ),

                  items: const [
                    DropdownMenuItem(
                      value: 'Wedding',
                      child: Text('Wedding'),
                    ),
                    DropdownMenuItem(
                      value: 'Birthday',
                      child: Text('Birthday'),
                    ),
                    DropdownMenuItem(
                      value: 'Corporate Event',
                      child: Text('Corporate Event'),
                    ),
                    DropdownMenuItem(
                      value: 'Conference',
                      child: Text('Conference'),
                    ),
                    DropdownMenuItem(
                      value: 'Other',
                      child: Text('Other'),
                    ),
                  ],

                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedEventType = value;
                      });
                    }
                  },
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ---------------- NUMBER OF GUESTS ----------------

            const Text(
              'Number of Guests',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F4A32),
              ),
            ),

            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF3F4A32),
                ),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  const Text(
                    'Guests',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),

                  Row(
                    children: [

                      // MINUS

                      IconButton(
                        onPressed: () {
                          if (guests > 1) {
                            setState(() {
                              guests--;
                            });
                          }
                        },

                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: Color(0xFF3F4A32),
                        ),
                      ),

                      Text(
                        '$guests',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3F4A32),
                        ),
                      ),

                      // PLUS

                      IconButton(
                        onPressed: () {
                          setState(() {
                            guests++;
                          });
                        },

                        icon: const Icon(
                          Icons.add_circle_outline,
                          color: Color(0xFF3F4A32),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            // ---------------- CHECK BUTTON ----------------

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () {
                   if (selectedDate == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Please select an event date',
        ),
      ),
    );

    return;
  }

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CustomizeSetupScreen(
        hallName: widget.hallName,
        capacity: widget.capacity,
        price: widget.price,
        eventDate: selectedDate!,
        eventType: selectedEventType,
        guests: guests,
      ),
    ),
  );
                },

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

                child: const Text(
                  'Check Availability',
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
}

