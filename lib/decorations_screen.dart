import 'package:flutter/material.dart';

class DecorationsScreen extends StatelessWidget {
  const DecorationsScreen({super.key});

  final Color olive = const Color(0xFF68744A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F4),

      appBar: AppBar(
        backgroundColor: olive,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Room Decorations',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
         iconTheme: const IconThemeData(
          color: Color(0xFFF5F0E8),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // =====================================================
          // HEADER
          // =====================================================

          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: const Color(0xFFE8EBDD),
              borderRadius: BorderRadius.circular(18),
            ),

            child: Column(
              children: [

                Icon(
                  Icons.auto_awesome,
                  size: 45,
                  color: olive,
                ),

                const SizedBox(height: 10),

                Text(
                  'Make Your Stay Special',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: olive,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Explore our room decoration ideas '
                  'and make your stay memorable.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // =====================================================
          // IMPORTANT BOOKING NOTICE
          // =====================================================

          Container(
            padding: const EdgeInsets.all(18),

            decoration: BoxDecoration(
              color: const Color(0xFFE8EBDD),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: olive,
                width: 1.5,
              ),
            ),

            child: Column(
              children: [

                Icon(
                  Icons.info_outline,
                  color: olive,
                  size: 32,
                ),

                const SizedBox(height: 8),

                const Text(
                  'IMPORTANT',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF68744A),
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Decoration booking will be done '
                  'PHYSICALLY through the hotel manager '
                  'during your stay.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Additional changes or customization '
                  'to the decoration can also be discussed '
                  'with the manager and may result in '
                  'additional charges.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          // =====================================================
          // HONEYMOON
          // =====================================================

          decorationCard(
            context,
            'Honeymoon',
            'assets/decorations/honeymoon.jpg',
            Icons.favorite,
            'PKR 25,000',
            'Create a romantic and unforgettable honeymoon '
            'experience in your room.',
            [
              'Fairy Lights',
              'Fresh Roses',
              'Cute Teddies',
              'Candlelight Dinner',
              'Aesthetic Music',
            ],
          ),

          // =====================================================
          // STAYCATION
          // =====================================================

          decorationCard(
            context,
            'Staycation',
            'assets/decorations/staycation.jpg',
            Icons.hotel,
            'PKR 15,000',
            'Enjoy a cozy, relaxing and aesthetic staycation '
            'experience in your hotel room.',
            [
              'Cozy Room Setup',
              'Fairy Lights',
              'Soft Ambient Lighting',
              'Decorative Elements',
              'Relaxing Ambience',
            ],
          ),

          // =====================================================
          // BIRTHDAY
          // =====================================================

          decorationCard(
            context,
            'Birthday Decoration',
            'assets/decorations/birthday.jpg',
            Icons.cake,
            'PKR 20,000',
            'Celebrate your special day with a beautiful '
            'birthday setup in your room.',
            [
              'Birthday Balloons',
              'Birthday Banner',
              'Cake Table Decoration',
              'Fairy Lights',
              'Room Decoration',
            ],
          ),

          // =====================================================
          // GAMES NIGHT
          // =====================================================

          decorationCard(
            context,
            'Games Night',
            'assets/decorations/games_night.jpg',
            Icons.sports_esports,
            'PKR 12,000',
            'Turn your room into a fun and entertaining '
            'games night setup.',
            [
              'Board Games',
              'Playing Cards',
              'Snacks Setup',
              'Ambient Lighting',
              'Fun Room Arrangement',
            ],
          ),

          // =====================================================
          // GIRLS NIGHT OUT
          // =====================================================

          decorationCard(
            context,
            'Girls Night Out',
            'assets/decorations/girls_night.jpg',
            Icons.groups,
            'PKR 18,000',
            'Enjoy a fun, aesthetic and memorable girls '
            'night experience at Aurelia Grand.',
            [
              'Pink Aesthetic Decoration',
              'Balloons',
              'Fairy Lights',
              'Photo Corner',
              'Snacks & Aesthetic Setup',
            ],
          ),

          const SizedBox(height: 20),

          // =====================================================
          // BOTTOM NOTICE
          // =====================================================

          Container(
            padding: const EdgeInsets.all(15),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),

            child: const Text(
              'Please note: Displayed prices are starting '
              'prices. Final charges may vary depending on '
              'additional decorations or customization '
              'requested from the manager.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                height: 1.5,
                color: Colors.grey,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // =====================================================
          // BOTTOM BRANDING
          // =====================================================

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

  // ===========================================================
  // DECORATION CARD
  // ===========================================================

  Widget decorationCard(
    BuildContext context,
    String title,
    String image,
    IconData icon,
    String price,
    String description,
    List<String> items,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      elevation: 4,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        children: [

          // ===================================================
          // IMAGE
          // ===================================================

          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),

            child: Image.asset(
              image,
              width: double.infinity,

              // INCREASED IMAGE HEIGHT
              height: 1000,

              fit: BoxFit.cover,

              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 1000,
                  width: double.infinity,
                  color: Colors.grey.shade300,

                  child: Icon(
                    icon,
                    size: 60,
                    color: olive,
                  ),
                );
              },
            ),
          ),

          // ===================================================
          // EXPANDABLE DETAILS
          // ===================================================

          ExpansionTile(
            iconColor: olive,
            collapsedIconColor: olive,

            leading: Icon(
              icon,
              color: olive,
            ),

            title: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: olive,
              ),
            ),

            subtitle: Text(
              price,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: olive,
              ),
            ),

            childrenPadding: const EdgeInsets.fromLTRB(
              16,
              0,
              16,
              18,
            ),

            children: [

              const Divider(),

              const SizedBox(height: 8),

              // =================================================
              // DESCRIPTION
              // =================================================

              Align(
                alignment: Alignment.centerLeft,

                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // =================================================
              // PRICE
              // =================================================

              Align(
                alignment: Alignment.centerLeft,

                child: Text(
                  price,
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: olive,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // =================================================
              // INCLUDED
              // =================================================

              Align(
                alignment: Alignment.centerLeft,

                child: Text(
                  'What’s Included',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: olive,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              ...items.map(
                (item) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 9,
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
                            item,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 10),

              // =================================================
              // PHYSICAL BOOKING NOTICE
              // =================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(13),

                decoration: BoxDecoration(
                  color: const Color(0xFFE8EBDD),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: const Text(
                  'BOOKING IS DONE PHYSICALLY.\n'
                  'Please contact the hotel manager '
                  'during your stay. Additional changes '
                  'or customization may have additional charges.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
