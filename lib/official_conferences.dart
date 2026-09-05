import 'package:flutter/material.dart';
import 'conference_firestore.dart';

class OfficialConferences extends StatefulWidget {
  const OfficialConferences({super.key});

  @override
  State<OfficialConferences> createState() =>
      _OfficialConferencesState();
}

class _OfficialConferencesState extends State<OfficialConferences> {
  final Color olive = const Color(0xFF68744A);
  final Color lightOlive = const Color(0xFFE8EBDD);

  final List<Map<String, dynamic>> conferences = [
    {
      'name': 'Corporate Business Conference',
      'image': 'assets/conferences/corporate_conference.jpg',
      'price': 'PKR 150,000',
      'capacity': '100–150 Guests',
      'description':
          'A professional conference room designed for corporate meetings, presentations and official business events.',
      'facilities': [
        'Projector',
        'Sound System',
        'Wi-Fi',
        'Seating Arrangement',
        'Refreshments',
      ],
    },
    {
      'name': 'International Business Summit',
      'image': 'assets/conferences/business_summit.jpg',
      'price': 'PKR 250,000',
      'capacity': '200–300 Guests',
      'description':
          'A premium conference venue suitable for international business summits, seminars and large official gatherings.',
      'facilities': [
        'Stage',
        'LED Screen',
        'Sound System',
        'Wi-Fi',
        'Refreshments',
      ],
    },
    {
      'name': 'Executive Meeting Conference',
      'image': 'assets/conferences/executive_meeting.jpg',
      'price': 'PKR 75,000',
      'capacity': '30–50 Guests',
      'description':
          'A private and elegant conference room perfect for executive meetings, interviews and small official events.',
      'facilities': [
        'Conference Table',
        'Projector',
        'Wi-Fi',
        'Stationery',
        'Refreshments',
      ],
    },
    {
      'name': 'Annual Official Convention',
      'image': 'assets/conferences/annual_convention.jpg',
      'price': 'PKR 350,000',
      'capacity': '300–500 Guests',
      'description':
          'A grand conference venue designed for annual conventions, major official events and large gatherings.',
      'facilities': [
        'Grand Hall',
        'Stage',
        'LED Screen',
        'Sound System',
        'Seating Arrangement',
        'Refreshments',
      ],
    },
  ];

  final List<Map<String, dynamic>> cart = [];

  // Stores confirmed bookings locally
  final List<Map<String, dynamic>> bookings = [];

  // ==========================================================
  // CHECK DATE OVERLAP
  // ==========================================================

  bool datesOverlap(
    DateTime start1,
    DateTime end1,
    DateTime start2,
    DateTime end2,
  ) {
    return !end1.isBefore(start2) &&
        !start1.isAfter(end2);
  }

  // ==========================================================
  // CHECK CONFERENCE AVAILABILITY
  // ==========================================================

  bool isConferenceAvailable(
    String conferenceName,
    DateTime startDate,
    DateTime endDate,
  ) {
    for (final booking in bookings) {
      if (booking['conference'] == conferenceName) {
        final DateTime bookedStart = booking['startDate'];
        final DateTime bookedEnd = booking['endDate'];

        if (datesOverlap(
          startDate,
          endDate,
          bookedStart,
          bookedEnd,
        )) {
          return false;
        }
      }
    }

    return true;
  }

  // ==========================================================
  // FORMAT DATE
  // ==========================================================

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  // ==========================================================
  // BOOKING FORM
  // ==========================================================

  void showBookingForm(
    Map<String, dynamic> conference,
  ) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();

