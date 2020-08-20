import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FileRemoteDataSource {
  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File file) async {
    final user = await FirebaseAuth.instance.currentUser();
    StorageReference reference = _storage.ref().child("images/${user.uid}");    StorageUploadTask uploadTask = reference.putFile(file);
    await uploadTask.onComplete;
    reference.getDownloadURL();
    final url = await reference.getDownloadURL();
    return url;
  }
}