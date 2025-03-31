import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/custom_bottom_nav.dart';
import '../auth/login_page.dart';
import '../auth/signup_page.dart';
import 'edit_profile_page.dart';
import 'my_bookings_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user;
  String? profileImageUrl;
  String name = "User";
  String email = "";
  String address = "No Address Provided";
  String dob = "Not Set";
  String phone = "Not Provided";
  String gender = "Not Specified";

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    if (user != null) {
      DocumentSnapshot userData =
          await _firestore.collection('users').doc(user!.uid).get();
      if (userData.exists) {
        setState(() {
          name = userData['name'] ?? user!.displayName ?? "User";
          email = user!.email ?? "No email available";
          address = userData['address'] ?? "No Address Provided";
          dob = userData['dob'] ?? "Not Set";
          phone = userData['phone'] ?? "Not Provided";
          gender = userData['gender'] ?? "Not Specified";
          profileImageUrl = userData['profilePicture'];
        });
      }
    }
  }

  void logout() async {
    await _auth.signOut();
    setState(() {
      user = null;
    });
    Get.offAll(() => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.pacifico(fontSize: 24, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: user != null
            ? [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: () async {
                    await Get.to(() => const EditProfilePage());
                    _fetchUserProfile();
                  },
                )
              ]
            : null,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/profile.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.3),
                  ],
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  if (user != null) ...[
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: profileImageUrl != null && profileImageUrl!.isNotEmpty
                          ? NetworkImage(profileImageUrl!)
                          : const AssetImage('assets/images/default_profile.png')
                              as ImageProvider,
                    ),
                    const SizedBox(height: 20),
                    
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      color: Colors.white.withOpacity(0.9),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              name,
                              style: GoogleFonts.raleway(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              email,
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            const Divider(),
                            _profileInfoRow(Icons.location_on, "Address", address),
                            _profileInfoRow(Icons.calendar_today, "DOB", dob),
                            _profileInfoRow(Icons.phone, "Phone", phone),
                            _profileInfoRow(Icons.person, "Gender", gender),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MyBookingsPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        "View My Bookings",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Logout', style: TextStyle(color: Colors.white)),
                    ),
                  ] else ...[
                    Text(
                      'Welcome to TripMate!',
                      style: GoogleFonts.lobster(fontSize: 26, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Login or Sign Up to access your profile.',
                      style: GoogleFonts.raleway(fontSize: 16, color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () => Get.to(() => const LoginPage()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      ),
                      child: const Text('Login', style: TextStyle(color: Colors.white)),
                    ),

                    const SizedBox(height: 10),

                    OutlinedButton(
                      onPressed: () => Get.to(() => const SignupPage()),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      ),
                      child: const Text('Sign Up', style: TextStyle(color: Colors.white)),
                    ),
                  ],

                  const SizedBox(height: 30),

                  Text(
                    "Powered by TripMate \n © 2025 Developed by Harshan",
                    style: GoogleFonts.raleway(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(selectedIndex: 0),
    );
  }

  Widget _profileInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          const SizedBox(width: 10),
          Text("$label: ", style: GoogleFonts.raleway(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
          Expanded(
            child: Text(value, style: GoogleFonts.raleway(fontSize: 16, color: Colors.black54), overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
