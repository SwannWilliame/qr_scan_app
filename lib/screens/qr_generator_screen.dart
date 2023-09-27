import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scan_app/components/default_appbar.dart';
import 'package:qr_scan_app/components/home_button.dart';
import 'package:qr_scan_app/database/database_managment.dart';
import 'package:qr_scan_app/utils/id_generator.dart';
import 'package:qr_scan_app/utils/save_image.dart';
import 'package:screenshot/screenshot.dart';

class QRGeneratorScreen extends StatefulWidget {
  const QRGeneratorScreen({super.key});

  @override
  State<QRGeneratorScreen> createState() => _QRGeneratorScreenState();
}

class _QRGeneratorScreenState extends State<QRGeneratorScreen> {

  TextEditingController nameController = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();

  String secretId=generateId(12);

  SnackBar? snackBar;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar("QR Code Generator"),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50,),
              Screenshot(
                controller: screenshotController,
                child: QrImageView(
                  data: secretId,
                  size: 200,
                ),
              ),
              const SizedBox(height: 40,),
              TextFormField(
                controller: nameController,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                cursorColor: Colors.black,
                onChanged: (value) {
                  setState(() {
                    secretId=generateId(12);
                  });
                },
                decoration: InputDecoration(
                  hintText: "Enter a name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black, width: 1.5)
                  )
                ),
              ),
              const SizedBox(height: 20,),
              homeButton(Icons.download, "Download QR Code", () {
                screenshotController.capture().then((value) async{
                  await Database().createId(secretId, nameController.text);
                  saveImageToGallery(value!, context);
                },);
              })
            ],
          ),
        ),
      ),
    );
  }
}