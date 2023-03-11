import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ShareUint8List extends StatelessWidget {
  final Uint8List bytes;

  ShareUint8List({required this.bytes});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.share),
      onPressed: () {
        final ByteData bytesData = bytes.buffer.asByteData();
        final file = File('${(DateTime.now()).millisecondsSinceEpoch}.jpg')
          ..writeAsBytesSync(bytesData.buffer
              .asUint8List(bytesData.offsetInBytes, bytes.lengthInBytes));

        Share.shareFiles([file.path]);
      },
    );
  }
}
