import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;

class StorageService {
  StorageService({required this.firebaseStorage});
  final FirebaseStorage firebaseStorage;
  Future<String?> uploadFileToFirebase(File file, String filePath) async {
    // Upload the file to Firebase Storage and return the download URL

    try {
      final mimeType = lookupMimeType(file.path)!;

      final fileExtension = path.extension(file.path);

      // Generate a unique ID for the file
      final uniqueId = DateTime.now().millisecondsSinceEpoch.toString();

      // Create a reference to the file location
      final ref = firebaseStorage.ref('$filePath/$uniqueId$fileExtension');

      // Upload the file
      final uploadTask =
          ref.putFile(file, SettableMetadata(contentType: mimeType));

      // Wait for the upload to complete
      final taskSnapshot = await uploadTask.whenComplete(() {});

      // Get the download URL
      final url = await taskSnapshot.ref.getDownloadURL();

      return url;
    } catch (e) {
      print('Failed to upload file: $e');
      return null;
    }
  }
}
