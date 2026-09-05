import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'offer_details_screen.dart';

class SpecialOffersScreen extends StatelessWidget {
  const SpecialOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),

      appBar: AppBar(
        backgroundColor: const Color(0xFF3F4A32),
        elevation: 0,
        centerTitle: true,

        title: const Text(
          'Special Offers',
          style: TextStyle(
            color: Color(0xFFF5F0E8),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Color(0xFFF5F0E8),
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('specialOffers')
            .snapshots(),

        builder: (context, snapshot) {

          // LOADING
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF3F4A32),
              ),
            );
          }

          // ERROR
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          }

          // EMPTY
          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No special offers found',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF3F4A32),
                ),
              ),
            );
          }

          final offers = snapshot.data!.docs;

          return ListView(
            padding: const EdgeInsets.all(16),

            children: [

              const Text(
                'Exclusive Offers',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F4A32),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Enjoy exclusive deals and special packages '
                'at Aurelia Grand.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 20),

              // FIREBASE OFFERS
              ...offers.map((doc) {

                final data =
                    doc.data() as Map<String, dynamic>;

                final title =
                    data['title'] ?? 'Special Offer';

                final discount =
                    data['discount'] ?? '';

                final description =
                    data['description'] ?? '';

                final image =
                    data['image'] ?? '';

                return Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20),

                  child: _buildOfferCard(
                    context,
                    image: image,
                    title: title,
                    discount: discount,
                    description: description,
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }

  // ---------------- OFFER CARD ----------------

  Widget _buildOfferCard(
    BuildContext context, {
    required String image,
    required String title,
    required String discount,
    required String description,
  }) {
    return Card(
      color: Colors.white,
      elevation: 4,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      clipBehavior: Clip.antiAlias,

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          // IMAGE
          Image.asset(
            image,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,

            errorBuilder:
                (context, error, stackTrace) {
              return Container(
                height: 200,
                width: double.infinity,
                color: Colors.white,

                child: const Icon(
                  Icons.local_offer_outlined,
                  size: 70,
                  color: Color(0xFF3F4A32),
                ),
              );
            },
          ),

          // DETAILS
          Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3F4A32),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  discount,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3F4A32),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 15),

                // VIEW OFFER BUTTON
                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(
                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OfferDetailsScreen(
                            title: title,
                            discount: discount,
                            description: description,
                            image: image,
                          ),
                        ),
                      );
                    },

                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF3F4A32),

                      foregroundColor:
                          Colors.white,

                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 13,
                      ),

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                    ),

                    child: const Text(
                      'View Offer',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}