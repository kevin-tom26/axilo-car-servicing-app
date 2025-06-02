import 'dart:convert';
import 'dart:io';

import 'package:axilo/core/local/local_data.dart';
import 'package:axilo/core/services/base_service/base_service.dart';
import 'package:axilo/features/auth/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProfileService extends BaseService {
  final AuthService _authService = AuthService();

  Future<String> uploadImageToImgBBWithDio(File imageFile) async {
    String apiKey = dotenv.env['IMGBB_API_KEY']!;

    try {
      final base64Image = base64Encode(imageFile.readAsBytesSync());

      final response = await dio.post(
        'https://api.imgbb.com/1/upload?key=$apiKey',
        data: {
          'image': base64Image,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return response.data['data']['url'];
      } else {
        debugPrint('Upload failed: ${response.data}');
        throw Exception('Upload failed: ${response.data}');
        //  return null;
      }
    } catch (e) {
      debugPrint('Dio error: $e');
      rethrow;
      //return null;
    }
  }

  Future<void> updateUserProfile(Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(LocalData().userId).update(data);
      final user = FirebaseAuth.instance.currentUser!;
      await _authService.processLogin(user);
    } on FirebaseException catch (e) {
      debugPrint('Error userProfile update failed: ${e.message}');
      rethrow;
    }
  }
}
