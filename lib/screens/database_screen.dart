import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_scan_app/components/database_listtile.dart';
import 'package:qr_scan_app/components/default_appbar.dart';
import 'package:qr_scan_app/database/database_managment.dart';

class DatabaseScreen extends StatefulWidget {
  const DatabaseScreen({super.key});

  @override
  State<DatabaseScreen> createState() => _DatabaseScreenState();
}

class _DatabaseScreenState extends State<DatabaseScreen> {

  void actualise(){
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar("Manage the Database"),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: Database().getAllDocuments(),
        builder: (BuildContext context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          List<DocumentSnapshot> documents = snapshot.data!;
          if(documents.isEmpty){
            return const Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Database is empty",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: databaseListTile(documents[index].id, documents[index]["name"], context, actualise),
              );
            },
          );
        },
      )
    );
  }
}