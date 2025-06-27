import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import package intl
import 'donasi.dart';

class DetailCampaignPage extends StatelessWidget {
  final Map<String, dynamic> campaign;

  const DetailCampaignPage({super.key, required this.campaign});

  // Fungsi untuk memformat angka dengan titik sebagai pemisah ribuan
  String formatCurrency(int amount) {
    final formatter = NumberFormat('#,###', 'id_ID');
    return formatter.format(amount).replaceAll(',', '.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(campaign['judul_campaign'] ?? 'Detail Campaign'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar Campaign
              Image.network(
                campaign['foto_campaign'],
                fit: BoxFit.cover,
                height: 400,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.broken_image, size: 100, color: Colors.red),
              ),
              const SizedBox(height: 16),

              // Judul Campaign
              Text(
                campaign['judul_campaign'] ?? '-',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // Deskripsi Campaign
              Text(
                campaign['deskripsi_campaign'] ?? 'Deskripsi tidak tersedia',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),

              // Informasi Dana Terkumpul, Target, dan Tanggal Berakhir
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Dana Terkumpul:'),
                      Text(
                        'Rp${formatCurrency(campaign['dana_terkumpul'] ?? 0)}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Target Dana:'),
                      Text(
                        'Rp${formatCurrency(campaign['target_campaign'] ?? 0)}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Tanggal Berakhir:'),
                      Text(
                        campaign['tgl_akhir_campaign'] ?? '-',
                        style: const TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Tombol Donasi
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DonationPage(campaign: campaign),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CA7C4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text(
                    'Donasi Sekarang',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}