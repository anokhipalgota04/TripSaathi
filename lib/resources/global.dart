import 'package:flutter/material.dart';
import 'package:gonomad/features/auth/screen/add_post.dart';
//import 'package:gonomad/features/auth/screen/home_feed/home.dart';
import 'package:gonomad/features/auth/screen/home_feed/personal_feed.dart';
import 'package:gonomad/features/auth/screen/home_feed/Maps.dart';

const homeScreenItems = [
  FeedScreen(),
  Text('community'),
  AddPostScreen(),
  Maping(),
  Text('profile'),
];
