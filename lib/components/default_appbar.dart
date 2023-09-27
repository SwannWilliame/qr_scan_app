import 'package:flutter/material.dart';

AppBar defaultAppbar(String title){
  return AppBar(
    backgroundColor: Colors.white30,
    foregroundColor: Colors.black,
    elevation: 0,
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w600
      ),
    ),
    
  );
}