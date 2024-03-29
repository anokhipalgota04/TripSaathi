// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // // import 'package:gonomad/core/community/constants/error.dart';
// // // import 'package:gonomad/core/community/constants/loader.dart';
// // // import 'package:gonomad/core/community/controllers/community_controller..dart';
// // // import 'package:gonomad/core/community/screens/community_Profile_screen.dart';
// // // import 'package:gonomad/core/community/screens/create_community_screen.dart';
// // // import 'package:gonomad/models/community.dart';

// // // class CommunityList extends ConsumerWidget {
// // //   const CommunityList({super.key});

// // //   void navigateToCreateCommunity(BuildContext context) {
// // //     Navigator.push(
// // //       context,
// // //       MaterialPageRoute(builder: (context) => CreateCommunityScreen()),
// // //     );
// // //   }

// // //   void navigateToCommunity(BuildContext context, Community community) {
// // //     Navigator.push(
// // //       context,
// // //       MaterialPageRoute(
// // //         builder: (context) => CommunityScreen(name: community.name),
// // //       ),
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context, WidgetRef ref) {
// // //     return Drawer(
// // //       child: SafeArea(
// // //           child: Column(
// // //         children: [
// // //           ListTile(
// // //             title: Text('Create a Community '),
// // //             leading: Icon(Icons.add),
// // //             onTap: () => navigateToCreateCommunity(context),
// // //           ),
// // //           ref.watch(userCommunitiesProvider).when(
// // //               data: (communities) => Expanded(
// // //                     child: (ListView.builder(
// // //                         itemCount: communities.length,
// // //                         itemBuilder: (BuildContext context, int index) {
// // //                           final community = communities[index];
// // //                           return ListTile(
// // //                             leading: CircleAvatar(
// // //                               backgroundImage: NetworkImage(community.avator),
// // //                             ),
// // //                             title: Text('ts/${community.name}'),
// // //                             onTap: () {
// // //                               navigateToCommunity(context, community);
// // //                             },
// // //                           );
// // //                         })),
// // //                   ),
// // //               error: (error, StackTrace) => ErrorText(error: error.toString()),
// // //               loading: () => const Loader())
// // //         ],
// // //       )),
// // //     );
// // //   }
// // // }

// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:gonomad/core/community/constants/error.dart';
// // import 'package:gonomad/core/community/constants/loader.dart';
// // import 'package:gonomad/core/community/controllers/community_controller..dart';
// // import 'package:gonomad/core/community/screens/community_Profile_screen.dart';
// // import 'package:gonomad/core/community/screens/create_community_screen.dart';
// // import 'package:gonomad/core/community/screens/search_delegates.dart';
// // import 'package:gonomad/models/community.dart';

// // class CommunityList extends ConsumerWidget {
// //   const CommunityList({super.key});

// //   void navigateToCreateCommunity(BuildContext context) {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(builder: (context) => CreateCommunityScreen()),
// //     );
// //   }

// //   void navigateToCommunity(BuildContext context, Community community) {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(
// //         builder: (context) => CommunityScreen(name: community.name),
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final FirebaseAuth _auth = FirebaseAuth.instance;
// //     User currentUser = _auth.currentUser!;
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Search Communities"),
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.search),
// //             onPressed: () {
// //               showSearch(
// //                   context: context,
// //                   delegate: SearchCommunityDelegate(ref: ref));
// //             },
// //           ),
// //         ],
// //       ),
// //       body: Drawer(
// //         child: Column(
// //           children: [
// //             ListTile(
// //               title: Text('Create a Community '),
// //               leading: Icon(Icons.add),
// //               onTap: () => navigateToCreateCommunity(context),
// //             ),
// //             ref.watch(userCommunitiesProvider).when(
// //                   data: (communities) => Expanded(
// //                     child: ListView.builder(
// //                       itemCount: communities.length,
// //                       itemBuilder: (BuildContext context, int index) {
// //                         final community = communities[index];
// //                         return ListTile(
// //                           leading: CircleAvatar(
// //                             backgroundImage: NetworkImage(community.avator),
// //                           ),
// //                           title: Text('/ts/${community.name}'),
// //                           onTap: () {
// //                             navigateToCommunity(context, community);
// //                           },
// //                           subtitle: community.mods.contains(currentUser
// //                                   .uid) // Assuming userUid is the user's UID
// //                               ? Text('Admin')
// //                               : Text('Member'),
// //                         );
// //                       },
// //                     ),
// //                   ),
// //                   error: (error, StackTrace) =>
// //                       ErrorText(error: error.toString()),
// //                   loading: () => const Loader(),
// //                 ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// /*import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gonomad/core/community/constants/error.dart';
// import 'package:gonomad/core/community/constants/loader.dart';
// import 'package:gonomad/core/community/controllers/community_controller..dart';
// import 'package:gonomad/core/community/screens/community_Profile_screen.dart';
// import 'package:gonomad/core/community/screens/create_community_screen.dart';
// import 'package:gonomad/core/community/screens/search_delegates.dart';
// import 'package:gonomad/models/community.dart';

// class CommunityList extends ConsumerWidget {
//   const CommunityList({Key? key});

