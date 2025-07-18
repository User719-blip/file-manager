import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class FullScreenImagePage extends StatelessWidget {
  final AssetEntity image;

  const FullScreenImagePage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: FutureBuilder<Uint8List?>(
          future: image.originBytes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(color: Colors.white);
            } else if (snapshot.hasError || snapshot.data == null) {
              return const Text(
                'Failed to load image',
                style: TextStyle(color: Colors.white),
              );
            } else {
              return InteractiveViewer(child: Image.memory(snapshot.data!));
            }
          },
        ),
      ),
    );
  }
}
