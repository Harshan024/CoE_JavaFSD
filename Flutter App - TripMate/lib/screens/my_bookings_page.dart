import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({super.key});

  @override
  _MyBookingsPageState createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _bookings = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBookings();
  }

  Future<void> _fetchBookings() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    print("🔄 Fetching bookings for: ${user.email}");

    try {
      QuerySnapshot snapshot = await _firestore
          .collection('bookings')
          .where('userId', isEqualTo: user.uid)
          .orderBy('timestamp', descending: true)
          .limit(10)
          .get();

      List<Map<String, dynamic>> bookings = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;

        return {
          'id': doc.id,
          'cityName': data['destination'] ?? 'Unknown Destination',
          'departureDate': data['departureDate'] ?? 'N/A',
          'returnDate': data['returnDate'] ?? 'N/A',
          'numPersons': data['numPersons'] ?? 1,
          'totalCost': data['totalCost'] ?? 0,
        };
      }).toList();

      setState(() {
        _bookings = bookings;
        _isLoading = false;
      });

      if (_bookings.isNotEmpty) {
        for (var booking in _bookings) {
          print("📝 Booking: $booking");
        }
      } else {
        print("❌ No bookings found.");
      }
    } catch (e) {
      print("❌ Error fetching bookings: $e");
    }
  }

  Future<void> _deleteBooking(String bookingId) async {
    try {
      await _firestore.collection('bookings').doc(bookingId).delete();
      _fetchBookings(); 
      Get.snackbar("Deleted", "Booking removed!",
          backgroundColor: Colors.red, colorText: Colors.white);
    } catch (e) {
      print("❌ Error deleting booking: $e");
      Get.snackbar("Error", "Failed to delete booking",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "My Bookings",
          style: GoogleFonts.pacifico(fontSize: 24, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/view.jpg",
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
      
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: kToolbarHeight + 10),
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _bookings.isEmpty
                    ? const Center(
                        child: Text(
                          "No bookings found!",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(top: 25, left: 10, right: 10), 
                        itemCount: _bookings.length,
                        itemBuilder: (context, index) {
                          var booking = _bookings[index];
                          return Card(
                            color: Colors.white.withOpacity(0.2),
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(15),
                              title: Text(
                                booking['cityName'],
                                style: GoogleFonts.raleway(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "📅 Departure: ${booking['departureDate']?.split('T')[0] ?? 'N/A'}",
                                      style: GoogleFonts.raleway(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    Text(
                                      "📅 Return: ${booking['returnDate']?.split('T')[0] ?? 'N/A'}",
                                      style: GoogleFonts.raleway(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    Text(
                                      "👥 No. of Persons: ${booking['numPersons'] ?? 1}",
                                      style: GoogleFonts.raleway(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    Text(
                                      "💰 Total Cost: \$${booking['totalCost'] ?? 0}",
                                      style: GoogleFonts.raleway(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.greenAccent),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteBooking(booking['id']),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
