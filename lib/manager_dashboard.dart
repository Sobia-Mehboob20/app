import 'package:flutter/material.dart';

import 'customers_screen.dart';
import 'manager_bookings_screen.dart';
import 'manager_payments_screen.dart';
import 'manager_reports_screen.dart';

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

  // =========================================================
  // BOTTOM NAVIGATION
  // =========================================================

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      body: IndexedStack(
        index: _selectedIndex,
        children: [_homePage(), _bookingsPage(), _messagesPage(), _morePage()],
      ),

      // =====================================================
      // BOTTOM NAVIGATION
      // =====================================================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,

        type: BottomNavigationBarType.fixed,

        backgroundColor: Colors.white,

        selectedItemColor: green,
        unselectedItemColor: lightGrey,

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

            iconTheme: const IconThemeData(color: Color(0xFFF5F0E8)),
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Aurelia Grand',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),

                Text(
                  'Good Morning Manager',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),

            actions: [
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No new notifications')),
                  );
                },
                icon: const Icon(Icons.notifications_none, color: Colors.white),
              ),

              const Padding(
                padding: EdgeInsets.only(right: 12),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: green),
                ),
              ),
            ],
          ),

          // -------------------------------------------------
          // HOTEL IMAGE
          // -------------------------------------------------
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),

                child: Stack(
                  children: [
                    Image.network(
                      'https://images.unsplash.com/photo-1566073771259-6a8506099945',

                      width: double.infinity,
                      height: 190,
                      fit: BoxFit.cover,

                      errorBuilder: (context, error, stackTrace) {
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

                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,

                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.65),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const Positioned(
                      left: 18,
                      bottom: 16,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            'Aurelia Grand',
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),

                          SizedBox(height: 4),

                          Text(
                            'Hotel • Events • Dining • Wellness',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
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
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),

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
                      style: TextStyle(color: Colors.white, fontSize: 21),
                    ),

                    SizedBox(height: 8),

                    Text(
                      'Manage customers, bookings, payments and reports from one place.',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
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
              padding: EdgeInsets.fromLTRB(16, 25, 16, 14),

              child: Text(
                'Manager Services',
                style: TextStyle(fontSize: 21, color: green),
              ),
            ),
          ),

          // =================================================
          // MANAGER CARDS
          // =================================================
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),

            sliver: SliverGrid.count(
              crossAxisCount: 2,

              crossAxisSpacing: 12,
              mainAxisSpacing: 12,

              childAspectRatio: 1.15,

              children: [
                // =================================================
                // CUSTOMERS
                // =================================================

                _dashboardCard(
                  icon: Icons.people_outline,
                  title: 'Customers',

                  onTap: () {
                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (context) => const CustomersScreen(),
                      ),
                    );
                  },
                ),

                // =================================================
                // BOOKINGS
                // =================================================
                _dashboardCard(
                  icon: Icons.calendar_month_outlined,
                  title: 'Bookings',

                  onTap: () {
                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (context) => const ManagerBookingsScreen(),
                      ),
                    );
                  },
                ),

                // =================================================
                // PAYMENTS
                // =================================================
                _dashboardCard(
                  icon: Icons.payment_outlined,
                  title: 'Payments',

                  onTap: () {
                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (context) => const ManagerPaymentsScreen(),
                      ),
                    );
                  },
                ),

                // =================================================
                // MESSAGES
                // =================================================
                _dashboardCard(
                  icon: Icons.chat_bubble_outline,
                  title: 'Messages',

                  onTap: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                ),

                // =================================================
                // REPORTS
                // =================================================
                _dashboardCard(
                  icon: Icons.bar_chart_outlined,
                  title: 'Reports',

                  onTap: () {
                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (context) => const ManagerReportsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 30)),
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

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

      child: InkWell(
        borderRadius: BorderRadius.circular(15),

        onTap: onTap,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(icon, size: 35, color: green),

            const SizedBox(height: 10),

            Text(
              title,

              textAlign: TextAlign.center,

              style: const TextStyle(fontSize: 14, color: green),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // BOOKINGS BOTTOM NAVIGATION PAGE
  // =========================================================

  Widget _bookingsPage() {
    return const ManagerBookingsScreen();
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

  leading: IconButton(
    icon: const Icon(
      Icons.arrow_back,
      color: Color(0xFFF5F0E8),
    ),
    onPressed: () {
      setState(() {
        _selectedIndex = 0;
      });
    },
  ),

  title: const Text(
    'Messages',
    style: TextStyle(
      color: Colors.white,
      fontSize: 19,
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
                  color: green.withValues(alpha: 0.7),
                ),

                const SizedBox(height: 15),

                const Text(
                  'No Messages Available',

                  style: TextStyle(fontSize: 19, color: green),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Messages will appear here when\n'
                  'messaging is added to the system.',

                  textAlign: TextAlign.center,

                  style: TextStyle(fontSize: 13, color: Colors.black54),
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

  leading: IconButton(
    icon: const Icon(
      Icons.arrow_back,
      color: Color(0xFFF5F0E8),
    ),
    onPressed: () {
      setState(() {
        _selectedIndex = 0;
      });
    },
  ),

  title: const Text(
    'More',
    style: TextStyle(
      color: Colors.white,
      fontSize: 19,
    ),
  ),
),

        body: ListView(
          padding: const EdgeInsets.all(16),

          children: [
            _moreTile(
              icon: Icons.people_outline,
              title: 'Manage Customers',

              onTap: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) => const CustomersScreen(),
                  ),
                );
              },
            ),

            _moreTile(
              icon: Icons.calendar_month_outlined,
              title: 'Bookings',

              onTap: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) => const ManagerBookingsScreen(),
                  ),
                );
              },
            ),

            _moreTile(
              icon: Icons.payment_outlined,
              title: 'Payments',

              onTap: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) => const ManagerPaymentsScreen(),
                  ),
                );
              },
            ),

            _moreTile(
              icon: Icons.bar_chart_outlined,
              title: 'Reports',

              onTap: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) => const ManagerReportsScreen(),
                  ),
                );
              },
            ),

            _moreTile(
              icon: Icons.settings_outlined,
              title: 'Settings',

              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Settings will be connected later.'),
                  ),
                );
              },
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

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),

      child: ListTile(
        onTap: onTap,

        leading: Icon(icon, color: green),

        title: Text(title, style: const TextStyle(color: green, fontSize: 14)),

        trailing: const Icon(Icons.arrow_forward_ios, size: 15, color: green),
      ),
    );
  }
}