import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadFile(File file, {required String prefix}) async {
    final snapshot = await _storage.ref('$prefix').child(Uuid().v4()).putFile(file);
    return await snapshot.ref.getDownloadURL();
  }
}
