import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FileRemoteDataSource {
  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File file) async {
    final user = await FirebaseAuth.instance.currentUser();
    final uid = Uuid().v4();
    StorageReference reference = _storage.ref().child("images/${user.uid}/$uid");
    StorageUploadTask uploadTask = reference.putFile(file);
    await uploadTask.onComplete;
    reference.getDownloadURL();
    final url = await reference.getDownloadURL();
    return url;
  }
}