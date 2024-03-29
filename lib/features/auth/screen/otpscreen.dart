import 'package:flutter/material.dart';

class OTPSCREEN extends StatefulWidget {
  const OTPSCREEN({super.key});

  @override
  State<OTPSCREEN> createState() => _OTPSCREENState();
}

class _OTPSCREENState extends State<OTPSCREEN> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}



// StreamBuilder(
//   stream: FirebaseFirestore.instance
//     .collection('users')
//     .doc(uid) // Assuming uid is passed to this widget
//     .snapshots(),
    
//   builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return Center(child: CircularProgressIndicator());
//     }
//     if (!snapshot.hasData || !snapshot.data!.exists) {
//       return Center(child: Text('User not found.'));
//     }
//     // Cast userData to Map<String, dynamic>
//     Map<String, dynamic>? userData = snapshot.data!.data() as Map<String, dynamic>?;

//     if (userData == null) {
//       return Center(child: Text('User data is null.'));
//     }

//     // Ensure userData is not null before accessing its fields
//     var followingList = userData['followingList'];

//     if (followingList == null || followingList.isEmpty) {
//       return Text('$uid');
//       //return Center(child: Text('No one is being followed.'));
//     }

//     return StreamBuilder(
//       stream: FirebaseFirestore.instance
//         .collection('posts')
//         .where('uid', whereIn: followingList)
//         .orderBy('datePublished', descending: true)
//         .snapshots(),
//       builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
//           return Center(child: Text('No posts from followed users.'));
//         }
//         return ListView.builder(
//           itemCount: snapshot.data!.docs.length,
//           itemBuilder: (context, index) {
//             final snap = snapshot.data!.docs[index].data();
//             return PostCard(snap: snap);
//           },
//           cacheExtent: MediaQuery.of(context).size.height * 8,
//         );
//       },
//     );
//   },
// ),





// FutureBuilder<String?>(
//             future: _getUserUID(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//               if (snapshot.hasData && snapshot.data != null) {
//                 return Center(
//                   child: Text(snapshot.data!),
//                 );
//               } else {
//                 return const Center(child: Text('User not found.'));
//               }

              
//             },
//           ),




/*FutureBuilder<String?>(
      future: _getUserUID(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('User not found.'));
        }
        return StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('users').doc(snapshot.data!).snapshots(),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
              return const Center(child: Text('User data not found.'));
            }
            List<dynamic> followingList = userSnapshot.data!.get('following') ?? [];
            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .where('uid', whereIn: followingList)
                  .orderBy('datePublished', descending: true)
                  .snapshots(),
              builder: (context, postSnapshot) {
                if (postSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: postSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final post = postSnapshot.data!.docs[index].data();
                    return PostCard(snap: post);
                  },
                );
              },
            );
          },
        );
      },
    ),*/