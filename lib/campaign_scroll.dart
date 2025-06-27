import 'package:flutter/material.dart';
import 'pegdana.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail_campaign.dart';

class CampaignScroll extends StatefulWidget {
  const CampaignScroll({super.key});

  @override
  _CampaignScrollState createState() => _CampaignScrollState();
}

class _CampaignScrollState extends State<CampaignScroll> {
  late Future<List<dynamic>> campaignsFuture;

  @override
  void initState() {
    super.initState();
    campaignsFuture = fetchCampaigns();
  }

  Future<List<dynamic>> fetchCampaigns() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2/donasi/public/api/campaigns'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      return data;
    } else {
      throw Exception('Gagal memuat data campaign');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: campaignsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Tidak ada campaign'));
        }
        final campaigns = snapshot.data!;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...campaigns.take(5).map((campaign) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailCampaignPage(campaign: campaign),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.blue[400],
                        image: DecorationImage(
                          image: NetworkImage(campaign['foto_campaign']),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.black.withOpacity(0.4),
                        ),
                        child: Center(
                          child: Text(
                            campaign['judul_campaign'] ?? '-',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PegDanaPage(category: 'all'),
                    ),
                  );
                },
                child: Container(
                  width: 90,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blue[800],
                  ),
                  child: Center(
                    child: Text(
                      'Lihat Lebih Banyak',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
