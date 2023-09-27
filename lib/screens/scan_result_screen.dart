import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_scan_app/components/default_appbar.dart';

class ScanResultScreen extends StatefulWidget {
  final String id;
  const ScanResultScreen({required this.id, super.key});

  @override
  State<ScanResultScreen> createState() => _ScanResultScreenState();
}

class _ScanResultScreenState extends State<ScanResultScreen> {
  String id="";

  @override
  void initState() {
    id=widget.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar("Scan Result"),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("ids").doc(id).snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator.adaptive());
          }else{
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return Center(
              child: Text(
                "Page de ${userData["name"]}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),
              ),
            );
          }
        },
      )
    );
  }
}