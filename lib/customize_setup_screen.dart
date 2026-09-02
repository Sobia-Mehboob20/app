
import 'package:flutter/material.dart';
import 'event_booking_screen.dart';
class CustomizeSetupScreen extends StatefulWidget {
  final String hallName;
  final String capacity;
  final String price;
  final DateTime eventDate;
  final String eventType;
  final int guests;

  const CustomizeSetupScreen({
    super.key,
    required this.hallName,
    required this.capacity,
    required this.price,
    required this.eventDate,
    required this.eventType,
    required this.guests,
  });

  @override
  State<CustomizeSetupScreen> createState() =>
      _CustomizeSetupScreenState();
}

class _CustomizeSetupScreenState
    extends State<CustomizeSetupScreen> {

  // ---------------- SELECTED OPTIONS ----------------

  String selectedSeating = 'Round Tables';

  String selectedDecoration = 'Premium';

  bool stageRequired = true;

  bool soundSystemRequired = true;

  // ---------------- DATE FORMAT ----------------

  String get formattedDate {
    return '${widget.eventDate.day}/'
        '${widget.eventDate.month}/'
        '${widget.eventDate.year}';
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
          'Customize Setup',
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

            // ---------------- HALL INFORMATION ----------------

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
              'Event: ${widget.eventType}',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              'Date: $formattedDate',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              'Guests: ${widget.guests}',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 30),

            // ---------------- SEATING ----------------

            const Text(
              'Seating Arrangement',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F4A32),
              ),
            ),

            const SizedBox(height: 10),

            _optionContainer(
              child: Column(
                children: [

                  _radioOption(
                    title: 'Round Tables',
                    value: 'Round Tables',
                  ),

                  _radioOption(
                    title: 'Theatre Style',
                    value: 'Theatre Style',
                  ),

                  _radioOption(
                    title: 'Classroom Style',
                    value: 'Classroom Style',
                  ),

                  _radioOption(
                    title: 'Banquet Style',
                    value: 'Banquet Style',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ---------------- DECORATION ----------------

            const Text(
              'Decoration Package',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F4A32),
              ),
            ),

            const SizedBox(height: 10),

            _optionContainer(
              child: Column(
                children: [

                  _radioOption(
                    title: 'Basic',
                    value: 'Basic',
                    group: 'decoration',
                  ),

                  _radioOption(
                    title: 'Premium',
                    value: 'Premium',
                    group: 'decoration',
                  ),

                  _radioOption(
                    title: 'Luxury',
                    value: 'Luxury',
                    group: 'decoration',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ---------------- STAGE ----------------

            const Text(
              'Stage',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F4A32),
              ),
            ),

            const SizedBox(height: 10),

            _switchContainer(
              title: 'Stage Required',
              value: stageRequired,
              onChanged: (value) {
                setState(() {
                  stageRequired = value;
                });
              },
            ),

            const SizedBox(height: 25),

            // ---------------- SOUND SYSTEM ----------------

            const Text(
              'Sound System',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F4A32),
              ),
            ),

            const SizedBox(height: 10),

            _switchContainer(
              title: 'Sound System Required',
              value: soundSystemRequired,
              onChanged: (value) {
                setState(() {
                  soundSystemRequired = value;
                });
              },
            ),

            const SizedBox(height: 35),

            // ---------------- CONTINUE BUTTON ----------------

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () {
                   Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EventBookingScreen(
        hallName: widget.hallName,
        capacity: widget.capacity,
        price: widget.price,
        eventDate: widget.eventDate,
        eventType: widget.eventType,
        guests: widget.guests,
        seating: selectedSeating,
        decoration: selectedDecoration,
        stageRequired: stageRequired,
        soundSystemRequired: soundSystemRequired,
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
                  'Continue',
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

  // ---------------- OPTION CONTAINER ----------------

  Widget _optionContainer({
    required Widget child,
  }) {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF3F4A32),
        ),
      ),

      child: child,
    );
  }

  // ---------------- RADIO OPTION ----------------

  Widget _radioOption({
    required String title,
    required String value,
    String group = 'seating',
  }) {
    final bool isSelected =
        group == 'seating'
            ? selectedSeating == value
            : selectedDecoration == value;

    return RadioListTile<String>(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 15,
        ),
      ),

      value: value,

      groupValue: group == 'seating'
          ? selectedSeating
          : selectedDecoration,

      activeColor: const Color(0xFF3F4A32),

      onChanged: (newValue) {
        if (newValue == null) return;

        setState(() {
          if (group == 'seating') {
            selectedSeating = newValue;
          } else {
            selectedDecoration = newValue;
          }
        });
      },
    );
  }

  // ---------------- SWITCH CONTAINER ----------------

  Widget _switchContainer({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF3F4A32),
        ),
      ),

      child: SwitchListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 15,
          ),
        ),

        value: value,

        activeThumbColor: const Color(0xFF3F4A32),

        onChanged: onChanged,
      ),
    );
  }
}
