import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String username;
  final String email;
  final String phoneNumber;

  ProfilePage({
    required this.username,
    required this.email,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            _buildProfileItem(
              title: 'Nama:',
              value: username,
              icon: Icons.person,
            ),
            SizedBox(height: 16),
            _buildProfileItem(title: 'Email:', value: email, icon: Icons.email),
            SizedBox(height: 16),
            _buildProfileItem(
              title: 'Nomor Telepon:',
              value: phoneNumber,
              icon: Icons.phone,
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: () {
                  // Tambahkan logika logout di sini
                  Navigator.pop(context); // Kembali ke halaman sebelumnya
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildProfileItem({
  required String title,
  required String value,
  required IconData icon,
}) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 6,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, size: 28, color: Colors.blueAccent),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 4),
              Text(value, style: TextStyle(fontSize: 16, color: Colors.black)),
            ],
          ),
        ),
      ],
    ),
  );
}
