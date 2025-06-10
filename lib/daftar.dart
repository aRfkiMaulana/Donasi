import 'package:flutter/material.dart';
import 'login.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/logo.png', // Ganti dengan logo kamu
                width: 100,
              ),
              SizedBox(height: 12),
              Text(
                'Penuh\nPeduli',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),

              SizedBox(height: 40),
              Text(
                'Register',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              SizedBox(height: 20),

              // Input Fields
              _buildTextField(Icons.person, 'Nama'),
              SizedBox(height: 12),
              _buildTextField(Icons.email, 'Email'),
              SizedBox(height: 12),
              _buildTextField(Icons.phone, 'Nomor Telepon'),
              SizedBox(height: 12),
              _buildTextField(Icons.lock, 'Password', obscureText: true),
              SizedBox(height: 12),
              _buildTextField(
                Icons.lock,
                'Konfirmasi Password',
                obscureText: true,
              ),

              SizedBox(height: 30),

              // Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                  ),
                  onPressed: () {
                    // Tambahkan aksi daftar di sini
                  },
                  child: Text(
                    'Daftar',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Login link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sudah memiliki akun?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Masuk.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8),
              Text.rich(
                TextSpan(
                  text: 'Repost by ',
                  children: [
                    TextSpan(
                      text: 'InformaticsZone',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    IconData icon,
    String hint, {
    bool obscureText = false,
  }) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