    DateTime? startDate;
    DateTime? endDate;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text(
                'Booking Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    // CONFERENCE NAME
                    Text(
                      conference['name'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: olive,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ORGANIZER NAME
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Organizer Name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // PHONE NUMBER
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ==================================================
                    // START DATE
                    // ==================================================

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: olive,
                          side: BorderSide(
                            color: olive,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                        ),

                        icon: const Icon(
                          Icons.calendar_month,
                        ),

                        label: Text(
                          startDate == null
                              ? 'Select Start Date'
                              : 'Start: ${formatDate(startDate!)}',
                        ),

                        onPressed: () async {
                          final DateTime? selected =
                              await showDatePicker(
                            context: context,
                            initialDate:
                                startDate ?? DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );

                          if (selected != null) {
                            setDialogState(() {
                              startDate = selected;

                              if (endDate != null &&
                                  endDate!.isBefore(selected)) {
                                endDate = null;
                              }
                            });
                          }
                        },
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ==================================================
                    // END DATE
                    // ==================================================

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: olive,
                          side: BorderSide(
                            color: olive,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                        ),

                        icon: const Icon(
                          Icons.calendar_month,
                        ),

                        label: Text(
                          endDate == null
                              ? 'Select End Date'
                              : 'End: ${formatDate(endDate!)}',
                        ),

                        onPressed: () async {
                          if (startDate == null) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please select the start date first.',
                                ),
                              ),
                            );
                            return;
                          }

                          final DateTime? selected =
                              await showDatePicker(
                            context: context,
                            initialDate:
                                endDate ?? startDate!,
                            firstDate: startDate!,
                            lastDate: DateTime(2100),
                          );

