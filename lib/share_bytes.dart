import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareBytes extends StatefulWidget {
  const ShareBytes({super.key});

  @override
  State<ShareBytes> createState() => _ShareBytesState();
}

ScreenshotController screenshotController = ScreenshotController();

class _ShareBytesState extends State<ShareBytes> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Center(
          child: ElevatedButton(
            child: const Text(
              'Capture An Invisible Widget',
            ),
            onPressed: () async {
              var container = Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 100,
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.blueAccent, width: 5.0),
                        color: Colors.pink,
                      ),
                      child: Text(
                        "This is an invisible widget",
                        style: Theme.of(context).textTheme.headlineMedium,
                      )),
                ],
              );

              var capturedImage = await screenshotController.captureFromWidget(
                  InheritedTheme.captureAll(
                      context, Material(child: container)),
                  delay: const Duration(seconds: 1));
              String packageName = "com.example.intent_testing";
              String url = "wasimapp://share";
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
              // String base64Image = const Base64Encoder().convert(capturedImage);
              // Share.share(base64Image);
              // Share.share(base64Decode(base64Image));

              // final directory = await getTemporaryDirectory();
              // final filePath =
              //     '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
              // print(filePath);
              // final file = File(filePath);
              // await file.writeAsBytes(capturedImage);

              // Share.shareFiles([filePath]);
            },
          ),
        ),
      ),
    );
  }
}
