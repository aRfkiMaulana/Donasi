import 'package:flutter/material.dart';
import 'campaign_scroll.dart';
import 'profile_page.dart';
import 'pegdana.dart';

class HomePage extends StatefulWidget {
  final String username;
  HomePage({required this.username, super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.school, 'label': 'Pendidikan', 'id': 1},
    {'icon': Icons.group, 'label': 'Sosial', 'id': 2},
    {'icon': Icons.favorite, 'label': 'Kesehatan', 'id': 3},
  ];

  @override
  Widget build(BuildContext context) {
    // Daftar halaman berdasarkan indeks
    final List<Widget> _pages = [
      // Halaman Home
      ListView(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/ab.jpg', // Ganti dengan path gambar kamu
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
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
                          'Wahai orang-orang yang beriman, infakkanlah sebagian dari rezeki yang telah Kami anugerahkan kepadamu sebelum datang hari (Kiamat) yang tidak ada (lagi) jual beli padanya (hari itu), tidak ada juga persahabatan yang akrab, dan tidak ada pula syafaat. Orang-orang kafir itulah orang-orang zalim.” (QS Al Baqarah ayat 254)',
                          style: TextStyle(color: Colors.white, fontSize: 13,),
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: categories.map((cat) {
                return GestureDetector(
                  onTap: () {
                    // Navigasi ke PegDanaPage dengan kategori
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PegDanaPage(category: cat['id'].toString()),
                      ),
                    );
                  },
                  child: Column(
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
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CampaignScroll(),
          ),
          SizedBox(height: 30),
          
          
        ],
      ),
      // Halaman Profil
      ProfilePage(
        username: widget.username,
        email: 'user@example.com', // Ganti dengan email dari database
        phoneNumber: '1234567890', // Ganti dengan nomor telepon dari database
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Icon(Icons.volunteer_activism, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Halo, ${widget.username}',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.blue[800],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
