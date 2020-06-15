import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FileRemoteDataSource {
  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File file) async {
    StorageReference reference = _storage.ref().child("images/");
    StorageUploadTask uploadTask = reference.putFile(file);
    await uploadTask.onComplete;
    reference.getDownloadURL();
    final url = await reference.getDownloadURL();
    return url;
  }
}