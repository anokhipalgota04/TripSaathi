import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';


class Storagemethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // adding images to firebase
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    // required String uid,
    // required String imageType,
    // required String imagePath,
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