                          if (selected != null) {
                            setDialogState(() {
                              endDate = selected;
                            });
                          }
                        },
                      ),
                    ),

                    const SizedBox(height: 10),

                    // DATE INFORMATION
                    if (startDate != null &&
                        endDate != null)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: lightOlive,
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Booking Period\n'
                          '${formatDate(startDate!)} - '
                          '${formatDate(endDate!)}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: olive,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // ==================================================
              // BUTTONS
              // ==================================================

              actions: [

                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: olive,
                    ),
                  ),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: olive,
                    foregroundColor: Colors.white,
                  ),

                  onPressed: () async {

                    // CHECK NAME AND PHONE
                    if (nameController.text.isEmpty ||
                        phoneController.text.isEmpty) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please enter your name and phone number.',
                          ),
                        ),
                      );
                      return;
                    }

                    // CHECK DATES
                    if (startDate == null ||
                        endDate == null) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please select both booking dates.',
                          ),
                        ),
                      );
                      return;
                    }

                    // CHECK OVERLAPPING BOOKINGS
                    if (!isConferenceAvailable(
                      conference['name'],
                      startDate!,
                      endDate!,
                    )) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        SnackBar(
                          content: Text(
                            '${conference['name']} is already booked '
                            'for the selected dates.',
                          ),
                        ),
                      );
                      return;
                    }

                    // ==================================================
                    // SAVE BOOKING LOCALLY
                    // ==================================================

                    bookings.add({
                      'conference': conference['name'],
                      'startDate': startDate!,
                      'endDate': endDate!,
                      'name': nameController.text,
                      'phone': phoneController.text,
                    });

                    // ==================================================
                    // SAVE BOOKING TO FIRESTORE
                    // ==================================================

                    try {
                      final int price = int.parse(
                        conference['price']
                            .toString()
                            .replaceAll('PKR ', '')
                            .replaceAll(',', ''),
                      );

                      await ConferenceFirestoreService()
                          .saveBooking(
                        conferenceName:
                            conference['name'],
                        organizerName:
                            nameController.text,
                        phone:
                            phoneController.text,
                        startDate:
                            startDate!,
                        endDate:
                            endDate!,
                        price:
                            price,
                      );

                      // Close booking form
                      Navigator.pop(dialogContext);

                      // Show confirmation
                      showConfirmation(
                        conference,
                        nameController.text,
                        phoneController.text,
                        startDate!,
                        endDate!,
                      );
                    } catch (e) {

                      // If Firestore fails, show error
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        SnackBar(
                          content: Text(
                            'Booking could not be saved: $e',
                          ),
                        ),
                      );
                    }
                  },

                  child: const Text(
                    'Confirm',
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ==========================================================
  // CONFIRMATION DIALOG
  // ==========================================================

  void showConfirmation(
    Map<String, dynamic> conference,
    String name,
    String phone,
    DateTime startDate,
    DateTime endDate,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(

          icon: Icon(
            Icons.check_circle,
            color: olive,
            size: 55,
          ),

          title: const Text(
            'Booking Confirmed!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Text(
                  conference['name'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: olive,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                Text('Organizer: $name'),
                Text('Phone: $phone'),

                const SizedBox(height: 12),

                // BOOKING DATES
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),

                  decoration: BoxDecoration(
                    color: lightOlive,
                    borderRadius:
                        BorderRadius.circular(10),
                  ),

                  child: Column(
                    children: [

                      Text(
                        'Booking Dates',
                        style: TextStyle(
                          color: olive,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        '${formatDate(startDate)} - '
                        '${formatDate(endDate)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  conference['price'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  'Thank you for choosing Aurelia Grand Hotel.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: olive,
                  foregroundColor: Colors.white,
                ),

                onPressed: () {
                  Navigator.pop(context);
                },

                child: const Text(
                  'Done',
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F4),

      appBar: AppBar(
        backgroundColor: olive,
        foregroundColor: Colors.white,
        centerTitle: true,

        title: const Text(
          'Official Conferences',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    cart.isEmpty
                        ? 'Your cart is empty'
                        : '${cart.length} item(s) in your cart',
                  ),
                ),
              );
            },
          ),
        ],
      ),

      // ======================================================
      // SCROLLABLE CONFERENCE LIST
      // ======================================================

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          // HEADER
          Container(
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: lightOlive,
              borderRadius: BorderRadius.circular(18),
            ),

            child: Column(
              children: [
                Icon(
                  Icons.business_center,
                  size: 45,
                  color: olive,
                ),

                const SizedBox(height: 10),

                Text(
                  'Official Conferences',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: olive,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'Choose the perfect conference venue for your official event.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ==================================================
          // FOUR CONFERENCE ROOMS
          // ==================================================

          ...conferences.map(
            (conference) {
              return Card(
                margin: const EdgeInsets.only(bottom: 18),
                elevation: 4,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Column(
                  children: [

                    // CONFERENCE IMAGE
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),

                      child: Image.asset(
                        conference['image'],

                        width: double.infinity,

                        height: 1000,

                        fit: BoxFit.cover,

                        errorBuilder:
                            (context, error, stackTrace) {
                          return Container(
                            height: 1000,
                            width: double.infinity,
                            color: Colors.grey.shade300,

                            child: const Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,

                              children: [
                                Icon(
                                  Icons.image_not_supported,
                                  size: 50,
                                  color: Colors.grey,
                                ),

                                SizedBox(height: 8),

                                Text(
                                  'Conference Image Not Found',
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    // ==================================================
                    // EXPANDABLE / DROPDOWN SECTION
                    // ==================================================

                    ExpansionTile(
                      iconColor: olive,
                      collapsedIconColor: olive,

                      title: Text(
                        conference['name'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: olive,
                        ),
                      ),

                      subtitle: Text(
                        '${conference['capacity']} • '
                        '${conference['price']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      childrenPadding:
                          const EdgeInsets.fromLTRB(
                        16,
                        0,
                        16,
                        18,
                      ),

                      children: [

                        const Divider(),

                        const SizedBox(height: 8),

                        // DESCRIPTION
                        Align(
                          alignment: Alignment.centerLeft,

                          child: Text(
                            conference['description'],
                            style: const TextStyle(
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        // FACILITIES TITLE
                        Align(
                          alignment: Alignment.centerLeft,

                          child: Text(
                            'Facilities Included',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: olive,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        // FACILITIES
                        ...List.generate(
                          conference['facilities'].length,
                          (index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(
                                bottom: 7,
                              ),

                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: olive,
                                    size: 19,
                                  ),

                                  const SizedBox(width: 8),

                                  Expanded(
                                    child: Text(
                                      conference['facilities']
                                          [index],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 10),

                        // PRICE
                        Align(
                          alignment: Alignment.centerLeft,

                          child: Text(
                            conference['price'],
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: olive,
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        // BOOK BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 48,

                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: olive,
                              foregroundColor: Colors.white,

                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                            ),

                            icon: const Icon(
                              Icons.calendar_month,
                            ),

                            label: const Text(
                              'Book Conference',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            onPressed: () {
                              showBookingForm(
                                conference,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 15),

          // BOTTOM TEXT
          Center(
            child: Text(
              'AURELIA GRAND HOTEL\n'
              'Your Stay, Elevated. ✨',

              textAlign: TextAlign.center,

              style: TextStyle(
                color: olive,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
        
   
   