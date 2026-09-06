import 'package:flutter/material.dart';

class OfficialConferences extends StatefulWidget {
  const OfficialConferences({super.key});

  @override
  State<OfficialConferences> createState() =>
      _OfficialConferencesState();
}

class _OfficialConferencesState extends State<OfficialConferences> {
  final Color olive = const Color(0xFF68744A);
  final Color lightOlive = const Color(0xFFE8EBDD);

  // ==========================================================
  // CONFERENCE CATALOG
  // ==========================================================

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

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F4),

      // ======================================================
      // APP BAR
      // ======================================================

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
      ),

      // ======================================================
      // SCROLLABLE CATALOG
      // ======================================================

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          // ==================================================
          // HEADER
          // ==================================================

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

                const SizedBox(height: 8),

                const Text(
                  'Explore our conference venues, facilities, '
                  'capacity and available packages.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ==================================================
          // CONFERENCE CATALOG
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

                    // ==================================================
                    // CONFERENCE IMAGE
                    // ==================================================

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
                    // DROPDOWN DETAILS
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

                        // ==================================================
                        // DESCRIPTION
                        // ==================================================

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

                        const SizedBox(height: 18),

                        // ==================================================
                        // CAPACITY
                        // ==================================================

                        Align(
                          alignment: Alignment.centerLeft,

                          child: Text(
                            'Capacity',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: olive,
                            ),
                          ),
                        ),

                        const SizedBox(height: 6),

                        Align(
                          alignment: Alignment.centerLeft,

                          child: Text(
                            conference['capacity'],
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // ==================================================
                        // FACILITIES
                        // ==================================================

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

                        const SizedBox(height: 15),

                        // ==================================================
                        // PACKAGE PRICE - CATALOG INFORMATION ONLY
                        // ==================================================

                        Container(
                          width: double.infinity,

                          padding: const EdgeInsets.all(14),

                          decoration: BoxDecoration(
                            color: lightOlive,
                            borderRadius:
                                BorderRadius.circular(12),
                          ),

                          child: Column(
                            children: [

                              Text(
                                'Conference Package',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: olive,
                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),

                              const SizedBox(height: 5),

                              Text(
                                conference['price'],
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: olive,
                                ),
                              ),

                              const SizedBox(height: 5),

                              const Text(
                                'Price shown for catalog information only.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
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

          // ==================================================
          // BOTTOM TEXT
          // ==================================================

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