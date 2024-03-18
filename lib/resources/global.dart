import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gonomad/features/auth/screen/add_post.dart';
import 'package:gonomad/features/auth/screen/home_feed/Maps.dart';
//import 'package:gonomad/features/auth/screen/home_feed/home.dart';
import 'package:gonomad/features/auth/screen/home_feed/personal_feed.dart';
import 'package:gonomad/features/auth/screen/profile_screen.dart';

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const Text('community'),
  const AddPostScreen(),
  Maping(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  )
];
