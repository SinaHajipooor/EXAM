import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  // ------------- feilds ---------------
  static const routeName = '/profile';

  const ProfileScreen({super.key});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // ------------- state ---------------
  // ignore: unused_field
  String _name = '';
  // ignore: unused_field
  String _phoneNumber = '';
  // ------------- UI ---------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24.0),
            Stack(
              children: [
                const CircleAvatar(radius: 64.0, backgroundImage: AssetImage('assets/images/userProfile.png')),
                Positioned(
                  bottom: -10,
                  right: -10,
                  child: GestureDetector(
                    onTap: () {
                      // Add code to choose photo from gallery
                    },
                    child: const CircleAvatar(radius: 20.0, backgroundColor: Colors.blue, child: Icon(Icons.camera_alt, color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name', hintText: 'Enter Your Name'),
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Phone Number'),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                setState(() {
                  _phoneNumber = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
