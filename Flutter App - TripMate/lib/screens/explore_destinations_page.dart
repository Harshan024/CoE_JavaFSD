import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripmate/services/weather_service.dart';
import '../destinations/paris.dart';
import '../destinations/agra.dart';
import '../destinations/rio.dart';
import '../destinations/london.dart';
import '../destinations/japan.dart';
import '../destinations/moscow.dart';
import '../destinations/seoul.dart';
import '../destinations/sydney.dart';
import '../destinations/bangkok.dart';
import '../destinations/newyork.dart';
import '../widgets/custom_bottom_nav.dart';

class ExploreDestinationsPage extends StatefulWidget {
  const ExploreDestinationsPage({super.key});

  @override
  _ExploreDestinationsPageState createState() =>
      _ExploreDestinationsPageState();
}

class _ExploreDestinationsPageState extends State<ExploreDestinationsPage> {
  final WeatherService _weatherService = WeatherService();
  Map<String, String> weatherData = {};
  String? selectedDestination = "Show All";

  final List<Map<String, dynamic>> destinations = [
    {'name': 'Paris', 'image': 'assets/images/paris.jpg', 'page': const ParisPage(), 'city': 'Paris'},
    {'name': 'Agra', 'image': 'assets/images/taj.jpg', 'page': const AgraPage(), 'city': 'Agra'},
    {'name': 'Rio de Janeiro', 'image': 'assets/images/rio.jpg', 'page': const RioPage(), 'city': 'Rio de Janeiro'},
    {'name': 'London', 'image': 'assets/images/london.jpg', 'page': const LondonPage(), 'city': 'London'},
    {'name': 'Japan', 'image': 'assets/images/japan.jpg', 'page': const JapanPage(), 'city': 'Tokyo'},
    {'name': 'Moscow', 'image': 'assets/images/moscow.jpg', 'page': const MoscowPage(), 'city': 'Moscow'},
    {'name': 'Bangkok', 'image': 'assets/images/bangkok.jpg', 'page': const BangkokPage(), 'city': 'Bangkok'},
    {'name': 'New York', 'image': 'assets/images/ny.jpg', 'page': const NewYorkPage(), 'city': 'New York'},
    {'name': 'Seoul', 'image': 'assets/images/seoul.jpg', 'page': const SeoulPage(), 'city': 'Seoul'},
    {'name': 'Sydney', 'image': 'assets/images/sydney.jpg', 'page': const SydneyPage(), 'city': 'Sydney'},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredDestinations =
        selectedDestination == "Show All"
            ? destinations
            : destinations
                .where((destination) => destination['name'] == selectedDestination)
                .toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Explore',
          style: GoogleFonts.pacifico(fontSize: 24, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              )
            : null,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/explore.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.2)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text(
                  'Discover Breathtaking Places',
                  style: GoogleFonts.lobster(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  'Find the best places to visit and create unforgettable memories!',
                  style: GoogleFonts.raleway(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedDestination,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
                      items: [
                        const DropdownMenuItem(
                          value: "Show All",
                          child: Text("Show All"),
                        ),
                        ...destinations.map((destination) {
                          return DropdownMenuItem<String>(
                            value: destination['name'],
                            child: Text(destination['name']),
                          );
                        }).toList(),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedDestination = value;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: filteredDestinations.isNotEmpty
                      ? GridView.builder(
                          itemCount: filteredDestinations.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            final destination = filteredDestinations[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => destination['page']),
                                );
                              },
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                                        child: Image.asset(destination['image']!, fit: BoxFit.cover, width: double.infinity),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        destination['name']!,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            'No destinations found',
                            style: GoogleFonts.roboto(fontSize: 18, color: Colors.white),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(selectedIndex: 1),
    );
  }
}
