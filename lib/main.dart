import 'package:flutter/material.dart';
import 'login.dart';
import 'pegdana.dart';
import 'campaign_scroll.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

  HomePage({super.key});

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
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),

          // Berita utama
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/ad.png', // Ganti dengan path gambar kamu
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
                          'DONASI',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Orang-orang yang menginfakkan harta mereka di jalan Allah, kemudian tidak mengiringi apa yang mereka infakkan itu dengan menyebut-nyebutnya dan menyakiti (perasaan penerima), bagi mereka pahala di sisi Tuhan mereka. Tidak ada rasa takut pada mereka dan mereka tidak bersedih.” (QS Al Baqarah ayat 262).',
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

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CampaignScroll(), // Tambahkan widget ini
          ),

          SizedBox(height: 30),
        ],
      ),
    );
  }
}
