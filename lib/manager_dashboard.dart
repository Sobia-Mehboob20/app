import 'package:flutter/material.dart';

// Your screens
import 'roomscreen.dart';
import 'banquet_halls_screen.dart';
import 'special_offers_screen.dart';
import 'customers_screen.dart';
// Member 3 screens
// Add these imports when Member 3 gives you the exact file names.
// import 'restaurants_screen.dart';
// import 'conferences_screen.dart';
// import 'decorations_screen.dart';
// import 'health_club_screen.dart';

class ManagerDashboard extends StatefulWidget {
  const ManagerDashboard({super.key});

  @override
  State<ManagerDashboard> createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard> {
  static const Color green = Color(0xFF3F4A32);
  static const Color background = Color(0xFFF5F0E8);
  static const Color lightGrey = Color(0xFF9A9A9A);

  int _selectedIndex = 0;

  // ---------------------------------------------------------
  // BOTTOM NAVIGATION
  // ---------------------------------------------------------

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // ---------------------------------------------------------
  // BUILD
  // ---------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _homePage(),
          _bookingsPage(),
          _messagesPage(),
          _morePage(),
        ],
      ),

      // -----------------------------------------------------
      // BOTTOM NAVIGATION
      // -----------------------------------------------------

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,

        type: BottomNavigationBarType.fixed,

        backgroundColor: Colors.white,

        selectedItemColor: green,
        unselectedItemColor: lightGrey,

        selectedLabelStyle: const TextStyle(
          color: green,
          fontSize: 11,
          fontWeight: FontWeight.normal,
        ),

        unselectedLabelStyle: const TextStyle(
          color: lightGrey,
          fontSize: 11,
          fontWeight: FontWeight.normal,
        ),

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            activeIcon: Icon(Icons.calendar_month),
            label: 'Bookings',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'Messages',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            activeIcon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }

  // =========================================================
  // HOME PAGE
  // =========================================================

  Widget _homePage() {
    return SafeArea(
      child: CustomScrollView(
        slivers: [

          // -------------------------------------------------
          // APP BAR
          // -------------------------------------------------

          SliverAppBar(
            backgroundColor: green,
            elevation: 0,

            pinned: true,

            expandedHeight: 80,

            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Aurelia Grand',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),

                Text(
                  'Good Morning Manager',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),

            actions: [

              // Notification
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No new notifications'),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                ),
              ),

              // Profile
              const Padding(
                padding: EdgeInsets.only(right: 12),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: green,
                  ),
                ),
              ),
            ],
          ),

          // -------------------------------------------------
          // HOTEL IMAGE
          // -------------------------------------------------

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                16,
                16,
                0,
              ),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),

                child: Stack(
                  children: [

                    Image.network(
                      'https://images.unsplash.com/photo-1566073771259-6a8506099945',
                      width: double.infinity,
                      height: 190,
                      fit: BoxFit.cover,

                      errorBuilder: (
                        context,
                        error,
                        stackTrace,
                      ) {
                        return Container(
                          height: 190,
                          color: green,
                          child: const Center(
                            child: Icon(
                              Icons.hotel,
                              color: Colors.white,
                              size: 60,
                            ),
                          ),
                        );
                      },
                    ),

                    // Dark overlay
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

                    // Image text
                    const Positioned(
                      left: 18,
                      bottom: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Aurelia Grand',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.normal,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            'Hotel • Events • Dining • Wellness',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // -------------------------------------------------
          // WELCOME CARD
          // -------------------------------------------------

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                18,
                16,
                0,
              ),

              child: Container(
                width: double.infinity,

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: green,
                  borderRadius: BorderRadius.circular(16),
                ),

                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      'Manage. Operate. Grow.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.normal,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      'Manage all Aurelia Grand hotel services from one place.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // -------------------------------------------------
          // MANAGEMENT TITLE
          // -------------------------------------------------

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                16,
                25,
                16,
                14,
              ),

              child: Text(
                'Hotel Management',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.normal,
                  color: green,
                ),
              ),
            ),
          ),

          // -------------------------------------------------
          // MODULE GRID
          // -------------------------------------------------

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),

            sliver: SliverGrid.count(
              crossAxisCount: 2,

              crossAxisSpacing: 12,
              mainAxisSpacing: 12,

              childAspectRatio: 1.15,

              children: [

                // ROOMS
                _dashboardCard(
                  icon: Icons.hotel_outlined,
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

                // BANQUETS
                _dashboardCard(
                  icon: Icons.celebration_outlined,
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
                  icon: Icons.local_offer_outlined,
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
                  icon: Icons.restaurant_outlined,
                  title: 'Restaurants',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Restaurant management will be connected.',
                        ),
                      ),
                    );
                  },
                ),

                // CONFERENCES
                _dashboardCard(
                  icon: Icons.meeting_room_outlined,
                  title: 'Conferences',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Conference management will be connected.',
                        ),
                      ),
                    );
                  },
                ),

                // DECORATIONS
                _dashboardCard(
                  icon: Icons.auto_awesome_outlined,
                  title: 'Decorations',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Decoration management will be connected.',
                        ),
                      ),
                    );
                  },
                ),

                // HEALTH CLUB
                _dashboardCard(
                  icon: Icons.fitness_center_outlined,
                  title: 'Health Club',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Health Club management will be connected.',
                        ),
                      ),
                    );
                  },
                ),

                // BOOKINGS
                _dashboardCard(
                  icon: Icons.book_online_outlined,
                  title: 'Bookings',
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                ),
              ],
            ),
          ),

          // -------------------------------------------------
          // QUICK ACTIONS
          // -------------------------------------------------

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                16,
                28,
                16,
                14,
              ),

              child: Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.normal,
                  color: green,
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),

              child: Row(
                children: [
                  Expanded(
  child: _quickAction(
    icon: Icons.people_outline,
    title: 'Customers',
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const CustomersScreen(),
        ),
      );
    },
  ),
),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _quickAction(
                      icon: Icons.payment_outlined,
                      title: 'Payments',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Payment management will be connected.',
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _quickAction(
                      icon: Icons.bar_chart_outlined,
                      title: 'Reports',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Reports will be connected.',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 25),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // DASHBOARD CARD
  // =========================================================

  Widget _dashboardCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      color: Colors.white,

      elevation: 2,

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
              size: 35,
              color: green,
            ),

            const SizedBox(height: 10),

            Text(
              title,
              textAlign: TextAlign.center,

              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // QUICK ACTION
  // =========================================================

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
            color: green,
            width: 0.8,
          ),
        ),

        child: Column(
          children: [

            Icon(
              icon,
              color: green,
              size: 23,
            ),

            const SizedBox(height: 7),

            Text(
              title,
              textAlign: TextAlign.center,

              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.normal,
                color: green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // BOOKINGS PAGE
  // =========================================================

  Widget _bookingsPage() {
    return SafeArea(
      child: Scaffold(
        backgroundColor: background,

        appBar: AppBar(
          backgroundColor: green,
          elevation: 0,

          title: const Text(
            'Bookings',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),

        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Icon(
                  Icons.calendar_month_outlined,
                  size: 65,
                  color: green.withOpacity(0.7),
                ),

                const SizedBox(height: 15),

                const Text(
                  'All Bookings',
                  style: TextStyle(
                    fontSize: 20,
                    color: green,
                    fontWeight: FontWeight.normal,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Bookings from Rooms, Banquets,\n'
                  'Restaurants, Conferences, Decorations\n'
                  'and Health Club will appear here.',
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    fontWeight: FontWeight.normal,
                  ),
                ),

                const SizedBox(height: 20),

                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Booking data will be loaded from each module collection.',
                        ),
                      ),
                    );
                  },

                  icon: const Icon(
                    Icons.refresh,
                    color: green,
                  ),

                  label: const Text(
                    'Refresh',
                    style: TextStyle(
                      color: green,
                      fontWeight: FontWeight.normal,
                    ),
                  ),

                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: green,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // MESSAGES PAGE
  // =========================================================

  Widget _messagesPage() {
    return SafeArea(
      child: Scaffold(
        backgroundColor: background,

        appBar: AppBar(
          backgroundColor: green,
          elevation: 0,

          title: const Text(
            'Messages',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),

        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Icon(
                  Icons.chat_bubble_outline,
                  size: 65,
                  color: green.withOpacity(0.7),
                ),

                const SizedBox(height: 15),

                const Text(
                  'No Messages Available',
                  style: TextStyle(
                    fontSize: 19,
                    color: green,
                    fontWeight: FontWeight.normal,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Messages will appear here when\n'
                  'messaging is added to the system.',
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // MORE PAGE
  // =========================================================

  Widget _morePage() {
    return SafeArea(
      child: Scaffold(
        backgroundColor: background,

        appBar: AppBar(
          backgroundColor: green,
          elevation: 0,

          title: const Text(
            'More',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),

        body: ListView(
          padding: const EdgeInsets.all(16),

          children: [

            _moreTile(
              icon: Icons.local_offer_outlined,
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

            _moreTile(
              icon: Icons.people_outline,
              title: 'Manage Customers',
              onTap: () {},
            ),

            _moreTile(
              icon: Icons.payment_outlined,
              title: 'Payments',
              onTap: () {},
            ),

            _moreTile(
              icon: Icons.bar_chart_outlined,
              title: 'Reports',
              onTap: () {},
            ),

            _moreTile(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // MORE TILE
  // =========================================================

  Widget _moreTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      color: Colors.white,

      elevation: 1,

      margin: const EdgeInsets.only(bottom: 10),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),

      child: ListTile(
        onTap: onTap,

        leading: Icon(
          icon,
          color: green,
        ),

        title: Text(
          title,
          style: const TextStyle(
            color: green,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 15,
          color: green,
        ),
      ),
    );
  }
}