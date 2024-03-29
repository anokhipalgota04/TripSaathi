import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PersonList extends StatefulWidget {
  const PersonList({Key? key}) : super(key: key);

  @override
  State<PersonList> createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {
  late Future<DocumentSnapshot> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Following Users'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('User not found.'));
          } else {
            List<dynamic> following = snapshot.data!.get('following') ?? [];
            if (following.isNotEmpty) {
              return ListView.builder(
                itemCount: following.length,
                itemBuilder: (context, index) {
                  return _buildUserTile(following[index]);
                },
              );
            } else {
              return const Center(child: Text('No followers found.'));
            }
          }
        },
      ),
    );
  }

  Widget _buildUserTile(String userId) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData ||
            !snapshot.data!.exists) {
          return const SizedBox.shrink();
        }
        Map<String, dynamic> userData =
            snapshot.data!.data() as Map<String, dynamic>;

        // Check if photoUrl is not null or empty
        String? photoUrl = userData['photoUrl'] as String?;

        // Define a variable for the avatar image
        late ImageProvider avatar;
        if (photoUrl != null && photoUrl.isNotEmpty) {
          avatar = CachedNetworkImageProvider(photoUrl);
        } else {
          avatar = const AssetImage('assets/images/default.png');
        }

        return  ListTile(
           leading: CircleAvatar(
            backgroundImage: avatar,
          ),
          title: Text(userData['username'] ?? ''),
          onTap: () {
            // Handle onTap action
          },
        );
      },
    );
  }

  Future<DocumentSnapshot> _getUserData() async {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance.collection('users').doc(uid).get();
  }
}
