import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/logo.png', // Ganti dengan path logo kamu
                  height: 100,
                ),
                SizedBox(height: 8),

                // Judul App
                Text(
                  "Penuh Peduli",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo[900],
                  ),
                ),
                SizedBox(height: 32),

                // Heading "Log in"
                Text(
                  "Log in.",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo[900],
                  ),
                ),
                SizedBox(height: 24),

                // Email field
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Password field
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 24),

                // Button Masuk
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Handle login
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.indigo[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 5,
                    ),
                    child: Text('Masuk'),
                  ),
                ),
                SizedBox(height: 16),

                // Link Daftar
                Text.rich(
                  TextSpan(
                    text: 'Belum memiliki akun? ',
                    children: [
                      TextSpan(
                        text: 'Daftar.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo[600],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 8),

                // Link Lupa Password
                Text(
                  'Lupa password?',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),

                // Repost credit
                Text.rich(
                  TextSpan(
                    text: 'Repost by ',
                    children: [
                      TextSpan(
                        text: 'InformaticsZone',
                        style: TextStyle(color: Colors.indigo),
                      )
                    ],
                  ),
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
