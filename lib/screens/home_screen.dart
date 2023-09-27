import 'package:flutter/material.dart';
import 'package:qr_scan_app/components/home_button.dart';
import 'package:qr_scan_app/screens/database_screen.dart';
import 'package:qr_scan_app/screens/qr_generator_screen.dart';
import 'package:qr_scan_app/screens/qr_scan_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Column(
              children: [
                const Text(
                  "QR Scan",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w600
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      homeButton(Icons.queue_rounded, "Create QR Code", () {Navigator.push(context, MaterialPageRoute(builder: (context) => QRGeneratorScreen(),));}),
                      const SizedBox(height: 15,),
                      homeButton(Icons.qr_code_scanner, "Scan QR Code", () {Navigator.push(context, MaterialPageRoute(builder: (context) => QRScanScreen(),));}),
                      const SizedBox(height: 15,),
                      homeButton(Icons.data_saver_off_outlined, "Manage the database", () {Navigator.push(context, MaterialPageRoute(builder: (context) => DatabaseScreen(),));}),

                      SizedBox(height: 50,)
                    ],
                  ),
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}