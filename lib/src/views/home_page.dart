import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'result.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MobileScannerController _controller =
      MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates);
  String? data;
  @override
  // void initState() {
  //   super.initState();
  //   _controller =
  //       MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates);
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              SizedBox(
                width: 10.0,
              ),
              Text(
                'QR Scanner',
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
                height: 20.0,
              ),
              const Text(
                'Place the bar code inside the scanner',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    5.0,
                  ),
                ),
                height: 200,
                width: 200,
                child: MobileScanner(
                  fit: BoxFit.cover,
                  controller: _controller,
                  onDetect: (capture) async {
                    final List<Barcode> barCodesCaptured = capture.barcodes;

                    for (final barCode in barCodesCaptured) {
                      if (barCode.rawValue != null) {
                        data = barCode.rawValue;
                      }
                    }
                    if (data != null) {
                      await Future.wait([
                        _controller.stop(),
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => ResultScreen(data!)))
                            .then((result) async {
                          if (result == true) {
                            await _controller.start();
                          }
                        }),
                      ]);
                    }
                    print(data);
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    _controller.toggleTorch();
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.flash_off),
                      Text('Turn ON/OFF flash light'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
