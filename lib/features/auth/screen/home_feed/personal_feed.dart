import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gonomad/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Connect',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Billabong',
            fontSize: 32.0,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.messenger_outline_rounded,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            physics:
                AlwaysScrollableScrollPhysics(), // or AlwaysScrollableScrollPhysics()
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
