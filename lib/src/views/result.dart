// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ResultScreen extends StatefulWidget {
  final String data;

  const ResultScreen(this.data, {super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.qr_code,
              size: 26,
            ),
            Text(
              'QR FOUND',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  letterSpacing: 2.0),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 200,
                width: 200,
                child: Image.network(
                    'https://pngimg.com/uploads/qr_code/qr_code_PNG10.png'),
              ),
              const Text('QR Found'),
              ElevatedButton(
                  onPressed: () {
                    final url =
                        'https://www.google.com/search?q=${widget.data}';
                    if (url.isNotEmpty) {
                      _launchUrl(url);
                    }
                  },
                  child: const Text('Open a Webpage')),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('GO Back to Scan another barcode')),
            ],
          ),
        ),
      ),
    );
  }
}
