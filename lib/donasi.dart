// import package
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  final String snapToken;
  final String orderId;

  const PaymentWebView({
    super.key,
    required this.snapToken,
    required this.orderId,
  });

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    print(
      'URL yang dimuat WebView: https://app.midtrans.com/snap/v2/vtweb/${widget.snapToken}',
    );
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse('https://app.midtrans.com/snap/v2/vtweb/${widget.snapToken}'),
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            print('Mulai muat URL: $url');
            if (!url.contains("snap/v2/vtweb")) {
              print('Peringatan: URL yang dimuat bukan halaman Snap!');
            }
          },
          onPageFinished: (url) {
            print('Selesai muat URL: $url');
            if (url.contains("thank_you")) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => PaymentStatusPage(orderId: widget.orderId),
                ),
              );
            }
          },
          onWebResourceError: (error) {
            print('WebView error: ${error.description}');
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran')),
      body: WebViewWidget(controller: _controller),
    );
  }
}

class PaymentStatusPage extends StatelessWidget {
  final String orderId;

  const PaymentStatusPage({super.key, required this.orderId});

  Future<String> checkStatus() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2/api/status/$orderId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['transaction_status'];
    } else {
      throw Exception('Gagal memeriksa status pembayaran');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Status Pembayaran')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              final status = await checkStatus();
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Status Pembayaran'),
                  content: Text('Status: $status'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            } catch (e) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Error: $e')));
            }
          },
          child: const Text('Cek Status Pembayaran'),
        ),
      ),
    );
  }
}

class DonationPage extends StatefulWidget {
  final Map<String, dynamic> campaign;

  const DonationPage({super.key, required this.campaign});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  Future<void> createTransaction(BuildContext context) async {
    print('createTransaction() dipanggil');
    try {
      if (_amountController.text.isEmpty ||
          int.tryParse(_amountController.text) == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Jumlah donasi harus berupa angka yang valid'),
          ),
        );
        return;
      }

      print('Mengirim data transaksi...');
      print(
        'Request body: ${jsonEncode({'user_id': 1, 'campaign_id': widget.campaign['id'], 'nominal': int.parse(_amountController.text), 'nama': _nameController.text, 'pesan': _messageController.text})}',
      );

      final response = await http.post(
        Uri.parse('http://10.0.2.2/donasi/public/api/create-transaction'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': 1,
          'campaign_id': widget.campaign['id'],
          'nominal': int.parse(_amountController.text),
          'nama': _nameController.text,
          'pesan': _messageController.text,
        }),
      );
      final body = jsonDecode(response.body);
      print('Response dari create-transaction: $body');
      if (!body.containsKey('order_id')) {
        throw Exception('order_id tidak ditemukan dalam response');
      }

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Response dari create-transaction: $responseData');

        final orderId = responseData['order_id'];
        if (orderId == null) throw Exception('order_id tidak ditemukan');

        final snapTokenResponse = await http.get(
          Uri.parse('http://10.0.2.2/donasi/public/api/checkout/$orderId'),
        );

        print('Status code checkout: ${snapTokenResponse.statusCode}');
        print('Body checkout: ${snapTokenResponse.body}');

        if (snapTokenResponse.statusCode != 200) {
          throw Exception('Gagal mendapatkan Snap Token');
        }

        final snapBody = jsonDecode(snapTokenResponse.body);
        print('Response dari checkout: $snapBody');
        if (!snapBody.containsKey('snapToken')) {
          throw Exception('snapToken tidak ditemukan dalam response');
        }

        if (snapTokenResponse.statusCode == 200) {
          final snapData = jsonDecode(snapTokenResponse.body);
          print('Response dari checkout: $snapData');

          final snapToken = snapData['snapToken'];
          if (snapToken == null) throw Exception('snapToken tidak ditemukan');

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PaymentWebView(snapToken: snapToken, orderId: orderId),
            ),
          );
        } else {
          throw Exception('Gagal mendapatkan Snap Token');
        }
      } else {
        throw Exception('Gagal membuat transaksi');
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donasi untuk ${widget.campaign['judul_campaign']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Campaign
            Image.network(
              widget.campaign['foto_campaign'],
              fit: BoxFit.cover,
              height: 250,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.broken_image, size: 100, color: Colors.red),
            ),
            const SizedBox(height: 16),

            // Judul Campaign
            Text(
              widget.campaign['judul_campaign'] ?? '-',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Form Donasi
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Jumlah Donasi (IDR)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                labelText: 'Pesan / Do\'a',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Tombol Bayar
            Center(
              child: ElevatedButton(
                onPressed: () {
                  print('Tombol Bayar Sekarang ditekan');
                  createTransaction(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CA7C4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'Bayar Sekarang',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
