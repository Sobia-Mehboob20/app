import 'package:flutter/material.dart';

class CustomerDashboard extends StatefulWidget {
  const CustomerDashboard({super.key});

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  static const Color olive = Color(0xFF68744A);
  static const Color lightOlive = Color(0xFFE8EBDD);
  static const Color background = Color(0xFFF9F9F4);

  // ============================================================
  // NAVIGATION
  // ============================================================

  void openPage(String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: background,
        elevation: 0,

        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, Guest',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Aurelia Grand Hotel',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: olive,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 19,
              backgroundColor: lightOlive,
              child: const Icon(
                Icons.person_outline,
                color: olive,
              ),
            ),
          ),
        ],
      ),

      // ========================================================
      // SCROLLABLE BODY
      // ========================================================

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),

        padding: const EdgeInsets.fromLTRB(
          16,
          5,
          16,
          30,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ==================================================
            // HOTEL BANNER
            // ==================================================

            ClipRRect(
              borderRadius: BorderRadius.circular(18),

              child: Stack(
                children: [

                  Image.asset(
                    'assets/hotel/hotel_main.jpg',
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,

                    errorBuilder:
                        (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 180,
                        color: olive,
                        child: const Center(
                          child: Icon(
                            Icons.hotel,
                            size: 65,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),

                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.65),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const Positioned(
                    left: 18,
                    bottom: 18,

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        Text(
                          'Luxury. Comfort. Unforgettable.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          'Your Stay, Elevated. ✨',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ==================================================
            // WELCOME
            // ==================================================

            const Text(
              'Explore Aurelia Grand',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Everything you need for a comfortable and memorable stay.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 18),

            // ==================================================
            // MAIN MODULE GRID
            // ==================================================

            GridView.count(
              crossAxisCount: 2,

              crossAxisSpacing: 12,
              mainAxisSpacing: 12,

              childAspectRatio: 1.18,

              shrinkWrap: true,

              physics:
                  const NeverScrollableScrollPhysics(),

              children: [

                // =================================================
                // RESTAURANTS
                // =================================================

                serviceCard(
                  icon: Icons.restaurant_outlined,
                  title: 'Restaurants',
                  subtitle: 'Explore Dining',
                  onTap: () {
                    openPage('/restaurants');
                  },
                ),

                // =================================================
                // CONFERENCES
                // =================================================

                serviceCard(
                  icon: Icons.business_outlined,
                  title: 'Conferences',
                  subtitle: 'Official Events',
                  onTap: () {
                    openPage('/official-conferences');
                  },
                ),

                // =================================================
                // DECORATIONS
                // =================================================

                serviceCard(
                  icon: Icons.auto_awesome_outlined,
                  title: 'Decorations',
                  subtitle: 'Special Occasions',
                  onTap: () {
                    openPage('/decorations');
                  },
                ),

                // =================================================
                // HEALTH CLUB
                // =================================================

                serviceCard(
                  icon: Icons.fitness_center_outlined,
                  title: 'Health Club',
                  subtitle: 'Fitness & Wellness',
                  onTap: () {
                    openPage('/health-club');
                  },
                ),

                // =================================================
                // OUR STORY
                // =================================================

                serviceCard(
                  icon: Icons.auto_stories_outlined,
                  title: 'Our Story',
                  subtitle: 'Discover Our Hotel',
                  onTap: () {
                    openPage('/our-story');
                  },
                ),

                // =================================================
                // ROOMS - GROUP MEMBER
                // =================================================

                serviceCard(
                  icon: Icons.hotel_outlined,
                  title: 'Rooms',
                  subtitle: 'Explore Our Rooms',
                  onTap: () {
                    openPage('/rooms');
                  },
                ),

                // =================================================
                // BANQUET HALLS - GROUP MEMBER
                // =================================================

                serviceCard(
                  icon: Icons.event_outlined,
                  title: 'Banquet Halls',
                  subtitle: 'Events & Celebrations',
                  onTap: () {
                    openPage('/banquet-halls');
                  },
                ),

                // =================================================
                // SPECIAL OFFERS - GROUP MEMBER
                // =================================================

                serviceCard(
                  icon: Icons.local_offer_outlined,
                  title: 'Special Offers',
                  subtitle: 'Exclusive Deals',
                  onTap: () {
                    openPage('/special-offers');
                  },
                ),
              ],
            ),

            const SizedBox(height: 28),

            // ==================================================
            // HOTEL HIGHLIGHT
            // ==================================================

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: lightOlive,
                borderRadius: BorderRadius.circular(18),
              ),

              child: const Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Row(
                    children: [
                      Icon(
                        Icons.star_outline,
                        color: olive,
                        size: 28,
                      ),

                      SizedBox(width: 10),

                      Text(
                        'Aurelia Grand Experience',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: olive,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  Text(
                    'Stay • Dine • Celebrate • Wellness',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Discover our dining experiences, official '
                    'conference facilities, room decorations, '
                    'health club and the story behind Aurelia Grand.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ==================================================
            // OUR STORY QUICK LINK
            // ==================================================

            InkWell(
              onTap: () {
                openPage('/our-story');
              },

              borderRadius: BorderRadius.circular(16),

              child: Container(
                width: double.infinity,

                padding: const EdgeInsets.all(17),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(16),

                  boxShadow: [
                    BoxShadow(
                      color:
                          Colors.black.withOpacity(0.05),
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),

                child: Row(
                  children: [

                    Container(
                      padding: const EdgeInsets.all(11),

                      decoration: BoxDecoration(
                        color: lightOlive,
                        borderRadius:
                            BorderRadius.circular(12),
                      ),

                      child: const Icon(
                        Icons.menu_book_outlined,
                        color: olive,
                        size: 27,
                      ),
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          Text(
                            'Discover Our Story',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            'Learn more about Aurelia Grand Hotel',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: olive,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ==================================================
            // FOOTER
            // ==================================================

            const Center(
              child: Column(
                children: [

                  Text(
                    'AURELIA GRAND HOTEL',
                    style: TextStyle(
                      color: olive,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),

                  SizedBox(height: 6),

                  Text(
                    'Your Stay, Elevated. ✨',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SERVICE CARD
  // ============================================================

  Widget serviceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,

      borderRadius: BorderRadius.circular(16),

      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(16),

          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withOpacity(0.06),

              blurRadius: 7,

              offset: const Offset(0, 3),
            ),
          ],
        ),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            Container(
              padding: const EdgeInsets.all(13),

              decoration: BoxDecoration(
                color: lightOlive,

                shape: BoxShape.circle,
              ),

              child: Icon(
                icon,
                size: 30,
                color: olive,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              title,
              textAlign: TextAlign.center,

              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              subtitle,
              textAlign: TextAlign.center,

              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
      