import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PegDanaPage extends StatefulWidget {
  const PegDanaPage({super.key});

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
      Uri.parse('http://10.0.2.2:8000/api/campaigns'),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
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
                child: ListTile(
                  title: Text(c['judul_campaign'] ?? '-'),
                  subtitle: Text(
                    'Oleh: ${c['user']?['name'] ?? '-'} - Kategori: ${c['category']?['nama_kategori'] ?? '-'}',
                  ),
                  leading: c['foto_campaign'] != null
                      ? Image.network(
                          'http://10.0.2.2:8000/storage/images/campaign/${c['foto_campaign']}',
                          width: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, color: Colors.red),
                        )
                      : const Icon(Icons.image),
                ),
              );
            },
          );
        },
      ),
    );
  }
}