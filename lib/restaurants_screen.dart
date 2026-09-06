import 'package:flutter/material.dart';

class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Our Restaurants',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF68744A),
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              'A world of flavors, all under one roof.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 20),

            // =====================================================
            // BLUE LAGOON
            // =====================================================

            restaurantCard(
              context,
              name: 'Blue Lagoon',
              description: 'International Cuisine',
              logo: 'assets/restaurants/blue_lagoon_logo.jpeg',

              cardColor: const Color(0xFFDCEEFF),

              menuColor: const Color(0xFF1565C0),
              menuTextColor: Colors.black,
              priceColor: const Color(0xFF1565C0),

              introduction:
                  'Welcome to Blue Lagoon, where international '
                  'flavors meet elegant dining at Aurelia Grand Hotel. '
                  'Enjoy a carefully selected range of dishes, '
                  'refreshing beverages and delightful desserts '
                  'in a sophisticated dining atmosphere.',

              menu: const [
                'Pastas',
                'Burgers',
                'Exotic Drinks',
                'Steaks',
                'Shawarmas',
                'Prawns',
                'Chow Mein',
                'Hot Pot',
                'Desserts',
                'Coffee',
                'Tea',
                'Cheesecakes',
              ],

              prices: const [
                'PKR 3,200',
                'PKR 3,000',
                'PKR 3,500',
                'PKR 7,500',
                'PKR 3,200',
                'PKR 5,500',
                'PKR 3,800',
                'PKR 5,000',
                'PKR 3,200',
                'PKR 3,000',
                'PKR 2,500',
                'PKR 3,200',
              ],
            ),

            const SizedBox(height: 18),

            // =====================================================
            // DESI FUSION
            // =====================================================

            restaurantCard(
              context,
              name: 'Desi Fusion',
              description: 'Pakistani & Traditional',
              logo: 'assets/restaurants/desi_fusion_logo.jpeg',

              cardColor: const Color(0xFFFFE8D2),

              menuColor: const Color(0xFFB71C1C),
              menuTextColor: Colors.black,
              priceColor: const Color(0xFFB71C1C),

              introduction:
                  'Discover the rich and authentic taste of Pakistan '
                  'at Desi Fusion. From traditional breakfast favorites '
                  'to aromatic rice dishes and classic karahis, every '
                  'dish celebrates the warmth and heritage of Pakistani cuisine.',

              menu: const [
                'Halwa Puri',
                'Nihari',
                'Biryani',
                'Pulao',
                'BBQ Platter',
                'Handi',
                'Chicken Karahi',
                'Mutton Karahi',
                'Naan',
                'Roti',
              ],

              prices: const [
                'PKR 3,000',
                'PKR 3,500',
                'PKR 4,500',
                'PKR 3,400',
                'PKR 8,500',
                'PKR 5,500',
                'PKR 4,800',
                'PKR 6,500',
                'PKR 1,000',
                'PKR 700',
              ],
            ),

            const SizedBox(height: 18),

            // =====================================================
            // KUNGPAO
            // =====================================================

            restaurantCard(
              context,
              name: 'Kungpao',
              description: 'Chinese & Japanese',
              logo: 'assets/restaurants/kungpao_logo.jpeg',

              cardColor: const Color(0xFFE8E8E8),

              menuColor: const Color(0xFFB71C1C),
              menuTextColor: Colors.white,
              priceColor: const Color(0xFFE53935),

              introduction:
                  'Step into a world of Asian flavors at Kungpao, '
                  'featuring a selection of Chinese and Japanese favorites. '
                  'Enjoy beautifully prepared sushi, tempura, broths '
                  'and teppanyaki in a memorable dining experience.',

              menu: const [
                'Sushi Platter',
                'Prawn Tempura',
                'Vegetable Tempura',
                'Variety of Salads',
                'Authentic Sushi',
                'Sticky Rice with Broths',
                'Teppanyaki Station',
              ],

              prices: const [
                'PKR 8,500',
                'PKR 6,500',
                'PKR 3,500',
                'PKR 3,000',
                'PKR 7,500',
                'PKR 4,500',
                'PKR 10,000',
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =============================================================
  // RESTAURANT CARD
  // =============================================================

  Widget restaurantCard(
    BuildContext context, {
    required String name,
    required String description,
    required String logo,
    required Color cardColor,
    required Color menuColor,
    required Color menuTextColor,
    required Color priceColor,
    required String introduction,
    required List<String> menu,
    required List<String> prices,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      child: Container(
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
        ),

        child: Row(
          children: [

            // LOGO
            ClipRRect(
              borderRadius: BorderRadius.circular(15),

              child: Image.asset(
                logo,
                width: 90,
                height: 90,
                fit: BoxFit.cover,

                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 90,
                    height: 90,
                    color: Colors.white,

                    child: const Icon(
                      Icons.restaurant,
                      size: 40,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: 15),

            // INFORMATION
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: () {

                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (context) =>
                              RestaurantMenuScreen(
                            name: name,
                            logo: logo,
                            introduction: introduction,
                            menu: menu,
                            prices: prices,
                            menuColor: menuColor,
                            menuTextColor: menuTextColor,
                            priceColor: priceColor,
                          ),
                        ),
                      );
                    },

                    child: const Text(
                      'View Menu →',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// =================================================================
// RESTAURANT MENU SCREEN
// =================================================================

class RestaurantMenuScreen extends StatelessWidget {

  final String name;
  final String logo;
  final String introduction;

  final List<String> menu;
  final List<String> prices;

  final Color menuColor;
  final Color menuTextColor;
  final Color priceColor;

  const RestaurantMenuScreen({
    super.key,

    required this.name,
    required this.logo,
    required this.introduction,
    required this.menu,
    required this.prices,
    required this.menuColor,
    required this.menuTextColor,
    required this.priceColor,
  });

  @override
  Widget build(BuildContext context) {

    // =============================================================
    // RESTAURANT-SPECIFIC COLORS
    // =============================================================

    Color backgroundColor;
    Color cardColor;
    Color borderColor;

    if (name == 'Blue Lagoon') {

      // BLUE + WHITE
      backgroundColor = const Color(0xFFEAF6FF);
      cardColor = Colors.white;
      borderColor = const Color(0xFF1565C0);

    } else if (name == 'Desi Fusion') {

      // MULTI-COLORED
      backgroundColor = const Color(0xFFFFF3E0);
      cardColor = const Color(0xFFFFFDF7);
      borderColor = const Color(0xFFD84315);

    } else {

      // BLACK + RED
      backgroundColor = const Color(0xFF181818);
      cardColor = const Color(0xFF101010);
      borderColor = const Color(0xFFD32F2F);
    }


    return Scaffold(

      backgroundColor: backgroundColor,

      appBar: AppBar(
        title: Text(name),

        backgroundColor: menuColor,

        foregroundColor:
            name == 'Kungpao'
                ? Colors.white
                : Colors.white,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            // =====================================================
            // MENU CARD
            // =====================================================

            Container(

              width: double.infinity,

              padding: const EdgeInsets.fromLTRB(
                24,
                28,
                24,
                28,
              ),

              decoration: BoxDecoration(

                color: cardColor,

                borderRadius:
                    BorderRadius.circular(8),

                border: Border.all(
                  color: borderColor,
                  width: 3,
                ),

                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: const Offset(0, 4),

                    color:
                        Colors.black.withOpacity(0.20),
                  ),
                ],
              ),

              child: Column(
                children: [

                  // =================================================
                  // LOGO
                  // =================================================

                  Image.asset(
                    logo,

                    width: 115,
                    height: 115,

                    fit: BoxFit.contain,

                    errorBuilder:
                        (context, error, stackTrace) {

                      return Icon(
                        Icons.restaurant,
                        size: 80,
                        color: menuColor,
                      );
                    },
                  ),

                  const SizedBox(height: 15),

                  // =================================================
                  // RESTAURANT NAME
                  // =================================================

                  Text(
                    name.toUpperCase(),

                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,

                      color:
                          name == 'Kungpao'
                              ? Colors.white
                              : menuColor,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    name == 'Blue Lagoon'
                        ? 'INTERNATIONAL CUISINE'
                        : name == 'Desi Fusion'
                            ? 'PAKISTANI & TRADITIONAL CUISINE'
                            : 'CHINESE & JAPANESE CUISINE',

                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w600,

                      color:
                          name == 'Kungpao'
                              ? Colors.white70
                              : Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // =================================================
                  // INTRODUCTION
                  // =================================================

                  Text(
                    introduction,

                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,

                      color:
                          name == 'Kungpao'
                              ? Colors.white70
                              : Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 22),

                  // =================================================
                  // DECORATIVE LINE
                  // =================================================

                  Divider(
                    thickness: 2,
                    color: menuColor,
                  ),

                  const SizedBox(height: 12),

                  // =================================================
                  // MENU HEADING
                  // =================================================

                  Text(
                    'M E N U',

                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                      color: menuColor,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // =================================================
                  // MENU ITEMS
                  // =================================================

                  ...List.generate(
                    menu.length,

                    (index) {

                      return Padding(
                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 10,
                        ),

                        child: Row(
                          children: [

                            // DISH NAME
                            Expanded(
                              child: Text(
                                menu[index],

                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.w500,

                                  color:
                                      menuTextColor,
                                ),
                              ),
                            ),

                            // PRICE
                            Text(
                              prices[index],

                              style: TextStyle(
                                fontSize: 15,
                                fontWeight:
                                    FontWeight.bold,

                                color: priceColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 15),

                  Divider(
                    thickness: 2,
                    color: menuColor,
                  ),

                  const SizedBox(height: 15),

                  // =================================================
                  // MENU FOOTER
                  // =================================================

                  Text(
                    'A dining experience by Aurelia Grand',

                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,

                      color:
                          name == 'Kungpao'
                              ? Colors.white70
                              : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // =====================================================
            // ROOM SERVICE INFORMATION
            // =====================================================

            Container(

              width: double.infinity,

              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(

                color:
                    name == 'Kungpao'
                        ? const Color(0xFF2A2A2A)
                        : Colors.white,

                borderRadius:
                    BorderRadius.circular(12),

                border: Border.all(
                  color: menuColor,
                  width: 1.5,
                ),
              ),

              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Icon(
                    Icons.room_service,
                    color: menuColor,
                    size: 30,
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                          'Room Service',

                          style: TextStyle(
                            fontSize: 17,
                            fontWeight:
                                FontWeight.bold,

                            color:
                                name == 'Kungpao'
                                    ? Colors.white
                                    : Colors.black,
                                    ),
                        ),

                        const SizedBox(height: 7),

                        Text(
                          'Guests are welcome to visit the '
                          'restaurant and enjoy their meal in '
                          'person. Alternatively, selected dishes '
                          'can be ordered through Aurelia Grand\'s '
                          'room service and enjoyed from the '
                          'comfort and privacy of their room.',

                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,

                            color:
                                name == 'Kungpao'
                                    ? Colors.white70
                                    : Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
