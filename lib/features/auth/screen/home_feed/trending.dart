import 'dart:ui'; // Import for using BackdropFilter

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gonomad/widgets/trending_card.dart';
import 'package:google_fonts/google_fonts.dart'; // Import for SystemChrome

class TrendingScreen extends StatelessWidget {
  const TrendingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set the status bar color to transparent and icon brightness to dark
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true, // Extend body behind the AppBar
        appBar: AppBar(
          backgroundColor: Colors.transparent, // Make the AppBar transparent
          elevation: 0, // Remove the elevation
          title: Center(
            child: Text(
              'Trending',
              style: GoogleFonts.kaushanScript(
                color: Colors.black,
                fontSize: 25.0,
              ),
            ),
          ),
          flexibleSpace: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 9,
                sigmaY: 9,
              ), // Adjust the sigmaX and sigmaY values for blur intensity
              child: Container(
                color: Colors.white.withOpacity(0.7),
                // Adjust opacity as needed
              ),
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Today'),
              Tab(text: 'For You'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TodayPosts(), // Display posts created today
            ForYouPosts(), // Display all other posts
          ],
        ),
      ),
    );
  }
}

class TodayPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetch today's date
    DateTime today = DateTime.now();
    DateTime todayStart = DateTime(today.year, today.month, today.day);
    DateTime todayEnd = DateTime(today.year, today.month, today.day, 23, 59, 59);

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('trending')
          .where('datePublished', isGreaterThanOrEqualTo: todayStart)
          .where('datePublished', isLessThanOrEqualTo: todayEnd)
          .orderBy('datePublished', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No Trending news for today'));
        }
        return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final snap = snapshot.data!.docs[index].data();
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TrendingCard(snap: snap),
            );
          },
          cacheExtent: MediaQuery.of(context).size.height * 8,
        );
      },
    );
  }
}

class ForYouPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('trending')
          .orderBy('datePublished', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final snap = snapshot.data!.docs[index].data();
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TrendingCard(snap: snap),
            );
          },
          cacheExtent: MediaQuery.of(context).size.height * 8,
        );
      },
    );
  }
}
