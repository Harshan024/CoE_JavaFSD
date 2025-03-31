import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_bottom_nav.dart';
import 'package:tripmate/screens/booking_page.dart';
import 'package:tripmate/auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart'; 
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripmate/screens/booking_page.dart';


Future<bool> checkUserLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}


class PlanTripPage extends StatefulWidget {
  final String cityName;

  const PlanTripPage({super.key, required this.cityName});

  @override
  _PlanTripPageState createState() => _PlanTripPageState();
}

class _PlanTripPageState extends State<PlanTripPage> {
  DateTime? _departureDate;
  DateTime? _returnDate;
  String? _selectedTransport;
  String? _selectedAccommodation;
  List<String> _selectedExtras = [];
  double _totalCost = 0.0;

  final Map<String, Map<String, double>> pricing = {
    "Paris": {
      "Flight": 800,
      "Train": 500,
      "Bus": 300,
      "Luxury Hotel": 400,
      "Mid-range Hotel": 250,
      "Budget Stay": 150,
    },
    "Taj Mahal": {
    "Flight": 500,
    "Train": 300,
    "Bus": 150,
    "Luxury Hotel": 250,
    "Mid-range Hotel": 180,
    "Budget Stay": 100,
  },
  "Rio de Janeiro": {
    "Flight": 1000,
    "Train": 650,
    "Bus": 400,
    "Luxury Hotel": 450,
    "Mid-range Hotel": 280,
    "Budget Stay": 160,
  },
    "London": {
      "Flight": 750,
      "Train": 450,
      "Bus": 280,
      "Luxury Hotel": 380,
      "Mid-range Hotel": 230,
      "Budget Stay": 140,
    },
    "Japan": {
      "Flight": 900,
      "Train": 600,
      "Bus": 350,
      "Luxury Hotel": 420,
      "Mid-range Hotel": 260,
      "Budget Stay": 170,
    },
    "Moscow": {
      "Flight": 700,
      "Train": 480,
      "Bus": 290,
      "Luxury Hotel": 360,
      "Mid-range Hotel": 220,
      "Budget Stay": 130,
    },
     "New York": {
      "Flight": 1200, 
      "Train": 700, 
      "Bus": 450,
      "Luxury Hotel": 600, 
      "Mid-range Hotel": 350, 
      "Budget Stay": 200,
    },
    "Seoul": {
      "Flight": 950, 
      "Train": 600, 
      "Bus": 350,
      "Luxury Hotel": 500, 
      "Mid-range Hotel": 300, 
      "Budget Stay": 180,
    },
    "Sydney": {
      "Flight": 1100, 
      "Train": 650, 
      "Bus": 400,
      "Luxury Hotel": 550, 
      "Mid-range Hotel": 320, 
      "Budget Stay": 190,
    },
    "Bangkok": {
      "Flight": 700, 
      "Train": 450, 
      "Bus": 280,
      "Luxury Hotel": 380, 
      "Mid-range Hotel": 230, 
      "Budget Stay": 140,
    },
  };

  final Map<String, double> extraCosts = {
    "City Tour": 100,
    "Local Cuisine Experience": 80,
    "Museum Visits": 60,
    "Adventure Sports": 150,
  };

