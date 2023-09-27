import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

void saveImageToGallery(Uint8List imageBytes, BuildContext context) async {
  SnackBar? snackBar;
    final result = await ImageGallerySaver.saveImage(imageBytes);
    if (result['isSuccess']) {
      snackBar=const SnackBar(content: Text("QR Code successfully saved !"));
    } else {
      snackBar=const SnackBar(content: Text("There was an error when saving the QR Code..."));
    }
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }