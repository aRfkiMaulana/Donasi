import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail_campaign.dart';

class PegDanaPage extends StatefulWidget {
  final String category;

  const PegDanaPage({required this.category, super.key});

  @override
  State<PegDanaPage> createState() => _PegDanaPageState();
}

class _PegDanaPageState extends State<PegDanaPage> {
  late Future<List<dynamic>> campaignsFuture;

  @override
  void initState() {
    super.initState();
    campaignsFuture = fetchCampaigns();
  }

  Future<List<dynamic>> fetchCampaigns() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2/donasi/public/api/campaigns'),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final campaigns = json.decode(response.body);

    if (widget.category == 'all') {
      // Jika kategori 'all', kembalikan semua campaign
        return campaigns;
      }
      // Filter campaign berdasarkan kategori
      return campaigns.where((c) {
        return c['category']['id'].toString() == widget.category;
      }).toList();
    } else {
      throw Exception('Gagal memuat data campaign');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Campaign')),
      body: FutureBuilder<List<dynamic>>(
        future: campaignsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada campaign'));
          }
          final campaigns = snapshot.data!;
          return ListView.builder(
            itemCount: campaigns.length,
            itemBuilder: (context, index) {
              final c = campaigns[index];
              return Card(
                margin: const EdgeInsets.all(16.0),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      c['foto_campaign'] != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                c['foto_campaign'],
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.broken_image, color: Colors.red, size: 50),
                              ),
                            )
                          : const Icon(Icons.image, size: 50),
                      const SizedBox(height: 16),
                      Text(
                        c['judul_campaign'] ?? '-',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Oleh: ${c['user']?['name'] ?? '-'}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Kategori: ${c['category']?['nama_kategori'] ?? '-'}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Navigasi ke halaman detail campaign
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailCampaignPage(campaign: c),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12 , horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Lihat Detail'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}