//   void navigateToCreateCommunity(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => CreateCommunityScreen()),
//     );
//   }

//   void navigateToCommunity(BuildContext context, Community community) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => CommunityScreen(name: community.name),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//     User currentUser = _auth.currentUser!;
//     return SafeArea(
//       child: Drawer(
//         child: Column(
//           children: [
//             InkWell(
//               onTap: () {
//                 showSearch(
//                   context: context,
//                   delegate: SearchCommunityDelegate(ref: ref),
//                 );
//               },
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 decoration: BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(color: Colors.grey.shade400),
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.search),
//                     SizedBox(width: 10),
//                     Text(
//                       "Search Community",
//                       style: TextStyle(fontSize: 16, color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             ListTile(
//               title: Text('Create a Community '),
//               leading: Icon(Icons.add),
//               onTap: () => navigateToCreateCommunity(context),
//             ),
//             ref.watch(userCommunitiesProvider).when(
//                   data: (communities) => Expanded(
//                     child: ListView.builder(
//                       itemCount: communities.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         final community = communities[index];
//                         return ListTile(
//                           leading: CircleAvatar(
//                             backgroundImage: NetworkImage(community.avator),
//                           ),
//                           title: Text('/ts/${community.name}'),
//                           onTap: () {
//                             navigateToCommunity(context, community);
//                           },
//                           subtitle: community.mods.contains(currentUser
//                                   .uid) // Assuming userUid is the user's UID
//                               ? Text('Admin')
//                               : Text('Member'),
//                         );
//                       },
//                     ),
//                   ),
//                   error: (error, StackTrace) =>
//                       ErrorText(error: error.toString()),
//                   loading: () => const Loader(),
//                 ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// */

// /*import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gonomad/core/community/constants/error.dart';
// import 'package:gonomad/core/community/constants/loader.dart';
// import 'package:gonomad/core/community/controllers/community_controller..dart';
// import 'package:gonomad/core/community/screens/community_Profile_screen.dart';
// import 'package:gonomad/core/community/screens/create_community_screen.dart';
// import 'package:gonomad/core/community/screens/search_delegates.dart';
// import 'package:gonomad/models/community.dart';

// class CommunityList extends ConsumerWidget {
//   const CommunityList({Key? key});

//   void navigateToCreateCommunity(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const CreateCommunityScreen()),
//     );
//   }

//   void navigateToCommunity(BuildContext context, Community community) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => CommunityScreen(name: community.name),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//     User currentUser = _auth.currentUser!;

//     return Drawer(
//       child: Column(
//         children: [
//          UserAccountsDrawerHeader(
//             accountName: Text(
//               currentUser?.displayName ?? "Anonymous",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             accountEmail: Center(child: Text(currentUser?.email ?? "")),
//             currentAccountPicture:  currentUser?.photoURL != null
//   ? Image(
//       image: CachedNetworkImageProvider(currentUser!.photoURL!),
//       loadingBuilder: (context, child, loadingProgress) {
//         if (loadingProgress == null) {
//           return child;
//         }
//         return const CircularProgressIndicator();
//       },
//       errorBuilder: (context, error, stackTrace) {
//         return const Icon(Icons.error);
//       },
//     )
//   : const AssetImage('assets/default_profile_image.jpg'),
//           ),

