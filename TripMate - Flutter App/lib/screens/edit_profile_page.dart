import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_bottom_nav.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  User? user;
  File? _imageFile;
  String? profileImageUrl;

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String gender = 'Male';

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (user != null) {
      DocumentSnapshot userData =
          await _firestore.collection('users').doc(user!.uid).get();
      if (userData.exists) {
        setState(() {
          nameController.text = userData['name'] ?? user!.displayName ?? '';
          addressController.text = userData['address'] ?? '';
          dobController.text = userData['dob'] ?? '';
          phoneController.text = userData['phone'] ?? '';
          gender = userData['gender'] ?? 'Male';
          profileImageUrl = userData['profilePicture'];
        });
      }
    }
  }

  Future<void> _updateProfile() async {
    if (user != null) {
      await user!.updateDisplayName(nameController.text.trim());

      await _firestore.collection('users').doc(user!.uid).set({
        'name': nameController.text.trim(),
        'address': addressController.text.trim(),
        'dob': dobController.text.trim(),
        'phone': phoneController.text.trim(),
        'gender': gender,
        'profilePicture': profileImageUrl ?? '',
      }, SetOptions(merge: true));

      Get.back();
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      _uploadProfilePicture();
    }
  }

  Future<void> _uploadProfilePicture() async {
    if (_imageFile == null || user == null) return;

    String filePath = 'assets/images/${user!.uid}.jpg';
    Reference storageRef = FirebaseStorage.instance.ref().child(filePath);

    UploadTask uploadTask = storageRef.putFile(_imageFile!);
    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();
    await _firestore.collection('users').doc(user!.uid).update({
      'profilePicture': downloadUrl,
    });

    setState(() {
      profileImageUrl = downloadUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: GoogleFonts.pacifico(fontSize: 22, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/login.jpg',
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.3),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),

          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 80),

                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 3,
                        )
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : (profileImageUrl != null && profileImageUrl!.isNotEmpty
                              ? NetworkImage(profileImageUrl!)
                              : const AssetImage('assets/images/default_image.jpg'))
                          as ImageProvider,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Tap to change profile picture",
                  style: GoogleFonts.roboto(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 20),

                _buildTextField("Name", nameController),
                _buildTextField("Address", addressController),
                _buildTextField("Date of Birth", dobController),
                _buildTextField("Phone Number", phoneController,
                    keyboardType: TextInputType.phone),

                DropdownButtonFormField(
                  value: gender,
                  items: ['Male', 'Female', 'Other'].map((String value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  },
                  decoration: _buildInputDecoration("Gender"),
                  dropdownColor: Colors.black87,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: _updateProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent[700],
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Save Changes",
                    style: GoogleFonts.roboto(
                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: const CustomBottomNav(selectedIndex: 2),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        decoration: _buildInputDecoration(label),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.roboto(color: Colors.white70),
      filled: true,
      fillColor: Colors.white.withOpacity(0.2),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white70),
      ),
    );
  }
}
