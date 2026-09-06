import 'package:flutter/material.dart';

class OurStoryScreen extends StatelessWidget {
  const OurStoryScreen({super.key});

  static const Color olive = Color(0xFF68744A);
  static const Color lightOlive = Color(0xFFE8EBDD);
  static const Color background = Color(0xFFF9F9F4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      appBar: AppBar(
        backgroundColor: olive,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Our Story',
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // --------------------------------------------------
            // HOTEL HEADER
            // --------------------------------------------------
            Container(
              color: olive,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Image.asset(
                      'assets/logo/aurelia_logo.jpeg',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.hotel,
                          size: 55,
                          color: olive,
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'AURELIA GRAND HOTEL',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Your Stay, Elevated. ✨',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),

            // --------------------------------------------------
            // INTRODUCTION
            // --------------------------------------------------
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 10),
              child: Column(
                children: [
                  const Icon(
                    Icons.auto_awesome,
                    color: olive,
                    size: 32,
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Welcome to Aurelia Grand',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: olive,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Aurelia Grand Hotel is more than a place to stay; '
                    'it is a thoughtfully designed hospitality experience '
                    'where comfort, elegance, and genuine care come together. '
                    'Every detail of our hotel has been created with the idea '
                    'that a memorable stay is built not only through beautiful '
                    'surroundings, but also through meaningful experiences and '
                    'warm hospitality.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 15.5,
                      height: 1.7,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // --------------------------------------------------
            // OUR STORY
            // --------------------------------------------------
            _infoCard(
              icon: Icons.history_edu,
              title: 'Our Story',
              text:
                  'Aurelia Grand was created with a simple yet meaningful '
                  'idea: to bring together the comfort of a home, the elegance '
                  'of a luxury hotel, and the warmth of exceptional hospitality. '
                  'From the very beginning, our goal has been to create a space '
                  'where every guest feels welcomed, valued, and cared for. '
                  '\n\n'
                  'Our name, Aurelia, reflects a sense of warmth, beauty, and '
                  'brightness. These qualities inspire everything we do. From '
                  'our carefully designed spaces and comfortable rooms to our '
                  'dining experiences, wellness facilities, celebrations, and '
                  'professional event services, every part of Aurelia Grand is '
                  'designed to make your time with us special.'
                  '\n\n'
                  'Whether you are visiting for a relaxing stay, celebrating '
                  'an important occasion, attending a professional conference, '
                  'enjoying a meal, or simply taking a break from everyday life, '
                  'Aurelia Grand aims to make every moment feel effortless and '
                  'memorable.',
            ),

            // --------------------------------------------------
            // MISSION
            // --------------------------------------------------
            _infoCard(
              icon: Icons.flag,
              title: 'Our Mission',
              text:
                  'Our mission is to provide every guest with an exceptional '
                  'hospitality experience built around comfort, quality, '
                  'personal attention, and trust. We believe that great '
                  'hospitality goes beyond providing a room or a service. '
                  'It is about understanding what guests need and making '
                  'their experience as comfortable and enjoyable as possible.'
                  '\n\n'
                  'At Aurelia Grand, we are committed to maintaining high '
                  'standards across every aspect of the guest experience. '
                  'Our team strives to provide welcoming service, comfortable '
                  'spaces, quality dining, relaxing wellness experiences, and '
                  'professional facilities for meetings and celebrations.'
                  '\n\n'
                  'We also believe that every guest deserves to feel respected '
                  'and appreciated. Our mission is therefore to create an '
                  'environment where people can relax, connect, celebrate, '
                  'work, and create lasting memories.',
            ),

            // --------------------------------------------------
            // VISION
            // --------------------------------------------------
            _infoCard(
              icon: Icons.visibility,
              title: 'Our Vision',
              text:
                  'Our vision is to establish Aurelia Grand as a trusted and '
                  'memorable hospitality destination where modern comfort meets '
                  'timeless elegance. We aim to continuously improve the way '
                  'guests experience hospitality by combining thoughtful design, '
                  'quality services, and personalized attention.'
                  '\n\n'
                  'We envision a hotel where every visit feels different yet '
                  'equally special. A place where business travelers can work '
                  'comfortably, families can spend quality time together, '
                  'couples can celebrate meaningful moments, and guests can '
                  'simply relax and enjoy themselves.'
                  '\n\n'
                  'As Aurelia Grand continues to grow, our vision remains '
                  'focused on creating experiences that guests remember long '
                  'after they leave our doors.',
            ),

            // --------------------------------------------------
            // WHY AURELIA GRAND
            // --------------------------------------------------
            _infoCard(
              icon: Icons.favorite,
              title: 'Why Aurelia Grand?',
              text:
                  'Choosing Aurelia Grand means choosing an experience that '
                  'places the guest at the heart of everything. Our hotel is '
                  'designed to bring together the essential elements of a '
                  'complete stay under one roof.'
                  '\n\n'
                  'From comfortable accommodation and carefully planned dining '
                  'experiences to wellness facilities, celebrations, room '
                  'decorations, and professional conference arrangements, '
                  'Aurelia Grand offers a variety of experiences designed for '
                  'different needs and occasions.'
                  '\n\n'
                  'Our attention to detail is one of the qualities that makes '
                  'the Aurelia experience unique. We believe that small details '
                  'can make a big difference — from a warm welcome when you '
                  'arrive to a comfortable environment throughout your stay.'
                  '\n\n'
                  'Most importantly, we want our guests to leave with more than '
                  'just a pleasant memory of a hotel. We want them to remember '
                  'the feeling of being welcomed, appreciated, and genuinely '
                  'looked after.',
            ),

            // --------------------------------------------------
            // OUR PROMISE
            // --------------------------------------------------
            _infoCard(
              icon: Icons.handshake,
              title: 'Our Promise',
              text:
                  'At Aurelia Grand, every guest is an important part of our '
                  'story. We promise to continually strive for excellence in '
                  'hospitality while maintaining an atmosphere of warmth, '
                  'comfort, and elegance.'
                  '\n\n'
                  'We are committed to listening to our guests, improving our '
                  'services, and creating experiences that meet the highest '
                  'standards of care and convenience. Every stay gives us an '
                  'opportunity to do better and to make your next visit even '
                  'more memorable.',
            ),

            const SizedBox(height: 25),

            // --------------------------------------------------
            // FINAL MESSAGE
            // --------------------------------------------------
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: lightOlive,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.hotel_class,
                    color: olive,
                    size: 38,
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Aurelia Grand Hotel',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: olive,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Where every stay becomes a story worth remembering.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 15,
                      height: 1.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------
  // REUSABLE INFORMATION CARD
  // --------------------------------------------------
  static Widget _infoCard({
    required IconData icon,
    required String title,
    required String text,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: lightOlive,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: lightOlive,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: olive,
                  size: 25,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: olive,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Text(
            text,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 15,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}
              
                   
                   
                  
                  