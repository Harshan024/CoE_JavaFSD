import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripmate/services/weather_service.dart';
import '../widgets/custom_bottom_nav.dart';
import 'package:tripmate/screens/plan_trip_page.dart';

class SydneyPage extends StatefulWidget {
  const SydneyPage({super.key});

  @override
  _SydneyPageState createState() => _SydneyPageState();
}

class _SydneyPageState extends State<SydneyPage> {
  final WeatherService _weatherService = WeatherService();
  String temperature = "Loading...";
  String weatherIcon = "";

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    final weather = await _weatherService.fetchWeather("Sydney");
    if (weather != null) {
      setState(() {
        temperature = "City: ${weather['location']['name']}\n"
                      "Temperature: ${weather['current']['temp_c']}°C\n"
                      "Condition: ${weather['current']['condition']['text']}\n"
                      "Humidity: ${weather['current']['humidity']}%\n"
                      "Wind: ${weather['current']['wind_kph']} kph";
        weatherIcon = "https:${weather['current']['condition']['icon']}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sydney',
              style: GoogleFonts.pacifico(color: Colors.white, fontSize: 26),
            ),
            const SizedBox(width: 55),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/sydney.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.3)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome to Sydney!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lobster(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Explore the stunning beaches, iconic landmarks, and vibrant culture of Sydney!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(fontSize: 18, color: Colors.white70),
                ),
                const SizedBox(height: 20),

                _glassContainer(
                  child: Column(
                    children: [
                      Text(
                        "Current Weather in Sydney",
                        style: GoogleFonts.raleway(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(height: 0),
                      if (weatherIcon.isNotEmpty)
                        Image.network(
                          weatherIcon,
                          width: 60,
                          height: 60,
                        ),
                      Text(
                        temperature,
                        style: GoogleFonts.raleway(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                _glassContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("🏛️ Top Attractions"),
                      _attractionRow(Icons.account_balance, "Sydney Opera House"),
                      _attractionRow(Icons.beach_access, "Bondi Beach"),
                      _attractionRow(Icons.landscape, "Harbour Bridge"),
                      _attractionRow(Icons.nature_people, "Blue Mountains National Park"),
                      _attractionRow(Icons.local_florist, "Royal Botanic Garden"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                _glassContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("📅 Best Time to Visit"),
                      _contentText("September to November and March to May for the best weather and fewer crowds."),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                _glassContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("🏨 Recommended Hotels"),
                      _hotelRow("Park Hyatt Sydney", "Luxury"),
                      _hotelRow("QT Sydney", "Mid-range"),
                      _hotelRow("Wake Up! Sydney Central", "Budget"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                _glassContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("🍽️ Must-Try Foods"),
                      _foodRow("🍤 Barramundi"),
                      _foodRow("🍖 Australian BBQ"),
                      _foodRow("🥧 Meat Pie"),
                      _foodRow("🍫 Tim Tam"),
                      _foodRow("🍹 Flat White Coffee"),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PlanTripPage(cityName: "Sydney")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent[700],
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Plan Your Trip",
                    style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(selectedIndex: 0),
    );
  }

  Widget _glassContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, spreadRadius: 2)],
      ),
      child: child,
    );
  }

  Widget _sectionTitle(String title) {
    return Text(title, style: GoogleFonts.raleway(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white));
  }

  Widget _attractionRow(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(children: [Icon(icon, color: Colors.yellowAccent), const SizedBox(width: 10), Text(title, style: GoogleFonts.raleway(fontSize: 18, color: Colors.white))]),
    );
  }

  Widget _hotelRow(String hotelName, String type) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Text("🏨 $hotelName - $type", style: GoogleFonts.raleway(fontSize: 16, color: Colors.white70)));
  }

  Widget _foodRow(String food) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Text(food, style: GoogleFonts.raleway(fontSize: 16, color: Colors.white70)));
  }

  Widget _contentText(String text) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 5), child: Text(text, style: GoogleFonts.raleway(fontSize: 16, color: Colors.white70)));
  }
}
