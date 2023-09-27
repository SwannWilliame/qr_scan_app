import 'package:flutter/material.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:qr_scan_app/database/database_managment.dart';

Column databaseListTile(String id, String name, BuildContext context, void Function() actualise){
  return Column(
    children: [
      Card(
        elevation: 0,
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "id : $id",
                    style: const TextStyle(
                      fontSize: 12
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text(
                          "name : ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: ()async{
                  if(await confirm(context)){
                    Database().removeDocument(id);
                  }
                  actualise();
                }, 
                icon: Icon(Icons.delete, color: Colors.red[400],),
              )
            ],
          ),
        ),
      ),
      const SizedBox(height: 5,)
    ],
  );
}