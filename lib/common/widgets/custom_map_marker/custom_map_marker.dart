import 'dart:ui';

import 'package:axilo/utils/constants/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Widget buildMarker(String imagePath) {
  return Container(
    width: 80,
    height: 80,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.transparent,
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        // Pin shape with border
        Image.asset(
          WImages.map_marker,
          scale: 0.1,
        ),

        // Profile photo
        // Container(
        //   width: 70,
        //   height: 70,
        //   decoration: BoxDecoration(
        //     shape: BoxShape.circle,
        //     border: Border.all(color: Colors.white, width: 2),
        //     image: DecorationImage(
        //       image: AssetImage(imagePath),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
      ],
    ),
  );
}

Future<BitmapDescriptor> createCustomMarker(GlobalKey key) async {
  final boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
  final image = await boundary.toImage(pixelRatio: 3.0);
  final byteData = await image.toByteData(format: ImageByteFormat.png);
  final pngBytes = byteData!.buffer.asUint8List();
  return BitmapDescriptor.bytes(pngBytes);
}
