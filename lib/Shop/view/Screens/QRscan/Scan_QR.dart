import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../../Widget/constands/colors.dart';
import 'QR_order.dart';

class ScanQr extends StatelessWidget {
  const ScanQr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'), // Replace with your background image
            fit: BoxFit.cover,
          ),
       ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Scan the QR Code",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            // const SizedBox(height: 20),
            // Image.asset(
            //   'assets/Scan.png',
            //   width: 100,
            //   height: 100,
            // ),
            const SizedBox(height: 20),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QR_order()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[700],
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Scan",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Image.asset(
                      'assets/line-scan.png',
                      width: 24,
                      height: 24,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
