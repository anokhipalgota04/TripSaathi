// ignore_for_file: unnecessary_null_comparison

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gonomad/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> signUpUsers({
    required String username,
    required String email,
    required String password,
    required String bio,
    required Uint8List file,
  }) async {
    String res = 'some error occured';
    try {
      if (username.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty
          // ignore: empty_statements
          ||
          file != null) {
        //registeruser
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);
        //upload image to storage
        String photoUrl = await Storagemethods()
            .uploadImageToStorage('profilePics', file, false);
        //add user to database
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          //'password': password,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl
        });

        res = 'success';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The email is badly formatted.';
      } else if (err.code == 'weak-password') {
        res = 'Password should be at least 6 characters';
      }else if (err.code == 'email-already-in-use') {
        res = 'The account already exists for that email.';
      }

    } catch (err) {
      print(
          'error in firestoreage do somethingggggggggggggggggggggggggggggjgbhjsbbrf');
      res = err.toString();
    }
    // throw Exception('Method not implemented');
    return res;
  }

  Future<String> loginInUsers({
    required String email,
    required String password,
  }) async {
    String res = 'some error occured';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential cred = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);
        res = 'success';
      } else {
        res = 'Please Enter All the Fields ';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The email is badly formatted.';
      } else if (err.code == 'weak-password') {
        res = 'Password should be at least 6 characters';
      }else if (err.code == 'user-not-found') {
        res = 'No user found for that email.';
      } else if (err.code == 'invalid-credential') {
        res = 'Wrong password provided for that user.';
      }
    }
     catch (err) {
      res = err.toString();
    }
    return res;
  }
}
