import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'homepage.dart';

class BookingPage extends StatefulWidget {
  final String cityName;
  final DateTime departureDate;
  final DateTime returnDate;
  final String transport;
  final String accommodation;
  final List<String> extras;
  final double totalCost;

  const BookingPage({
    super.key,
    required this.cityName,
    required this.departureDate,
    required this.returnDate,
    required this.transport,
    required this.accommodation,
    required this.extras,
    required this.totalCost,
  });

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String name = "User";
  String email = "";
  String address = "No Address Provided";
  String phone = "Not Provided";

  int numPersons = 1;
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
    _calculateTotal();
  }

  Future<void> _fetchUserDetails() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userData =
          await _firestore.collection('users').doc(user.uid).get();
      if (userData.exists) {
        setState(() {
          name = userData['name'] ?? "User";
          email = user.email ?? "";
          address = userData['address'] ?? "No Address Provided";
          phone = userData['phone'] ?? "Not Provided";
        });
      }
    }
  }

  void _calculateTotal() {
    setState(() {
      totalPrice = widget.totalCost * numPersons;
    });
  }

  Future<void> _storeBookingInDatabase() async {
  User? user = _auth.currentUser;
  if (user == null) return;

  try {
    DocumentReference docRef = await _firestore.collection('bookings').add({
      'userId': user.uid,
      'userName': name,
      'userEmail': email,
      'destination': widget.cityName,
      'departureDate': widget.departureDate.toIso8601String(),
      'returnDate': widget.returnDate.toIso8601String(),
      'transport': widget.transport,
      'accommodation': widget.accommodation,
      'extras': widget.extras,
      'numPersons': numPersons,
      'totalCost': totalPrice,
      'timestamp': FieldValue.serverTimestamp(),
    });

    print("✅ Booking saved with ID: ${docRef.id}");
  } catch (e) {
    print("❌ Error saving booking: $e");
  }
}

  Future<void> _sendBookingEmail() async {
    final Email bookingEmail = Email(
      body: """
      Hello $name,

      Your booking is confirmed! Here are your details:

      Destination: ${widget.cityName}
      Departure Date: ${widget.departureDate.toLocal().toString().split(' ')[0]}
      Return Date: ${widget.returnDate.toLocal().toString().split(' ')[0]}
      Transport: ${widget.transport}
      Accommodation: ${widget.accommodation}
      Extras: ${widget.extras.join(', ')}
      Number of Persons: $numPersons
      Total Cost: \$${totalPrice.toStringAsFixed(2)}

      Thank you for choosing TripMate!
      """,
      subject: "Booking Confirmation - TripMate",
      recipients: [email],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(bookingEmail);
    } catch (error) {
      print("Failed to send email: $error");
    }
  }

  void _confirmBooking() async {
    await _storeBookingInDatabase();
    await _sendBookingEmail();

    Get.snackbar("Booking Confirmed",
        "Your trip to ${widget.cityName} is booked!",
        backgroundColor: Colors.blue, colorText: Colors.white);

    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => const HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Booking Summary",
            style: GoogleFonts.pacifico(fontSize: 24, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/booking.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.7), Colors.black.withOpacity(0.4)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    color: Colors.white.withOpacity(0.9),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Destination: ${widget.cityName}", style: _infoStyle()),
                          Text("Departure Date: ${widget.departureDate.toLocal().toString().split(' ')[0]}", style: _infoStyle()),
                          Text("Return Date: ${widget.returnDate.toLocal().toString().split(' ')[0]}", style: _infoStyle()),
                          Text("Transport: ${widget.transport}", style: _infoStyle()),
                          Text("Accommodation: ${widget.accommodation}", style: _infoStyle()),
                          Text("Extras: ${widget.extras.join(', ')}", style: _infoStyle()),

                          const SizedBox(height: 10),
                          Text("Number of Persons:", style: _infoStyle()),
                          DropdownButton<int>(
                            value: numPersons,
                            items: List.generate(10, (index) => index + 1)
                                .map((value) => DropdownMenuItem<int>(
                                      value: value,
                                      child: Text("$value Person${value > 1 ? 's' : ''}"),
                                    ))
                                .toList(),
                            onChanged: (newValue) {
                              setState(() {
                                numPersons = newValue!;
                                _calculateTotal();
                              });
                            },
                          ),

                          const Divider(),
                          Text("Total Cost: \$${totalPrice.toStringAsFixed(2)}", style: _costStyle()),

                          const Divider(),
                          Text("User: $name", style: _infoStyle()),
                          Text("Email: $email", style: _infoStyle()),
                          Text("Address: $address", style: _infoStyle()),
                          Text("Phone: $phone", style: _infoStyle()),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _confirmBooking,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    ),
                    child: const Text("Confirm Booking", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _infoStyle() {
    return GoogleFonts.raleway(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87);
  }

  TextStyle _costStyle() {
    return GoogleFonts.raleway(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent);
  }
}
