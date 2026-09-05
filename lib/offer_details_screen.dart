import 'package:flutter/material.dart';
import 'roomscreen.dart';
class OfferDetailsScreen extends StatelessWidget {
  final String title;
  final String discount;
  final String description;
  final String image;

  const OfferDetailsScreen({
    super.key,
    required this.title,
    required this.discount,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),

      appBar: AppBar(
        backgroundColor: const Color(0xFF3F4A32),
        elevation: 0,

        title: const Text(
          'Offer Details',
          style: TextStyle(
            color: Color(0xFFF5F0E8),
            fontWeight: FontWeight.bold,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Color(0xFFF5F0E8),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // ---------------- IMAGE ----------------

            Image.asset(
              image,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,

              errorBuilder:
                  (context, error, stackTrace) {
                return Container(
                  height: 250,
                  color: Colors.white,

                  child: const Center(
                    child: Icon(
                      Icons.local_offer_outlined,
                      size: 80,
                      color: Color(0xFF3F4A32),
                    ),
                  ),
                );
              },
            ),

            // ---------------- DETAILS ----------------

            Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3F4A32),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    discount,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3F4A32),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'About This Offer',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3F4A32),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ---------------- VALIDITY ----------------

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(14),

                      border: Border.all(
                        color: const Color(
                          0xFF3F4A32,
                        ),
                      ),
                    ),

                    child: const Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                          'Offer Validity',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                            color:
                                Color(0xFF3F4A32),
                          ),
                        ),

                        SizedBox(height: 10),

                        Text(
                          'Valid for a limited time.',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ---------------- BOOK NOW ----------------

                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton(
                      onPressed: () {
                       Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const RoomsScreen(),
    ),
  );
                      },

                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(
                          0xFF3F4A32,
                        ),

                        foregroundColor:
                            Colors.white,

                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 16,
                        ),

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            12,
                          ),
                        ),
                      ),

                      child: const Text(
                        'Book Now',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
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