//           InkWell(
//             onTap: () {
//               showSearch(
//                 context: context,
//                 delegate: SearchCommunityDelegate(ref: ref),
//               );
//             },
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               decoration: BoxDecoration(
//                 border: Border(
//                   bottom: BorderSide(color: Colors.grey.shade400),
//                 ),
//               ),
//               child: const Row(
//                 children: [
//                   Icon(Icons.search),
//                   SizedBox(width: 10),
//                   Text(
//                     "Search Community",
//                     style: TextStyle(fontSize: 16, color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           ListTile(
//             title: const Text('Create a Community '),
//             leading: const Icon(Icons.add),
//             onTap: () => navigateToCreateCommunity(context),
//           ),
//           ref.watch(userCommunitiesProvider).when(
//                 data: (communities) => Expanded(
//                   child: ListView.builder(
//                     itemCount: communities.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       final community = communities[index];
//                       return ListTile(
//                         leading: CircleAvatar(
//                           backgroundImage: NetworkImage(community.avator),
//                         ),
//                         title: Text('/ts/${community.name}'),
//                         onTap: () {
//                           navigateToCommunity(context, community);
//                         },
//                         subtitle: community.mods.contains(currentUser
//                                 .uid) // Assuming userUid is the user's UID
//                             ? const Text('Admin')
//                             : const Text('Member'),
//                       );
//                     },
//                   ),
//                 ),
//                 error: (error, StackTrace) =>
//                     ErrorText(error: error.toString()),
//                 loading: () => const Loader(),
//               ),
//         ],
//       ),
//     );
//   }
// }*/

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gonomad/core/community/constants/error.dart';
// import 'package:gonomad/core/community/constants/loader.dart';
// import 'package:gonomad/core/community/controllers/community_controller..dart';
// import 'package:gonomad/core/community/screens/community_Profile_screen.dart';
// import 'package:gonomad/core/community/screens/create_community_screen.dart';
// import 'package:gonomad/core/community/screens/search_delegates.dart';
// import 'package:gonomad/models/community_model.dart';

// class CommunityList extends ConsumerWidget {
//   const CommunityList({Key? key});

//   void navigateToCreateCommunity(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const CreateCommunityScreen()),
//     );
//   }

//   void navigateToCommunity(BuildContext context, Community community) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => CommunityScreen(name: community.name),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//     final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//     var userData = {};
//     User currentUser = _auth.currentUser!;

//     {
//       void get() async {
//         var userSnap = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(currentUser.uid)
//             .get();
//         userData = userSnap.data()!;
//       }

//       return Drawer(
//         child: Column(
//           children: [
//             UserAccountsDrawerHeader(
//               decoration: BoxDecoration(color: Color.fromARGB(255, 16, 48, 75)),
//               accountName: Padding(
//                 padding: const EdgeInsets.only(top: 15.0),
//                 child: Text(
//                   userData['username'] ?? "Anonymous",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//               accountEmail: Text(currentUser.email ?? ""),
//               // currentAccountPicture: CircleAvatar(
//               //   backgroundColor: Colors.grey,
//               //   backgroundImage:
//               //       CachedNetworkImageProvider(userData['photoUrl']),
//               //   radius: 50,
//               // ),
//             ),
//             InkWell(
//               onTap: () {
//                 showSearch(
//                   context: context,
//                   delegate: SearchCommunityDelegate(ref: ref),
//                 );
//               },
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 decoration: BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(color: Colors.grey.shade400),
//                   ),
//                 ),
//                 child: const Row(
//                   children: [
//                     Icon(Icons.search),
//                     SizedBox(width: 10),
//                     Text(
//                       "Search Community",
//                       style: TextStyle(fontSize: 16, color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             ListTile(
//               title: const Text('Create a Community '),
//               leading: const Icon(Icons.add),
//               onTap: () => navigateToCreateCommunity(context),
//             ),
//             ref.watch(userCommunitiesProvider).when(
//                   data: (communities) => Expanded(
//                     child: ListView.builder(
//                       itemCount: communities.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         final community = communities[index];
//                         return ListTile(
//                           leading: CircleAvatar(
//                             backgroundImage: NetworkImage(community.avator),
//                           ),
//                           title: Text('/ts/${community.name}'),
//                           onTap: () {
//                             navigateToCommunity(context, community);
//                           },
//                           subtitle: community.mods.contains(currentUser.uid)
//                               ? const Text('Admin')
//                               : const Text('Member'),
//                         );
//                       },
//                     ),
//                   ),
//                   error: (error, StackTrace) =>
//                       ErrorText(error: error.toString()),
//                   loading: () => const Loader(),
//                 ),
//           ],
//         ),
//       );
//     }
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gonomad/core/community/constants/error.dart';
import 'package:gonomad/core/community/constants/loader.dart';
import 'package:gonomad/core/community/controllers/community_controller..dart';
import 'package:gonomad/core/community/screens/community_Profile_screen.dart';
import 'package:gonomad/core/community/screens/create_community_screen.dart';
import 'package:gonomad/core/community/screens/search_delegates.dart';
import 'package:gonomad/models/community_model.dart';

class CommunityList extends ConsumerWidget {
  const CommunityList({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    User currentUser = _auth.currentUser!;

    return FutureBuilder<DocumentSnapshot>(
      future: _firestore.collection('users').doc(currentUser.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child:
                CircularProgressIndicator(), // or any other loading indicator
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: Text('No data found'),
          );
        }

        var userData = snapshot.data!.data() as Map<String, dynamic>;

        return Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 16, 48, 75)),
                accountName: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    userData['username'] ?? "Anonymous",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                accountEmail: Text(currentUser.email ?? ""),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      CachedNetworkImageProvider(userData['photoUrl']),
                  radius: 50,
                ),
              ),
              InkWell(
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: SearchCommunityDelegate(ref: ref),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade400),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 10),
                      Text(
                        "Search Community",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                title: const Text('Create a Community '),
                leading: const Icon(Icons.add),
                onTap: () => navigateToCreateCommunity(context),
              ),
              ref.watch(userCommunitiesProvider).when(
                    data: (communities) => Expanded(
                      child: ListView.builder(
                        itemCount: communities.length,
                        itemBuilder: (BuildContext context, int index) {
                          final community = communities[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(community.avator),
                            ),
                            title: Text('/ts/${community.name}'),
                            onTap: () {
                              navigateToCommunity(context, community);
                            },
                            subtitle: community.mods.contains(currentUser.uid)
                                ? const Text('Admin')
                                : const Text('Member'),
                          );
                        },
                      ),
                    ),
                    error: (error, StackTrace) =>
                        ErrorText(error: error.toString()),
                    loading: () => const Loader(),
                  ),
            ],
          ),
        );
      },
    );
  }

  void navigateToCreateCommunity(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateCommunityScreen()),
    );
  }

  void navigateToCommunity(BuildContext context, Community community) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommunityScreen(name: community.name),
      ),
    );
  }
}
