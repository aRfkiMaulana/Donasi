import 'package:flutter/material.dart';
import 'login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donasi App',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.school, 'label': 'Pendidikan'},
    {'icon': Icons.group, 'label': 'Sosial'},
    {'icon': Icons.favorite, 'label': 'Kesehatan'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.volunteer_activism, color: Colors.white),
            SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),

          // Menu Ikon
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: categories.map((cat) {
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blue[100],
                      child: Icon(
                        cat['icon'],
                        size: 30,
                        color: Colors.blue[800],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(cat['label']),
                  ],
                );
              }).toList(),
            ),
          ),

          SizedBox(height: 30),

          // Berita utama
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/banjir.jpg', // Ganti dengan path gambar kamu
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(height: 200, color: Colors.black.withOpacity(0.4)),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Aksi Penyaluran Dana Bantuan Banjir Loa Janan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Banjir terjadi di Loa Janan, sebanyak 18 lingkungan RT terendam banjir dengan ketinggian 30cm sampai 150cm akibat hujan deras dengan intensitas tinggi.',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Colors.blue.withOpacity(0.7), Colors.transparent],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Galang Dana\nSekarang',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 30),
        ],
      ),
    );
  }
}
