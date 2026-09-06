import 'package:cloud_firestore/cloud_firestore.dart';

class ConferenceFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveBooking({
    required String conferenceName,
    required String organizerName,
    required String phone,
    required DateTime startDate,
    required DateTime endDate,
    required int price,
  }) async {
    await _firestore.collection('conference_bookings').add({
      'conferenceName': conferenceName,
      'organizerName': organizerName,
      'phone': phone,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'price': price,
      'paymentStatus': 'Pending',
      'bookingStatus': 'Confirmed',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}