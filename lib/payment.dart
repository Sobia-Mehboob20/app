
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentScreen extends StatefulWidget {
  final String hotelName;
  final String roomType;
  final String checkIn;
  final String checkOut;
  final int nights;
  final double totalAmount;

  const PaymentScreen({
    super.key,
    required this.hotelName,
    required this.roomType,
    required this.checkIn,
    required this.checkOut,
    required this.nights,
    required this.totalAmount,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPayment = "Card";

  final TextEditingController cardName = TextEditingController();
  final TextEditingController cardNumber = TextEditingController();
  final TextEditingController expiry = TextEditingController();
  final TextEditingController cvv = TextEditingController();

  bool isLoading = false;

  Future<void> makePayment() async {
    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseFirestore.instance.collection('bookings').add({
        'hotelName': widget.hotelName,
        'roomType': widget.roomType,
        'checkIn': widget.checkIn,
        'checkOut': widget.checkOut,
        'nights': widget.nights,
        'totalAmount': widget.totalAmount,
        'paymentMethod': selectedPayment,
        'paymentStatus': 'Paid',
        'bookingStatus': 'Confirmed',
        'createdAt': Timestamp.now(),
      });

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Booking confirmed successfully!"),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong: $e"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F0E8),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Payment",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ---------------- BOOKING SUMMARY ----------------

            const Text(
              "Booking Summary",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),

              child: Column(
                children: [

                  _summaryRow(
                    "Hotel",
                    widget.hotelName,
                  ),

                  const SizedBox(height: 12),

                  _summaryRow(
                    "Room",
                    widget.roomType,
                  ),

                  const SizedBox(height: 12),

                  _summaryRow(
                    "Check-in",
                    widget.checkIn,
                  ),

                  const SizedBox(height: 12),

                  _summaryRow(
                    "Check-out",
                    widget.checkOut,
                  ),

                  const SizedBox(height: 12),

                  _summaryRow(
                    "Nights",
                    widget.nights.toString(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ---------------- PAYMENT METHOD ----------------

            const Text(
              "Payment Method",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _paymentOption(
              title: "Credit / Debit Card",
              value: "Card",
              icon: Icons.credit_card,
            ),

            _paymentOption(
              title: "EasyPaisa",
              value: "EasyPaisa",
              icon: Icons.phone_android,
            ),

            _paymentOption(
              title: "JazzCash",
              value: "JazzCash",
              icon: Icons.account_balance_wallet,
            ),

            const SizedBox(height: 20),

            // ---------------- CARD DETAILS ----------------

            if (selectedPayment == "Card") ...[

              const Text(
                "Card Details",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              _textField(
                controller: cardName,
                hint: "Card Holder Name",
              ),

              const SizedBox(height: 12),

              _textField(
                controller: cardNumber,
                hint: "Card Number",
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 12),

              Row(
                children: [

                  Expanded(
                    child: _textField(
                      controller: expiry,
                      hint: "MM/YY",
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _textField(
                      controller: cvv,
                      hint: "CVV",
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 25),

            // ---------------- TOTAL ----------------

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  const Text(
                    "Total Amount",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    "Rs. ${widget.totalAmount.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ---------------- PAY BUTTON ----------------

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed: isLoading ? null : makePayment,

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),

                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Pay Now",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  // ---------------- SUMMARY ROW ----------------

  Widget _summaryRow(
    String title,
    String value,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [

        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),

        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,

            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------- PAYMENT OPTION ----------------

  Widget _paymentOption({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),

      child: RadioListTile<String>(
        value: value,
        groupValue: selectedPayment,

        onChanged: (value) {
          setState(() {
            selectedPayment = value!;
          });
        },

        title: Text(title),
        secondary: Icon(icon),
      ),
    );
  }

  // ---------------- TEXT FIELD ----------------

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,

      decoration: InputDecoration(
        hintText: hint,

        filled: true,
        fillColor: Colors.white,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // ---------------- DISPOSE ----------------

  @override
  void dispose() {
    cardName.dispose();
    cardNumber.dispose();
    expiry.dispose();
    cvv.dispose();

    super.dispose();
  }
}