  Future<void> _selectDate(BuildContext context, bool isDeparture) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    if (picked != null) {
      setState(() {
        if (isDeparture) {
          _departureDate = picked;
        } else {
          _returnDate = picked;
        }
      });
    }
  }

  void _calculateTotalCost() {
    double cost = 0.0;

    if (_selectedTransport != null) {
      cost += pricing[widget.cityName]?[_selectedTransport!] ?? 0;
    }

    if (_selectedAccommodation != null) {
      cost += pricing[widget.cityName]?[_selectedAccommodation!] ?? 0;
    }

    for (var extra in _selectedExtras) {
      cost += extraCosts[extra] ?? 0;
    }

    setState(() {
      _totalCost = cost;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> transportOptions = ["Flight", "Train", "Bus"];
    List<String> accommodationOptions = ["Luxury Hotel", "Mid-range Hotel", "Budget Stay"];
    List<String> extrasOptions = extraCosts.keys.toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Plan Your Trip",
          style: GoogleFonts.pacifico(fontSize: 26, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/air.jpg",
              fit: BoxFit.cover,
            ),
          ),

          Container(
            color: Colors.black.withOpacity(0.5),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),

                    Text(
                      "Destination: ${widget.cityName}",
                      style: GoogleFonts.lobster(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    
                    

                    _datePickerTile("Departure Date", _departureDate, () => _selectDate(context, true)),
                    _datePickerTile("Return Date", _returnDate, () => _selectDate(context, false)),

                    const SizedBox(height: 20),

                    _dropdownSelector("✈️ Transportation", transportOptions, _selectedTransport, (newValue) {
                      setState(() {
                        _selectedTransport = newValue;
                        _calculateTotalCost();
                      });
                    }),

                    const SizedBox(height: 20),

                    _dropdownSelector("🏨 Accommodation", accommodationOptions, _selectedAccommodation, (newValue) {
                      setState(() {
                        _selectedAccommodation = newValue;
                        _calculateTotalCost();
                      });
                    }),

                    const SizedBox(height: 20),

                    _extrasSelector("🎟️ Activities & Extras", extrasOptions),

                    const SizedBox(height: 20),

                    _totalCostDisplay(),

                    const SizedBox(height: 30),

                   Center(
  child: ElevatedButton(
    onPressed: () async {
      if (_departureDate != null && _returnDate != null && _selectedTransport != null && _selectedAccommodation != null) {
        if (FirebaseAuth.instance.currentUser != null) {
          Get.to(() => BookingPage(
            cityName: widget.cityName,
            departureDate: _departureDate!,
            returnDate: _returnDate!,
            transport: _selectedTransport!,
            accommodation: _selectedAccommodation!,
            extras: _selectedExtras,
            totalCost: _totalCost,
          ));
        } else {
          Get.to(() => LoginPage(
            redirectPage: BookingPage(
              cityName: widget.cityName,
              departureDate: _departureDate!,
              returnDate: _returnDate!,
              transport: _selectedTransport!,
              accommodation: _selectedAccommodation!,
              extras: _selectedExtras,
              totalCost: _totalCost,
            ),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill all fields to proceed with booking.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.teal,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
    ),
                        child: Text(
                          "Book Trip",
                          style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
       bottomNavigationBar: const CustomBottomNav(selectedIndex: 0),
    );
  }

  Widget _datePickerTile(String title, DateTime? date, VoidCallback onTap) {
    return ListTile(
      title: Text(title, style: GoogleFonts.raleway(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
      subtitle: Text(
        date != null ? "${date.toLocal()}".split(' ')[0] : "Select Date",
        style: const TextStyle(color: Colors.white70),
      ),
      trailing: const Icon(Icons.calendar_today, color: Colors.white),
      onTap: onTap,
    );
  }

  Widget _dropdownSelector(String title, List<String> items, String? selectedValue, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.raleway(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        DropdownButton<String>(
          dropdownColor: Colors.black87,
          value: selectedValue,
          isExpanded: true,
          hint: Text("Select $title", style: const TextStyle(color: Colors.white70)),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text("$item (\$${pricing[widget.cityName]?[item] ?? 0})", style: const TextStyle(color: Colors.white)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

Widget _extrasSelector(String title, List<String> items) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: GoogleFonts.raleway(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
      Column(
        children: items.map((item) {
          return CheckboxListTile(
            activeColor: Colors.tealAccent,
            title: Text("$item (\$${extraCosts[item]})", style: const TextStyle(color: Colors.white)),
            value: _selectedExtras.contains(item),
            onChanged: (bool? selected) {
              setState(() {
                if (selected == true) {
                  _selectedExtras.add(item);
                } else {
                  _selectedExtras.remove(item);
                }
                _calculateTotalCost();
              });
            },
          );
        }).toList(),
      ),
    ],
  );
}


  Widget _totalCostDisplay() {
    return Text(
      "Total Cost: \$$_totalCost",
      style: GoogleFonts.raleway(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.yellowAccent),
    );
  }
}