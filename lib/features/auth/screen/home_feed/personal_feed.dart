import 'dart:ui'; // Import for using BackdropFilter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for SystemChrome
import 'package:gonomad/features/auth/screen/chat_feed/home_screen.dart';
import 'package:gonomad/features/auth/screen/home_feed/search_screen.dart';
import 'package:gonomad/widgets/post_card.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set the status bar color to transparent and icon brightness to dark
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      extendBodyBehindAppBar: true, // Extend body behind the AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make the AppBar transparent
        elevation: 1, // Remove the elevation
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'Tripsaathi',
              style: GoogleFonts.kaushanScript(
                color: Colors.black,
                fontSize: 32.0,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()));
              },
              icon: const Icon(
                Icons.search_rounded,
                color: Color.fromARGB(255, 0, 0, 0),
                size: 30,
              )),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
            icon: const Icon(
              Icons.messenger_outline_rounded,
            ),
            color: Colors.black, // Set the icon color to black
          ),
        ],
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
      ),

      //drawer

      drawer:
          const Drawer(), //DrawerContent(), // Use the DrawerContent widget here
      body: StreamBuilder(
        // stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('datePublished', descending: true)
            .snapshots(),

        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            physics:
                const AlwaysScrollableScrollPhysics(), // or AlwaysScrollableScrollPhysics()
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final snap = snapshot.data!.docs[index].data();
              return PostCard(snap: snap);
            },
            cacheExtent: MediaQuery.of(context).size.height * 8,
          );
        },
      ),
    );
  }
}
