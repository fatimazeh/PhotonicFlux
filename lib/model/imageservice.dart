import 'dart:async';
import 'dart:io' as io;
import 'dart:html' as html;
import 'package:firebase_storage/firebase_storage.dart';

class ImageService {
  // Upload image to Firebase Storage and return the download URL
  Future<String> uploadImage(io.File file) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('uploads/${DateTime.now().toIso8601String()}');
      await storageRef.putFile(file);
      final downloadURL = await storageRef.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      throw Exception('Image upload failed');
    }
  }

  // For web: Read image file as a base64 URL
  Future<String> readImageAsBase64(html.File file) async {
    final reader = html.FileReader();
    final completer = Completer<String>();

    reader.onLoadEnd.listen((_) {
      completer.complete(reader.result as String?);
    });

    reader.readAsDataUrl(file);
    return completer.future;
  }
}
