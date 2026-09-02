import 'package:flutter/material.dart';

// Your screens
import 'roomscreen.dart';
import 'banquet_halls_screen.dart';
import 'special_offers_screen.dart';

// Member 3 screens
// Change these file names if Member 3 uses different names.
// import 'restaurants_screen.dart';
// import 'conferences_screen.dart';
// import 'decorations_screen.dart';
// import 'health_club_screen.dart';

class ManagerDashboard extends StatelessWidget {
  const ManagerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),

      // ---------------- APP BAR ----------------

      appBar: AppBar(
        backgroundColor: const Color(0xFF3F4A32),
        elevation: 0,

        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Aurelia Grand',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                
              ),
            ),
            Text(
              'Good Morning Manager',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.white,
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: Color(0xFF3F4A32),
              ),
            ),
          ),
        ],
      ),

      // ---------------- BODY ----------------

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ---------------- WELCOME CARD ----------------

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: const Color(0xFF3F4A32),
                borderRadius: BorderRadius.circular(16),
              ),

              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Manage. Operate. Grow.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Manage all Aurelia Grand hotel services from one place.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Hotel Management',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F4A32),
              ),
            ),

            const SizedBox(height: 15),

            // ---------------- MODULE GRID ----------------

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              crossAxisSpacing: 12,
              mainAxisSpacing: 12,

              childAspectRatio: 1.15,

              children: [

                // ROOMS
                _dashboardCard(
                  context,
                  icon: Icons.hotel,
                  title: 'Rooms',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const RoomsScreen(),
                      ),
                    );
                  },
                ),

                // BANQUET HALLS
                _dashboardCard(
                  context,
                  icon: Icons.celebration,
                  title: 'Banquets',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const BanquetHallsScreen(),
                      ),
                    );
                  },
                ),

                // SPECIAL OFFERS
                _dashboardCard(
                  context,
                  icon: Icons.local_offer,
                  title: 'Special Offers',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const SpecialOffersScreen(),
                      ),
                    );
                  },
                ),

                // RESTAURANTS
                _dashboardCard(
                  context,
                  icon: Icons.restaurant,
                  title: 'Restaurants',
                  onTap: () {
                    // Member 3 screen will be connected here.
                  },
                ),

                // CONFERENCES
                _dashboardCard(
                  context,
                  icon: Icons.meeting_room,
                  title: 'Conferences',
                  onTap: () {
                    // Member 3 screen will be connected here.
                  },
                ),

                // DECORATIONS
                _dashboardCard(
                  context,
                  icon: Icons.auto_awesome,
                  title: 'Decorations',
                  onTap: () {
                    // Member 3 screen will be connected here.
                  },
                ),

                // HEALTH CLUB
                _dashboardCard(
                  context,
                  icon: Icons.fitness_center,
                  title: 'Health Club',
                  onTap: () {
                    // Member 3 screen will be connected here.
                  },
                ),

                // BOOKINGS
                _dashboardCard(
                  context,
                  icon: Icons.book_online,
                  title: 'Bookings',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Bookings screen will be connected here.',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 25),

            // ---------------- QUICK ACTIONS ----------------

            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F4A32),
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [

                Expanded(
                  child: _quickAction(
                    icon: Icons.people,
                    title: 'Customers',
                    onTap: () {},
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _quickAction(
                    icon: Icons.payment,
                    title: 'Payments',
                    onTap: () {},
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _quickAction(
                    icon: Icons.bar_chart,
                    title: 'Reports',
                    onTap: () {},
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ---------------- DASHBOARD CARD ----------------

  Widget _dashboardCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      color: Colors.white,
      elevation: 3,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),

      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              icon,
              size: 38,
              color: const Color(0xFF3F4A32),
            ),

            const SizedBox(height: 12),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F4A32),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- QUICK ACTION ----------------

  Widget _quickAction({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,

      borderRadius: BorderRadius.circular(12),

      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 5,
        ),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF3F4A32),
          ),
        ),

        child: Column(
          children: [

            Icon(
              icon,
              color: const Color(0xFF3F4A32),
            ),

            const SizedBox(height: 7),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F4A32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}