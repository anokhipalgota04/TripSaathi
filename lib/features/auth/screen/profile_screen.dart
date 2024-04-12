// // ignore_for_file: public_member_api_docs, sort_constructors_first
// // import 'dart:ui';

// // import 'package:cached_network_image/cached_network_image.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:gonomad/features/auth/screen/login_option_screen.dart';
// // import 'package:gonomad/features/followers_list.dart';
// // import 'package:gonomad/features/following_list.dart';
// // import 'package:gonomad/resources/auth_methods.dart';
// // import 'package:gonomad/resources/firestore_methods.dart';
// // import 'package:gonomad/utils/utils.dart';
// // import 'package:gonomad/widgets/follow_button.dart';

// // class ProfileScreen extends StatefulWidget {
// //   final String uid;
// //   const ProfileScreen({Key? key, required this.uid}) : super(key: key);

// //   @override
// //   State<ProfileScreen> createState() => _ProfileScreenState();
// // }

// // class _ProfileScreenState extends State<ProfileScreen> {
// //   var userData = {};
// //   var postLen = 0;
// //   int followers = 0;
// //   int following = 0;
// //   bool isFollowing = false;
// //   bool isLoading = false;

// //   @override
// //   void initState() {
// //     super.initState();
// //     getData();
// //   }

// //   getData() async {
// //     setState(() {
// //       isLoading = true;
// //     });
// //     try {
// //       var userSnap = await FirebaseFirestore.instance
// //           .collection('users')
// //           .doc(widget.uid)
// //           .get();

// //       var postSnap = await FirebaseFirestore.instance
// //           .collection('posts')
// //           .where('uid', isEqualTo: widget.uid)
// //           .get();

// //       postLen = postSnap.docs.length;
// //       userData = userSnap.data()!;
// //       followers = userSnap.data()!['followers'].length;
// //       following = userSnap.data()!['following'].length;
// //       isFollowing = userSnap
// //           .data()!['followers']
// //           .contains(FirebaseAuth.instance.currentUser!.uid);
// //       setState(() {});
// //     } catch (e) {
// //       showSnackBar(e.toString(), context);
// //     }
// //     setState(() {
// //       isLoading = false;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return isLoading
// //         ? const Center(
// //             child: CircularProgressIndicator(),
// //           )
// //         : Scaffold(
// //             appBar: AppBar(
// //               backgroundColor: Colors.transparent,
// //               title: Text(
// //                 userData['username'],
// //               ),
// //               flexibleSpace: ClipRect(
// //                 child: BackdropFilter(
// //                   filter: ImageFilter.blur(
// //                     sigmaX: 9,
// //                     sigmaY: 9,
// //                   ),
// //                   child: Container(
// //                     color: Colors.white.withOpacity(0.7),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             body: ListView(
// //               children: [
// //                 Padding(
// //                   padding: const EdgeInsets.all(16),
// //                   child: Column(
// //                     children: [
// //                       Row(
// //                         children: [
// //                           CircleAvatar(
// //                             backgroundColor: Colors.grey,
// //                             backgroundImage: CachedNetworkImageProvider(
// //                                 userData['photoUrl']),
// //                             radius: 50,
// //                           ),
// //                           Expanded(
// //                             flex: 1,
// //                             child: Column(
// //                               children: [
// //                                 Row(
// //                                   mainAxisSize: MainAxisSize.max,
// //                                   mainAxisAlignment:
// //                                       MainAxisAlignment.spaceEvenly,
// //                                   children: [
// //                                     buildStatColumn(postLen, "posts"),
// //                                     GestureDetector(
// //                                       child: buildStatColumn(
// //                                           followers, "followers"),
// //                                       onTap: () => Navigator.push(
// //                                           context,
// //                                           MaterialPageRoute(
// //                                               builder: (context) =>
// //                                                   FollowerCount(
// //                                                       uid: widget.uid))),
// //                                     ),
// //                                     GestureDetector(
// //                                       child: buildStatColumn(
// //                                           following, "following"),
// //                                       onTap: () => Navigator.push(
// //                                           context,
// //                                           MaterialPageRoute(
// //                                               builder: (context) =>
// //                                                   FollowingCount(
// //                                                     uid: widget.uid,
// //                                                   ))),
// //                                     )
// //                                   ],
// //                                 ),
// //                                 Row(
// //                                   mainAxisAlignment:
// //                                       MainAxisAlignment.spaceEvenly,
// //                                   children: [
// //                                     FirebaseAuth.instance.currentUser!.uid ==
// //                                             widget.uid
// //                                         ? FollowButton(
// //                                             text: 'Sign Out',
// //                                             backgroundColor: Colors.white,
// //                                             borderColor: Colors.grey,
// //                                             textColor: Colors.black,
// //                                             function: () async {
// //                                               await AuthMethods().signOut();
// //                                               Navigator.pushReplacement(
// //                                                   context,
// //                                                   MaterialPageRoute(
// //                                                       builder: (context) =>
// //                                                           BackgroundVideo()));
// //                                             },
// //                                           )
// //                                         : isFollowing
// //                                             ? FollowButton(
// //                                                 text: 'Disconnect',
// //                                                 backgroundColor: Colors.grey,
// //                                                 borderColor: Colors.black,
// //                                                 textColor: Colors.black,
// //                                                 function: () async {
// //                                                   await FirestoreMethods()
// //                                                       .followUser(
// //                                                     FirebaseAuth.instance
// //                                                         .currentUser!.uid,
// //                                                     userData['uid'],
// //                                                   );
// //                                                   setState(() {
// //                                                     isFollowing = false;
// //                                                     followers--;
// //                                                   });
// //                                                 },
// //                                               )
// //                                             : FollowButton(
// //                                                 text: 'Connect',
// //                                                 backgroundColor: Colors.blue,
// //                                                 borderColor: Colors.grey,
// //                                                 textColor: Colors.white,
// //                                                 function: () async {
// //                                                   await FirestoreMethods()
// //                                                       .followUser(
// //                                                     FirebaseAuth.instance
// //                                                         .currentUser!.uid,
// //                                                     userData['uid'],
// //                                                   );

// //                                                   setState(() {
// //                                                     isFollowing = true;
// //                                                     followers++;
// //                                                   });
// //                                                 },
// //                                               ),
// //                                   ],
// //                                 )
// //                               ],
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       Container(
// //                         alignment: Alignment.centerLeft,
// //                         padding: const EdgeInsets.only(top: 15.0),
// //                         child: Text(
// //                           userData['username'],
// //                           style: const TextStyle(
// //                             fontWeight: FontWeight.bold,
// //                             fontSize: 18,
// //                           ),
// //                         ),
// //                       ),
// //                       Container(
// //                         alignment: Alignment.centerLeft,
// //                         padding: const EdgeInsets.only(top: 1.0),
// //                         child: Text(
// //                           userData['bio'],
// //                         ),
// //                       )
// //                     ],
// //                   ),
// //                 ),
// //                 const Divider(),

// //                 FutureBuilder(
// //                   future: FirebaseFirestore.instance
// //                       .collection('posts')
// //                       .where('uid', isEqualTo: widget.uid)
// //                       .get(),
// //                   builder: (context, snapshot) {
// //                     if (snapshot.connectionState == ConnectionState.waiting) {
// //                       return const Center(
// //                         child: CircularProgressIndicator(),
// //                       );
// //                     }
// //                     return GridView.builder(
// //                       shrinkWrap: true,
// //                       itemCount: (snapshot.data! as dynamic).docs.length,
// //                       gridDelegate:
// //                           const SliverGridDelegateWithFixedCrossAxisCount(
// //                               crossAxisCount: 3,
// //                               crossAxisSpacing: 5,
// //                               mainAxisSpacing: 1.5,
// //                               childAspectRatio: 1),
// //                       itemBuilder: (context, index) {
// //                         DocumentSnapshot snap =
// //                             (snapshot.data! as dynamic).docs[index];

// //                         return GestureDetector(
// //                           onTap: () {
// //                             Navigator.push(
// //                               context,
// //                               MaterialPageRoute(
// //                                 builder: (context) =>
// //                                     FullScreenImage(url: snap['postUrl']),
// //                               ),
// //                             );
// //                           },
// //                           child: CachedNetworkImage(
// //                             imageUrl: snap['postUrl'],
// //                             fit: BoxFit.cover,
// //                           ),
// //                         );
// //                       },
// //                     );
// //                   },
// //                 )
// //               ],
// //             ),
// //           );
// //   }

// //   Column buildStatColumn(
// //     int num,
// //     String label,
// //   ) {
// //     return Column(
// //       mainAxisSize: MainAxisSize.min,
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       children: [
// //         Text(num.toString(),
// //             style: const TextStyle(
// //               fontSize: 20,
// //               fontWeight: FontWeight.bold,
// //             )),
// //         Container(
// //           margin: const EdgeInsets.only(top: 3),
// //           child: Text(label,
// //               style: const TextStyle(
// //                 fontSize: 15,
// //                 fontWeight: FontWeight.w400,
// //                 color: Colors.grey,
// //               )),
// //         ),
// //       ],
// //     );
// //   }
// // }

// // class FullScreenImage extends StatelessWidget {
// //   final String url;

// //   const FullScreenImage({Key? key, required this.url}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         elevation: 0, // Remove appbar shadow
// //       ),
// //       backgroundColor:
// //           Colors.grey.withOpacity(0.2), // Transparent light grey background
// //       body: Center(
// //         child: CachedNetworkImage(
// //           imageUrl: url,
// //           placeholder: (context, url) =>
// //               const CircularProgressIndicator(), // Placeholder while loading
// //           errorWidget: (context, url, error) =>
// //               const Icon(Icons.error), // Error widget if image fails to load
// //           fit: BoxFit.contain, // Fit image to the screen
// //         ),
// //       ),
// //     );
// //   }
// // }

// /*import 'dart:ui';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:gonomad/features/auth/screen/login_option_screen.dart';
// import 'package:gonomad/features/followers_list.dart';
// import 'package:gonomad/features/following_list.dart';
// import 'package:gonomad/resources/auth_methods.dart';
// import 'package:gonomad/resources/firestore_methods.dart';
// import 'package:gonomad/utils/utils.dart';
// import 'package:gonomad/widgets/follow_button.dart';

// class ProfileScreen extends StatefulWidget {
//   final String uid;
//   const ProfileScreen({Key? key, required this.uid}) : super(key: key);

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   var userData = {};
//   var postLen = 0;
//   int followers = 0;
//   int following = 0;
//   bool isFollowing = false;
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }

//   getData() async {
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       var userSnap = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(widget.uid)
//           .get();

//       var postSnap = await FirebaseFirestore.instance
//           .collection('posts')
//           .where('uid', isEqualTo: widget.uid)
//           .get();

//       postLen = postSnap.docs.length;
//       userData = userSnap.data()!;
//       followers = userSnap.data()!['followers'].length;
//       following = userSnap.data()!['following'].length;
//       isFollowing = userSnap
//           .data()!['followers']
//           .contains(FirebaseAuth.instance.currentUser!.uid);
//       setState(() {});
//     } catch (e) {
//       showSnackBar(e.toString(), context);
//     }
//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return isLoading
//         ? const Center(
//             child: CircularProgressIndicator(),
//           )
//         : DefaultTabController(
//             length: 2,
//             child: Scaffold(
//               appBar: AppBar(
//                 backgroundColor: Colors.transparent,
//                 title: Text(
//                   userData['username'],
//                 ),
//                 flexibleSpace: ClipRect(
//                   child: BackdropFilter(
//                     filter: ImageFilter.blur(
//                       sigmaX: 9,
//                       sigmaY: 9,
//                     ),
//                     child: Container(
//                       color: Colors.white.withOpacity(0.7),
//                     ),
//                   ),
//                 ),
//                 bottom: TabBar(
//                   tabs: [
//                     Tab(text: 'Post'),
//                     Tab(text: 'Community'),
//                   ],
//                 ),
//               ),
//               body: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             CircleAvatar(
//                               backgroundColor: Colors.grey,
//                               backgroundImage: CachedNetworkImageProvider(
//                                   userData['photoUrl']),
//                               radius: 50,
//                             ),
//                             Expanded(
//                               flex: 1,
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       buildStatColumn(postLen, "posts"),
//                                       GestureDetector(
//                                         child: buildStatColumn(
//                                             followers, "followers"),
//                                         onTap: () => Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     FollowerCount(
//                                                         uid: widget.uid))),
//                                       ),
//                                       GestureDetector(
//                                         child: buildStatColumn(
//                                             following, "following"),
//                                         onTap: () => Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     FollowingCount(
//                                                       uid: widget.uid,
//                                                     ))),
//                                       )
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       FirebaseAuth.instance.currentUser!.uid ==
//                                               widget.uid
//                                           ? FollowButton(
//                                               text: 'Sign Out',
//                                               backgroundColor: Colors.white,
//                                               borderColor: Colors.grey,
//                                               textColor: Colors.black,
//                                               function: () async {
//                                                 await AuthMethods().signOut();
//                                                 Navigator.pushReplacement(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                         builder: (context) =>
//                                                             BackgroundVideo()));
//                                               },
//                                             )
//                                           : isFollowing
//                                               ? FollowButton(
//                                                   text: 'Disconnect',
//                                                   backgroundColor: Colors.grey,
//                                                   borderColor: Colors.black,
//                                                   textColor: Colors.black,
//                                                   function: () async {
//                                                     await FirestoreMethods()
//                                                         .followUser(
//                                                       FirebaseAuth.instance
//                                                           .currentUser!.uid,
//                                                       userData['uid'],
//                                                     );
//                                                     setState(() {
//                                                       isFollowing = false;
//                                                       followers--;
//                                                     });
//                                                   },
//                                                 )
//                                               : FollowButton(
//                                                   text: 'Connect',
//                                                   backgroundColor: Colors.blue,
//                                                   borderColor: Colors.grey,
//                                                   textColor: Colors.white,
//                                                   function: () async {
//                                                     await FirestoreMethods()
//                                                         .followUser(
//                                                       FirebaseAuth.instance
//                                                           .currentUser!.uid,
//                                                       userData['uid'],
//                                                     );

//                                                     setState(() {
//                                                       isFollowing = true;
//                                                       followers++;
//                                                     });
//                                                   },
//                                                 ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           padding: const EdgeInsets.only(top: 15.0),
//                           child: Text(
//                             userData['username'],
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           padding: const EdgeInsets.only(top: 1.0),
//                           child: Text(
//                             userData['bio'],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Divider(),

//                   Expanded(
//                     child: TabBarView(
//                       children: [
//                         buildPostTab(),
//                         buildCommunityTab(),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//   }

//   Widget buildPostTab() {
//     return FutureBuilder(
//       future: FirebaseFirestore.instance
//           .collection('posts')
//           .where('uid', isEqualTo: widget.uid)
//           .get(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         return GridView.builder(
//           shrinkWrap: true,
//           itemCount: (snapshot.data! as dynamic).docs.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               crossAxisSpacing: 5,
//               mainAxisSpacing: 1.5,
//               childAspectRatio: 1),
//           itemBuilder: (context, index) {
//             DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];

//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => FullScreenImage(url: snap['postUrl']),
//                   ),
//                 );
//               },
//               child: CachedNetworkImage(
//                 imageUrl: snap['postUrl'],
//                 fit: BoxFit.cover,
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   Widget buildCommunityTab() {
//     return const Center(
//       child: Text(
//         'Community posts here',
//         style: TextStyle(fontSize: 20),
//       ),
//     );
//   }

//   Column buildStatColumn(int num, String label) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(num.toString(),
//             style: const TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             )),
//         Container(
//           margin: const EdgeInsets.only(top: 3),
//           child: Text(label,
//               style: const TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w400,
//                 color: Colors.grey,
//               )),
//         ),
//       ],
//     );
//   }
// }

// class FullScreenImage extends StatelessWidget {
//   final String url;

//   const FullScreenImage({Key? key, required this.url}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0, // Remove appbar shadow
//       ),
//       backgroundColor:
//           Colors.grey.withOpacity(0.2), // Transparent light grey background
//       body: Center(
//         child: CachedNetworkImage(
//           imageUrl: url,
//           placeholder: (context, url) =>
//               const CircularProgressIndicator(), // Placeholder while loading
//           errorWidget: (context, url, error) =>
//               const Icon(Icons.error), // Error widget if image fails to load
//           fit: BoxFit.contain, // Fit image to the screen
//         ),
//       ),
//     );
//   }
// }
// */

// // import 'dart:ui';

// // import 'package:cached_network_image/cached_network_image.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:gonomad/features/auth/screen/login_option_screen.dart';
// // import 'package:gonomad/features/followers_list.dart';
// // import 'package:gonomad/features/following_list.dart';
// // import 'package:gonomad/resources/auth_methods.dart';
// // import 'package:gonomad/resources/firestore_methods.dart';
// // import 'package:gonomad/utils/utils.dart';
// // import 'package:gonomad/widgets/follow_button.dart';

// // class ProfileScreen extends StatefulWidget {
// //   final String uid;
// //   const ProfileScreen({Key? key, required this.uid}) : super(key: key);

// //   @override
// //   State<ProfileScreen> createState() => _ProfileScreenState();
// // }

// // class _ProfileScreenState extends State<ProfileScreen> {
// //   var userData = {};
// //   var postLen = 0;
// //   int followers = 0;
// //   int following = 0;
// //   bool isFollowing = false;
// //   bool isLoading = false;

// //   @override
// //   void initState() {
// //     super.initState();
// //     getData();
// //   }

// //   getData() async {
// //     setState(() {
// //       isLoading = true;
// //     });
// //     try {
// //       var userSnap = await FirebaseFirestore.instance
// //           .collection('users')
// //           .doc(widget.uid)
// //           .get();

// //       var postSnap = await FirebaseFirestore.instance
// //           .collection('posts')
// //           .where('uid', isEqualTo: widget.uid)
// //           .get();

// //       postLen = postSnap.docs.length;
// //       userData = userSnap.data()!;
// //       followers = userSnap.data()!['followers'].length;
// //       following = userSnap.data()!['following'].length;
// //       isFollowing = userSnap
// //           .data()!['followers']
// //           .contains(FirebaseAuth.instance.currentUser!.uid);
// //       setState(() {});
// //     } catch (e) {
// //       showSnackBar(e.toString(), context);
// //     }
// //     setState(() {
// //       isLoading = false;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return isLoading
// //         ? const Center(
// //             child: CircularProgressIndicator(),
// //           )
// //         : Scaffold(
// //             appBar: AppBar(
// //               backgroundColor: Colors.transparent,
// //               title: Text(
// //                 userData['username'],
// //               ),
// //               flexibleSpace: ClipRect(
// //                 child: BackdropFilter(
// //                   filter: ImageFilter.blur(
// //                     sigmaX: 9,
// //                     sigmaY: 9,
// //                   ),
// //                   child: Container(
// //                     color: Colors.white.withOpacity(0.7),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             body: Column(
// //               children: [
// //                 Expanded(
// //                   child: ListView(
// //                     children: [
// //                       Padding(
// //                         padding: const EdgeInsets.all(16),
// //                         child: Column(
// //                           children: [
// //                             Row(
// //                               children: [
// //                                 CircleAvatar(
// //                                   backgroundColor: Colors.grey,
// //                                   backgroundImage: CachedNetworkImageProvider(
// //                                       userData['photoUrl']),
// //                                   radius: 50,
// //                                 ),
// //                                 Expanded(
// //                                   flex: 1,
// //                                   child: Column(
// //                                     children: [
// //                                       Row(
// //                                         mainAxisSize: MainAxisSize.max,
// //                                         mainAxisAlignment:
// //                                             MainAxisAlignment.spaceEvenly,
// //                                         children: [
// //                                           buildStatColumn(postLen, "posts"),
// //                                           GestureDetector(
// //                                             child: buildStatColumn(
// //                                                 followers, "followers"),
// //                                             onTap: () => Navigator.push(
// //                                                 context,
// //                                                 MaterialPageRoute(
// //                                                     builder: (context) =>
// //                                                         FollowerCount(
// //                                                             uid: widget.uid))),
// //                                           ),
// //                                           GestureDetector(
// //                                             child: buildStatColumn(
// //                                                 following, "following"),
// //                                             onTap: () => Navigator.push(
// //                                                 context,
// //                                                 MaterialPageRoute(
// //                                                     builder: (context) =>
// //                                                         FollowingCount(
// //                                                           uid: widget.uid,
// //                                                         ))),
// //                                           )
// //                                         ],
// //                                       ),
// //                                       Row(
// //                                         mainAxisAlignment:
// //                                             MainAxisAlignment.spaceEvenly,
// //                                         children: [
// //                                           FirebaseAuth.instance.currentUser!
// //                                                       .uid ==
// //                                                   widget.uid
// //                                               ? FollowButton(
// //                                                   text: 'Sign Out',
// //                                                   backgroundColor: Colors.white,
// //                                                   borderColor: Colors.grey,
// //                                                   textColor: Colors.black,
// //                                                   function: () async {
// //                                                     await AuthMethods()
// //                                                         .signOut();
// //                                                     Navigator.pushReplacement(
// //                                                         context,
// //                                                         MaterialPageRoute(
// //                                                             builder: (context) =>
// //                                                                 BackgroundVideo()));
// //                                                   },
// //                                                 )
// //                                               : isFollowing
// //                                                   ? FollowButton(
// //                                                       text: 'Disconnect',
// //                                                       backgroundColor:
// //                                                           Colors.grey,
// //                                                       borderColor: Colors.black,
// //                                                       textColor: Colors.black,
// //                                                       function: () async {
// //                                                         await FirestoreMethods()
// //                                                             .followUser(
// //                                                           FirebaseAuth.instance
// //                                                               .currentUser!.uid,
// //                                                           userData['uid'],
// //                                                         );
// //                                                         setState(() {
// //                                                           isFollowing = false;
// //                                                           followers--;
// //                                                         });
// //                                                       },
// //                                                     )
// //                                                   : FollowButton(
// //                                                       text: 'Connect',
// //                                                       backgroundColor:
// //                                                           Colors.blue,
// //                                                       borderColor: Colors.grey,
// //                                                       textColor: Colors.white,
// //                                                       function: () async {
// //                                                         await FirestoreMethods()
// //                                                             .followUser(
// //                                                           FirebaseAuth.instance
// //                                                               .currentUser!.uid,
// //                                                           userData['uid'],
// //                                                         );

// //                                                         setState(() {
// //                                                           isFollowing = true;
// //                                                           followers++;
// //                                                         });
// //                                                       },
// //                                                     ),
// //                                         ],
// //                                       )
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                             Container(
// //                               alignment: Alignment.centerLeft,
// //                               padding: const EdgeInsets.only(top: 15.0),
// //                               child: Text(
// //                                 userData['username'],
// //                                 style: const TextStyle(
// //                                   fontWeight: FontWeight.bold,
// //                                   fontSize: 18,
// //                                 ),
// //                               ),
// //                             ),
// //                             Container(
// //                               alignment: Alignment.centerLeft,
// //                               padding: const EdgeInsets.only(top: 1.0),
// //                               child: Text(
// //                                 userData['bio'],
// //                               ),
// //                             )
// //                           ],
// //                         ),
// //                       ),
// //                       const Divider(),
// //                     ],
// //                   ),
// //                 ),
// //                 // TabBar and TabBarView below the Divider
// //                 Expanded(
// //                   child: DefaultTabController(
// //                     length: 2,
// //                     child: Column(
// //                       children: [
// //                         TabBar(
// //                           tabs: [
// //                             Tab(text: 'Post'),
// //                             Tab(text: 'Community'),
// //                           ],
// //                         ),
// //                         Expanded(
// //                           child: TabBarView(
// //                             children: [
// //                               buildPostTab(),
// //                               buildCommunityTab(),
// //                             ],
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           );
// //   }

// //   Widget buildPostTab() {
// //     return FutureBuilder(
// //       future: FirebaseFirestore.instance
// //           .collection('posts')
// //           .where('uid', isEqualTo: widget.uid)
// //           .get(),
// //       builder: (context, snapshot) {
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           return Center(
// //             child: CircularProgressIndicator(),
// //           );
// //         }
// //         return GridView.builder(
// //           shrinkWrap: true,
// //           itemCount: (snapshot.data! as dynamic).docs.length,
// //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //               crossAxisCount: 3,
// //               crossAxisSpacing: 5,
// //               mainAxisSpacing: 1.5,
// //               childAspectRatio: 1),
// //           itemBuilder: (context, index) {
// //             DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];

// //             return GestureDetector(
// //               onTap: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                     builder: (context) => FullScreenImage(url: snap['postUrl']),
// //                   ),
// //                 );
// //               },
// //               child: CachedNetworkImage(
// //                 imageUrl: snap['postUrl'],
// //                 fit: BoxFit.cover,
// //               ),
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }

// //   Widget buildCommunityTab() {
// //     return const Center(
// //       child: Text(
// //         'Community posts here',
// //         style: TextStyle(fontSize: 20),
// //       ),
// //     );
// //   }

// //   Column buildStatColumn(int num, String label) {
// //     return Column(
// //       mainAxisSize: MainAxisSize.min,
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       children: [
// //         Text(num.toString(),
// //             style: const TextStyle(
// //               fontSize: 20,
// //               fontWeight: FontWeight.bold,
// //             )),
// //         Container(
// //           margin: const EdgeInsets.only(top: 3),
// //           child: Text(label,
// //               style: const TextStyle(
// //                 fontSize: 15,
// //                 fontWeight: FontWeight.w400,
// //                 color: Colors.grey,
// //               )),
// //         ),
// //       ],
// //     );
// //   }
// // }

// // class FullScreenImage extends StatelessWidget {
// //   final String url;

// //   const FullScreenImage({Key? key, required this.url}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         elevation: 0, // Remove appbar shadow
// //       ),
// //       backgroundColor:
// //           Colors.grey.withOpacity(0.2), // Transparent light grey background
// //       body: Center(
// //         child: CachedNetworkImage(
// //           imageUrl: url,
// //           placeholder: (context, url) =>
// //               const CircularProgressIndicator(), // Placeholder while loading
// //           errorWidget: (context, url, error) =>
// //               const Icon(Icons.error), // Error widget if image fails to load
// //           fit: BoxFit.contain, // Fit image to the screen
// //         ),
// //       ),
// //     );
// //   }
// // }

// //
// /*import 'dart:ui';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gonomad/core/community%20post/controller/add_cpost_controller.dart';
// import 'package:gonomad/core/community%20post/screens/cpost_card.dart';
// import 'package:gonomad/core/community%20post/screens/edit_profile_screen.dart';
// import 'package:gonomad/core/community/constants/error.dart';
// import 'package:gonomad/core/community/constants/loader.dart';
// import 'package:gonomad/core/community/controllers/community_controller..dart';
// import 'package:gonomad/features/auth/screen/login_option_screen.dart';
// import 'package:gonomad/features/followers_list.dart';
// import 'package:gonomad/features/following_list.dart';
// import 'package:gonomad/models/community_model.dart';
// import 'package:gonomad/models/cpost_model.dart';
// import 'package:gonomad/resources/auth_methods.dart';
// import 'package:gonomad/resources/firestore_methods.dart';
// import 'package:gonomad/utils/utils.dart';
// import 'package:gonomad/widgets/follow_button.dart';

// import 'package:tuple/tuple.dart';

// class ProfileScreen extends StatefulWidget {
//   final String uid;
//   const ProfileScreen({Key? key, required this.uid}) : super(key: key);

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   var userData = {};
//   var postLen = 0;
//   int followers = 0;
//   int following = 0;
//   int score = 0;
//   bool isFollowing = false;
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }

//   getData() async {
//     if (!mounted) return; // Check if the widget is still mounted

//     setState(() {
//       isLoading = true;
//     });

//     try {
//       var userDocRef =
//           FirebaseFirestore.instance.collection('users').doc(widget.uid);

//       // Add a snapshot listener to the user document
//       userDocRef.snapshots().listen((userSnap) {
//         if (!mounted) return; // Check if the widget is still mounted
//         if (userSnap.exists) {
//           setState(() {
//             // Update user data
//             userData = userSnap.data()!;
//             followers = userData['followers'].length;
//             following = userData['following'].length;
//             score = userData['score'];
//             isFollowing = userData['followers'].contains(
//               FirebaseAuth.instance.currentUser!.uid,
//             );
//           });
//         }
//       });

//       var postSnap = await FirebaseFirestore.instance
//           .collection('posts')
//           .where('uid', isEqualTo: widget.uid)
//           .get();

//       if (!mounted) return; // Check if the widget is still mounted

//       setState(() {
//         postLen = postSnap.docs.length;
//       });
//     } catch (e) {
//       showSnackBar(e.toString(), context);
//     }

//     if (mounted) {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return isLoading
//         ? const Center(
//             child: CircularProgressIndicator(),
//           )
//         : Scaffold(
//             appBar: AppBar(
//               backgroundColor: Colors.transparent,
//               title: Text('Profile '
//                   // userData['username'],
//                   ),
//               centerTitle: true,
//               flexibleSpace: ClipRect(
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(
//                     sigmaX: 9,
//                     sigmaY: 9,
//                   ),
//                   child: Container(
//                     color: Colors.white.withOpacity(0.7),
//                   ),
//                 ),
//               ),
//             ),
//             body: Column(
//               children: [
//                 ListView(
//                   shrinkWrap: true,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               CircleAvatar(
//                                 backgroundColor: Colors.grey,
//                                 backgroundImage: CachedNetworkImageProvider(
//                                     userData['photoUrl']),
//                                 radius: 50,
//                               ),
//                               Expanded(
//                                 flex: 1,
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         buildStatColumn(postLen, "posts"),
//                                         GestureDetector(
//                                           child: buildStatColumn(
//                                               followers, "followers"),
//                                           onTap: () => Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       FollowerCount(
//                                                           uid: widget.uid))),
//                                         ),
//                                         GestureDetector(
//                                           child: buildStatColumn(
//                                               following, "following"),
//                                           onTap: () => Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       FollowingCount(
//                                                         uid: widget.uid,
//                                                       ))),
//                                         )
//                                       ],
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         FirebaseAuth.instance.currentUser!
//                                                     .uid ==
//                                                 widget.uid
//                                             ? FollowButton(
//                                                 text: 'Sign Out',
//                                                 backgroundColor: Colors.white,
//                                                 borderColor: Colors.grey,
//                                                 textColor: Colors.black,
//                                                 function: () async {
//                                                   await AuthMethods().signOut();
//                                                   Navigator.pushReplacement(
//                                                       context,
//                                                       MaterialPageRoute(
//                                                           builder: (context) =>
//                                                               BackgroundVideo()));
//                                                 },
//                                               )
//                                             : isFollowing
//                                                 ? FollowButton(
//                                                     text: 'Disconnect',
//                                                     backgroundColor:
//                                                         Colors.grey,
//                                                     borderColor: Colors.black,
//                                                     textColor: Colors.black,
//                                                     function: () async {
//                                                       await FirestoreMethods()
//                                                           .followUser(
//                                                         FirebaseAuth.instance
//                                                             .currentUser!.uid,
//                                                         userData['uid'],
//                                                       );
//                                                       setState(() {
//                                                         isFollowing = false;
//                                                         followers--;
//                                                       });
//                                                     },
//                                                   )
//                                                 : FollowButton(
//                                                     text: 'Connect',
//                                                     backgroundColor:
//                                                         Colors.blue,
//                                                     borderColor: Colors.grey,
//                                                     textColor: Colors.white,
//                                                     function: () async {
//                                                       await FirestoreMethods()
//                                                           .followUser(
//                                                         FirebaseAuth.instance
//                                                             .currentUser!.uid,
//                                                         userData['uid'],
//                                                       );

//                                                       setState(() {
//                                                         isFollowing = true;
//                                                         followers++;
//                                                       });
//                                                     },
//                                                   ),
//                                       ],
//                                     ),
//                                     FirebaseAuth.instance.currentUser!.uid ==
//                                             widget.uid
//                                         ? Container(
//                                             padding:
//                                                 const EdgeInsets.only(top: 2),
//                                             child: TextButton(
//                                               onPressed: () {
//                                                 // Navigate to the EditProfileScreen when the button is pressed
//                                                 Navigator.push(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           EditProfileScreen(
//                                                               uid: widget.uid),
//                                                     ));
//                                               },
//                                               child: Container(
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.blue,
//                                                   border: Border.all(
//                                                     color: Colors.grey,
//                                                   ),
//                                                   borderRadius:
//                                                       BorderRadius.circular(5),
//                                                 ),
//                                                 alignment: Alignment.center,
//                                                 width: 250,
//                                                 height: 42,
//                                                 child: Text(
//                                                   'Edit Profile',
//                                                   style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           )
//                                         : SizedBox(height: 1)
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Container(
//                             alignment: Alignment.centerLeft,
//                             padding: const EdgeInsets.only(top: 15.0),
//                             child: Text(
//                               userData['username'],
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             alignment: Alignment.centerLeft,
//                             padding: const EdgeInsets.only(top: 1.0),
//                             child: Text(
//                               userData['bio'],
//                             ),
//                           ),
//                           Container(
//                             alignment: Alignment.centerLeft,
//                             padding: const EdgeInsets.only(top: 1.0),
//                             child: Text('score = $score'),
//                           ),
//                         ],
//                       ),
//                     ),
//                     //const Divider(),
//                     //Text('Anokhi'),
//                   ],
//                 ),
//                 Expanded(
//                   child: DefaultTabController(
//                     length: 2,
//                     child: Column(
//                       children: [
//                         TabBar(
//                           tabs: [
//                             Tab(text: 'Post'),
//                             Tab(text: 'Community'),
//                           ],
//                         ),
//                         Expanded(
//                           child: TabBarView(
//                             children: [
//                               buildPostTab(),
//                               Communitypostscreen(
//                                 uid: userData['uid'],
//                               )
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//   }

//   Widget buildPostTab() {
//     return FutureBuilder(
//       future: FirebaseFirestore.instance
//           .collection('posts')
//           .where('uid', isEqualTo: widget.uid)
//           .get(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         return GridView.builder(
//           shrinkWrap: true,
//           itemCount: (snapshot.data! as dynamic).docs.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               crossAxisSpacing: 5,
//               mainAxisSpacing: 1.5,
//               childAspectRatio: 1),
//           itemBuilder: (context, index) {
//             DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];

//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => FullScreenImage(url: snap['postUrl']),
//                   ),
//                 );
//               },
//               child: CachedNetworkImage(
//                 imageUrl: snap['postUrl'],
//                 fit: BoxFit.cover,
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   Widget buildCommunityTab() {
//     return const Center(
//       child: Text(
//         'Community posts here',
//         style: TextStyle(fontSize: 20),
//       ),
//     );
//   }

//   Column buildStatColumn(int num, String label) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(num.toString(),
//             style: const TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             )),
//         Container(
//           margin: const EdgeInsets.only(top: 3),
//           child: Text(label,
//               style: const TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w400,
//                 color: Colors.grey,
//               )),
//         ),
//       ],
//     );
//   }
// }

// class FullScreenImage extends StatelessWidget {
//   final String url;

//   const FullScreenImage({Key? key, required this.url}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0, // Remove appbar shadow
//       ),
//       backgroundColor:
//           Colors.grey.withOpacity(0.2), // Transparent light grey background
//       body: Center(
//         child: CachedNetworkImage(
//           imageUrl: url,
//           placeholder: (context, url) =>
//               const CircularProgressIndicator(), // Placeholder while loading
//           errorWidget: (context, url, error) =>
//               const Icon(Icons.error), // Error widget if image fails to load
//           fit: BoxFit.contain, // Fit image to the screen
//         ),
//       ),
//     );
//   }
// }

// class Communitypostscreen extends ConsumerStatefulWidget {
//   final String uid;

//   const Communitypostscreen({
//     required this.uid,
//   });

//   @override
//   ConsumerState<Communitypostscreen> createState() =>
//       _CommunitypostscreenState();
// }

// class _CommunitypostscreenState extends ConsumerState<Communitypostscreen> {
//   late String currentUserUid;
//   late List<Community> userCommunities;
//   late String? selectedCommunity;

//   @override
//   void initState() {
//     super.initState();
//     currentUserUid = widget.uid;
//     userCommunities = [];
//     selectedCommunity = null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ref.watch(userCommunitiesProvider).when(
//           data: (List<Community> communities) {
//             userCommunities = communities;
//             if (userCommunities.isEmpty) {
//               return Center(
//                 child: Text("You haven't joined any communities."),
//               );
//             }
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Text(
//                     "Your Communities",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: userCommunities.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       final community = userCommunities[index];
//                       return ListTile(
//                         title: Text(community.name),
//                         onTap: () {
//                           setState(() {
//                             selectedCommunity = community.name;
//                           });
//                         },
//                       );
//                     },
//                   ),
//                 ),
//                 if (selectedCommunity != null)
//                   Expanded(
//                     child: ref
//                         .watch(getUserPostsInCommunityProvider(
//                           Tuple2(currentUserUid, selectedCommunity!),
//                         ))
//                         .when(
//                           data: (List<Post> posts) {
//                             // Filter posts to show only those posted by the current user
//                             final userPosts = posts
//                                 .where((post) => post.uid == currentUserUid)
//                                 .toList();
//                             if (userPosts.isEmpty) {
//                               return Center(
//                                 child: Text(
//                                   "You haven't posted anything in this community.",
//                                 ),
//                               );
//                             }
//                             return ListView.builder(
//                               itemCount: userPosts.length,
//                               itemBuilder: (context, index) {
//                                 return CPostCard(post: userPosts[index]);
//                               },
//                             );
//                           },
//                           loading: () =>
//                               Center(child: CircularProgressIndicator()),
//                           error: (error, _) {
//                             print(error.toString());
//                             return Center(
//                               child: Text(
//                                 "Error: ${error.toString()}",
//                               ),
//                             );
//                           },
//                         ),
//                   ),
//               ],
//             );
//           },
//           loading: () => Center(child: CircularProgressIndicator()),
//           error: (error, _) {
//             print(error.toString());
//             return Center(
//               child: Text(
//                 "Error: ${error.toString()}",
//               ),
//             );
//           },
//         );
//   }
// }
// */

// import 'dart:ui';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gonomad/core/community%20post/controller/add_cpost_controller.dart';
// import 'package:gonomad/core/community%20post/screens/cpost_card.dart';
// import 'package:gonomad/core/community%20post/screens/edit_profile_screen.dart';
// import 'package:gonomad/core/community/constants/error.dart';
// import 'package:gonomad/core/community/constants/loader.dart';
// import 'package:gonomad/core/community/controllers/community_controller..dart';
// import 'package:gonomad/features/auth/screen/aboutus_screen.dart';
// import 'package:gonomad/features/auth/screen/login_option_screen.dart';
// import 'package:gonomad/features/auth/screen/setting_Screen.dart';
// import 'package:gonomad/features/followers_list.dart';
// import 'package:gonomad/features/following_list.dart';
// import 'package:gonomad/models/community_model.dart';
// import 'package:gonomad/models/cpost_model.dart';
// import 'package:gonomad/resources/auth_methods.dart';
// import 'package:gonomad/resources/firestore_methods.dart';
// import 'package:gonomad/utils/utils.dart';
// import 'package:gonomad/widgets/follow_button.dart';

// import 'package:tuple/tuple.dart';

// class ProfileScreen extends StatefulWidget {
//   final String uid;
//   const ProfileScreen({Key? key, required this.uid}) : super(key: key);

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   var userData = {};
//   var postLen = 0;
//   int followers = 0;
//   int following = 0;
//   int score = 0;
//   bool isFollowing = false;
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }

//   getData() async {
//     if (!mounted) return; // Check if the widget is still mounted

//     setState(() {
//       isLoading = true;
//     });

//     try {
//       var userDocRef =
//           FirebaseFirestore.instance.collection('users').doc(widget.uid);

//       // Add a snapshot listener to the user document
//       userDocRef.snapshots().listen((userSnap) {
//         if (!mounted) return; // Check if the widget is still mounted
//         if (userSnap.exists) {
//           setState(() {
//             // Update user data
//             userData = userSnap.data()!;
//             followers = userData['followers'].length;
//             following = userData['following'].length;
//             score = userData['score'];
//             isFollowing = userData['followers'].contains(
//               FirebaseAuth.instance.currentUser!.uid,
//             );
//           });
//         }
//       });

//       var postSnap = await FirebaseFirestore.instance
//           .collection('posts')
//           .where('uid', isEqualTo: widget.uid)
//           .get();

//       if (!mounted) return; // Check if the widget is still mounted

//       setState(() {
//         postLen = postSnap.docs.length;
//       });
//     } catch (e) {
//       showSnackBar(e.toString(), context);
//     }

//     if (mounted) {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return isLoading
//         ? const Center(
//             child: CircularProgressIndicator(),
//           )
//         : Scaffold(
//             // appBar: AppBar(
//             //   backgroundColor: Colors.transparent,
//             //   title: Text('Profile '
//             //       // userData['username'],
//             //       ),
//             //   centerTitle: true,
//             //   flexibleSpace: ClipRect(
//             //     child: BackdropFilter(
//             //       filter: ImageFilter.blur(
//             //         sigmaX: 9,
//             //         sigmaY: 9,
//             //       ),
//             //       child: Container(
//             //         color: Colors.white.withOpacity(0.7),
//             //       ),
//             //     ),
//             //   ),
//             // ),
//             body: NestedScrollView(
//               headerSliverBuilder: (context, innerBoxIsScrolled) {
//                 return [
//                   SliverToBoxAdapter(
//                     child: Column(
//                       children: [
//                         Stack(
//                           clipBehavior: Clip.none,
//                           children: [
//                             Container(
//                               height: 200,
//                               width: double.infinity,
//                               color: Colors.amber,
//                             ),
//                             FirebaseAuth.instance.currentUser!.uid == widget.uid
//                                 ? Positioned(
//                                     top: 10,
//                                     right:
//                                         12, // Adjust this value to position the icon horizontally
//                                     child: Material(
//                                       elevation: 4,
//                                       shape: CircleBorder(),
//                                       clipBehavior: Clip.antiAlias,
//                                       child: IconButton(
//                                         icon: Icon(
//                                           Icons.menu,
//                                           color: Colors.black,
//                                         ),
//                                         onPressed: () {
//                                           _showBottomDrawer(context);
//                                         },
//                                       ),
//                                     ),
//                                   )
//                                 : SizedBox(),
//                             Positioned(
//                               top:
//                                   200, // Adjust this value to position the avatar
//                               left: MediaQuery.of(context).size.width / 2 -
//                                   50, // Center the avatar horizontally
//                               child: Transform.translate(
//                                 offset: Offset(0, -50),
//                                 child: CircleAvatar(
//                                   backgroundColor: Colors.grey,
//                                   backgroundImage: CachedNetworkImageProvider(
//                                     userData['photoUrl'],
//                                   ),
//                                   radius: 55,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 children: [
//                                   SizedBox(
//                                     height: 60,
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(15.0),
//                                     child: Row(
//                                       // mainAxisSize: MainAxisSize.max,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       //  crossAxisAlignment: CrossAxisAlignment.end,
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.all(12.0),
//                                           child:
//                                               buildStatColumn(postLen, "posts"),
//                                         ),
//                                         GestureDetector(
//                                           child: buildStatColumn(
//                                               followers, "followers"),
//                                           onTap: () => Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       FollowerCount(
//                                                           uid: widget.uid))),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: GestureDetector(
//                                             child: buildStatColumn(
//                                                 following, "following"),
//                                             onTap: () => Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         FollowingCount(
//                                                           uid: widget.uid,
//                                                         ))),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       FirebaseAuth.instance.currentUser!.uid ==
//                                               widget.uid
//                                           ? FollowButton(
//                                               text: 'Sign Out',
//                                               backgroundColor: Colors.white,
//                                               borderColor: Colors.grey,
//                                               textColor: Colors.black,
//                                               function: () async {
//                                                 await AuthMethods().signOut();
//                                                 Navigator.pushReplacement(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                         builder: (context) =>
//                                                             BackgroundVideo()));
//                                               },
//                                             )
//                                           : isFollowing
//                                               ? FollowButton(
//                                                   text: 'Disconnect',
//                                                   backgroundColor: Colors.grey,
//                                                   borderColor: Colors.black,
//                                                   textColor: Colors.black,
//                                                   function: () async {
//                                                     await FirestoreMethods()
//                                                         .followUser(
//                                                       FirebaseAuth.instance
//                                                           .currentUser!.uid,
//                                                       userData['uid'],
//                                                     );
//                                                     setState(() {
//                                                       isFollowing = false;
//                                                       followers--;
//                                                     });
//                                                   },
//                                                 )
//                                               : FollowButton(
//                                                   text: 'Connect',
//                                                   backgroundColor: Colors.blue,
//                                                   borderColor: Colors.grey,
//                                                   textColor: Colors.white,
//                                                   function: () async {
//                                                     await FirestoreMethods()
//                                                         .followUser(
//                                                       FirebaseAuth.instance
//                                                           .currentUser!.uid,
//                                                       userData['uid'],
//                                                     );

//                                                     setState(() {
//                                                       isFollowing = true;
//                                                       followers++;
//                                                     });
//                                                   },
//                                                 ),
//                                     ],
//                                   ),
//                                   // FirebaseAuth.instance.currentUser!.uid ==
//                                   //         widget.uid
//                                   //     ? Container(
//                                   //         padding:
//                                   //             const EdgeInsets.only(top: 2),
//                                   //         child: TextButton(
//                                   //           onPressed: () {
//                                   //             // Navigate to the EditProfileScreen when the button is pressed
//                                   //             Navigator.push(
//                                   //                 context,
//                                   //                 MaterialPageRoute(
//                                   //                   builder: (context) =>
//                                   //                       EditProfileScreen(
//                                   //                           uid: widget.uid),
//                                   //                 ));
//                                   //           },
//                                   //           child: Container(
//                                   //             decoration: BoxDecoration(
//                                   //               color: Colors.blue,
//                                   //               border: Border.all(
//                                   //                 color: Colors.grey,
//                                   //               ),
//                                   //               borderRadius:
//                                   //                   BorderRadius.circular(5),
//                                   //             ),
//                                   //             alignment: Alignment.center,
//                                   //             width: 250,
//                                   //             height: 42,
//                                   //             child: Text(
//                                   //               'Edit Profile',
//                                   //               style: TextStyle(
//                                   //                 color: Colors.white,
//                                   //                 fontWeight: FontWeight.bold,
//                                   //               ),
//                                   //             ),
//                                   //           ),
//                                   //         ),
//                                   //       )
//                                   //     : SizedBox(height: 1)
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           padding: const EdgeInsets.only(top: 15.0),
//                           child: Text(
//                             userData['username'],
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           padding: const EdgeInsets.only(top: 1.0),
//                           child: Text(
//                             userData['bio'],
//                           ),
//                         ),
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           padding: const EdgeInsets.only(top: 1.0),
//                           child: Text('score = $score'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ];
//               },
//               body: Column(
//                 children: [
//                   Expanded(
//                     child: DefaultTabController(
//                       length: 3,
//                       child: Column(
//                         children: [
//                            ButtonTabBar(
//                             tabs: [
//                               Tab(text: 'Post'),
//                               Tab(text: 'Community'),
//                                Tab(text: 'About'),
//                             ],
//                           ),
//                           Expanded(
//                             child: TabBarView(
//                               children: [
//                                 buildPostTab(),
//                                 Communitypostscreen(
//                                   uid: userData['uid'],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//   }

//   Widget buildPostTab() {
//     return FutureBuilder(
//       future: FirebaseFirestore.instance
//           .collection('posts')
//           .where('uid', isEqualTo: widget.uid)
//           .get(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         return GridView.builder(
//           shrinkWrap: true,
//           itemCount: (snapshot.data! as dynamic).docs.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               crossAxisSpacing: 5,
//               mainAxisSpacing: 1.5,
//               childAspectRatio: 1),
//           itemBuilder: (context, index) {
//             DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];

//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => FullScreenImage(url: snap['postUrl']),
//                   ),
//                 );
//               },
//               child: CachedNetworkImage(
//                 imageUrl: snap['postUrl'],
//                 fit: BoxFit.cover,
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   Widget buildCommunityTab() {
//     return const Center(
//       child: Text(
//         'Community posts here',
//         style: TextStyle(fontSize: 20),
//       ),
//     );
//   }

//   Column buildStatColumn(int num, String label) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(num.toString(),
//             style: const TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             )),
//         Container(
//           margin: const EdgeInsets.only(top: 3),
//           child: Text(label,
//               style: const TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w400,
//                 color: Colors.grey,
//               )),
//         ),
//       ],
//     );
//   }

//   void _showBottomDrawer(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext bc) {
//         return Padding(
//           padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
//           child: Container(
//             child: Wrap(
//               children: [
//                 ListTile(
//                   leading: Icon(Icons.monetization_on), // Changed the icon
//                   title: Text('Expense Tracker'),
//                   onTap: () {
//                     Navigator.pop(context); // Close the bottom drawer
//                     // Navigator.push(
//                     //   context,
//                     //   MaterialPageRoute(
//                     //       builder: (context) =>
//                     //           Expenses()), // Navigate to Expenses screen
//                     // );
//                   },
//                 ),
//                 Divider(),
//                 ListTile(
//                   leading: Icon(Icons.admin_panel_settings),
//                   title: Text('Edit Profile'),
//                   onTap: () {
//                     // Navigate to Settings screen
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               EditProfileScreen(uid: widget.uid),
//                         ));
//                   },
//                 ),
//                 Divider(),
//                 ListTile(
//                   leading: Icon(Icons.settings),
//                   title: Text('Settings'),
//                   onTap: () {
//                     // Navigate to Settings screen
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => SettingsScreen()),
//                     );
//                   },
//                 ),
//                 Divider(),
//                 ListTile(
//                   leading: Icon(Icons.info),
//                   title: Text('About Us'),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => AboutUsScreen()),
//                     );
//                     // Navigate to About Us screen
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class FullScreenImage extends StatelessWidget {
//   final String url;

//   const FullScreenImage({Key? key, required this.url}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0, // Remove appbar shadow
//       ),
//       backgroundColor:
//           Colors.grey.withOpacity(0.2), // Transparent light grey background
//       body: Center(
//         child: CachedNetworkImage(
//           imageUrl: url,
//           placeholder: (context, url) =>
//               const CircularProgressIndicator(), // Placeholder while loading
//           errorWidget: (context, url, error) =>
//               const Icon(Icons.error), // Error widget if image fails to load
//           fit: BoxFit.contain, // Fit image to the screen
//         ),
//       ),
//     );
//   }
// }

// class Communitypostscreen extends ConsumerStatefulWidget {
//   final String uid;

//   const Communitypostscreen({
//     required this.uid,
//   });

//   @override
//   ConsumerState<Communitypostscreen> createState() =>
//       _CommunitypostscreenState();
// }

// class _CommunitypostscreenState extends ConsumerState<Communitypostscreen> {
//   late String currentUserUid;
//   late List<Community> userCommunities;
//   late String? selectedCommunity;

//   @override
//   void initState() {
//     super.initState();
//     currentUserUid = widget.uid;
//     userCommunities = [];
//     selectedCommunity = null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ref.watch(userCommunitiesProvider).when(
//           data: (List<Community> communities) {
//             userCommunities = communities;
//             if (userCommunities.isEmpty) {
//               return Center(
//                 child: Text("You haven't joined any communities."),
//               );
//             }
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Text(
//                     "Your Communities",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: userCommunities.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       final community = userCommunities[index];
//                       return ListTile(
//                         title: Text(community.name),
//                         onTap: () {
//                           setState(() {
//                             selectedCommunity = community.name;
//                           });
//                         },
//                       );
//                     },
//                   ),
//                 ),
//                 if (selectedCommunity != null)
//                   Expanded(
//                     child: ref
//                         .watch(getUserPostsInCommunityProvider(
//                           Tuple2(currentUserUid, selectedCommunity!),
//                         ))
//                         .when(
//                           data: (List<Post> posts) {
//                             // Filter posts to show only those posted by the current user
//                             final userPosts = posts
//                                 .where((post) => post.uid == currentUserUid)
//                                 .toList();
//                             if (userPosts.isEmpty) {
//                               return Center(
//                                 child: Text(
//                                   "You haven't posted anything in this community.",
//                                 ),
//                               );
//                             }
//                             return ListView.builder(
//                               itemCount: userPosts.length,
//                               itemBuilder: (context, index) {
//                                 return CPostCard(post: userPosts[index]);
//                               },
//                             );
//                           },
//                           loading: () =>
//                               Center(child: CircularProgressIndicator()),
//                           error: (error, _) {
//                             print(error.toString());
//                             return Center(
//                               child: Text(
//                                 "Error: ${error.toString()}",
//                               ),
//                             );
//                           },
//                         ),
//                   ),
//               ],
//             );
//           },
//           loading: () => Center(child: CircularProgressIndicator()),
//           error: (error, _) {
//             print(error.toString());
//             return Center(
//               child: Text(
//                 "Error: ${error.toString()}",
//               ),
//             );
//           },
//         );
//   }
// }

// class AboutScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'About Screen',
//         style: TextStyle(fontSize: 20),
//       ),
//     );
//   }
// }

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gonomad/core/community%20post/controller/add_cpost_controller.dart';
import 'package:gonomad/core/community%20post/screens/cpost_card.dart';
import 'package:gonomad/core/community%20post/screens/edit_profile_screen.dart';
import 'package:gonomad/core/community/constants/error.dart';
import 'package:gonomad/core/community/constants/loader.dart';
import 'package:gonomad/core/community/controllers/community_controller..dart';
import 'package:gonomad/features/auth/screen/aboutus_screen.dart';
import 'package:gonomad/features/auth/screen/expense_feed/expenses.dart';
import 'package:gonomad/features/auth/screen/login_option_screen.dart';
import 'package:gonomad/features/auth/screen/setting_Screen.dart';
import 'package:gonomad/features/followers_list.dart';
import 'package:gonomad/features/following_list.dart';
import 'package:gonomad/models/community_model.dart';
import 'package:gonomad/models/cpost_model.dart';
import 'package:gonomad/resources/auth_methods.dart';
import 'package:gonomad/resources/firestore_methods.dart';
import 'package:gonomad/utils/utils.dart';
import 'package:gonomad/widgets/follow_button.dart';
// Adjust the import path as needed

import 'package:tuple/tuple.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  var userData = {};
  var postLen = 0;
  int followers = 0;
  int following = 0;
  int score = 0;
  bool isFollowing = false;
  bool isLoading = false;
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    getData();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  getData() async {
    if (!mounted) return; // Check if the widget is still mounted

    setState(() {
      isLoading = true;
    });

    try {
      var userDocRef =
          FirebaseFirestore.instance.collection('users').doc(widget.uid);

      // Add a snapshot listener to the user document
      userDocRef.snapshots().listen((userSnap) {
        if (!mounted) return; // Check if the widget is still mounted
        if (userSnap.exists) {
          setState(() {
            // Update user data
            userData = userSnap.data()!;
            followers = userData['followers'].length;
            following = userData['following'].length;
            score = userData['score'];
            isFollowing = userData['followers'].contains(
              FirebaseAuth.instance.currentUser!.uid,
            );
          });
        }
      });

      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
          .get();

      if (!mounted) return; // Check if the widget is still mounted

      setState(() {
        postLen = postSnap.docs.length;
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              color: Color.fromARGB(255, 15, 139, 108),
                            ),
                            FirebaseAuth.instance.currentUser!.uid == widget.uid
                                ? Positioned(
                                    top: 10,
                                    right: 12,
                                    child: Material(
                                      elevation: 4,
                                      shape: CircleBorder(),
                                      clipBehavior: Clip.antiAlias,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.menu,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          _showBottomDrawer(context);
                                        },
                                      ),
                                    ),
                                  )
                                : Positioned(
                                    top: 10,
                                    right: 12,
                                    child: Material(
                                      elevation: 4,
                                      shape: CircleBorder(),
                                      clipBehavior: Clip.antiAlias,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.menu,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          _showBottomDrawerUser(context);
                                        },
                                      ),
                                    ),
                                  ),
                            Positioned(
                              top: 150,
                              left: MediaQuery.of(context).size.width / 2 - 50,
                              child: Hero(
                                tag:
                                    'profile_picture_${userData['uid']}', // Unique tag for the hero animation
                                child: Transform.translate(
                                  offset: Offset(0, -50),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 6, // Thickness of the border
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        userData['photoUrl'],
                                      ),
                                      radius: 55,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 70,
                                  ),
                                  Center(
                                    child: Text(
                                      userData['username'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Row(
                                    // mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    //  crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, bottom: 20),
                                          child: buildStateRow(
                                            Icon(Icons.image_sharp),
                                            postLen,
                                          )),
                                      GestureDetector(
                                        child: buildStateRow(
                                          Icon(Icons.follow_the_signs),
                                          followers,
                                        ),
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FollowerCount(
                                                        uid: widget.uid))),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          child: buildStateRow(
                                            Icon(Icons.admin_panel_settings),
                                            following,
                                          ),
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FollowingCount(
                                                        uid: widget.uid,
                                                      ))),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FirebaseAuth.instance.currentUser!.uid ==
                                              widget.uid
                                          ? SizedBox()
                                          : isFollowing
                                              ? FollowButton(
                                                  text: 'Disconnect',
                                                  backgroundColor: Colors.grey,
                                                  borderColor: Colors.black,
                                                  textColor: Colors.black,
                                                  function: () async {
                                                    await FirestoreMethods()
                                                        .followUser(
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid,
                                                      userData['uid'],
                                                    );
                                                    setState(() {
                                                      isFollowing = false;
                                                      followers--;
                                                    });
                                                  },
                                                )
                                              : FollowButton(
                                                  text: 'Connect',
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 15, 139, 108),
                                                  borderColor: Colors.grey,
                                                  textColor: Colors.white,
                                                  function: () async {
                                                    await FirestoreMethods()
                                                        .followUser(
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid,
                                                      userData['uid'],
                                                    );

                                                    setState(() {
                                                      isFollowing = true;
                                                      followers++;
                                                    });
                                                  },
                                                ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Container(
                        //   alignment: Alignment.centerLeft,
                        //   padding: const EdgeInsets.only(top: 15.0),
                        //   child: Text(
                        //     userData['username'],
                        //     style: const TextStyle(
                        //       fontWeight: FontWeight.bold,
                        //       fontSize: 18,
                        //     ),
                        //   ),
                        // ),
                        // Container(
                        //   alignment: Alignment.centerLeft,
                        //   padding: const EdgeInsets.only(top: 1.0),
                        //   child: Text(
                        //     userData['bio'],
                        //   ),
                        // ),
                        // Container(
                        //   alignment: Alignment.centerLeft,
                        //   padding: const EdgeInsets.only(top: 1.0),
                        //   child: Text('score = $score'),
                        // ),
                      ],
                    ),
                  ),
                ];
              },
              body: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 0;
                          });
                          _tabController.animateTo(0);
                        },
                        style: ButtonStyle(
                          backgroundColor: _selectedIndex == 0
                              ? MaterialStateProperty.all(
                                  Color.fromARGB(255, 226, 161, 8))
                              : MaterialStateProperty.all(
                                  Color.fromARGB(255, 102, 106, 104)),
                        ),
                        child: Text(
                          'Post',
                          style: TextStyle(
                            color: _selectedIndex == 0
                                ? Colors.white
                                : Colors.white,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 1;
                          });
                          _tabController.animateTo(1);
                        },
                        style: ButtonStyle(
                          backgroundColor: _selectedIndex == 1
                              ? MaterialStateProperty.all(
                                  Color.fromARGB(255, 226, 161, 8))
                              : MaterialStateProperty.all(
                                  Color.fromARGB(255, 102, 106, 104)),
                        ),
                        child: Text(
                          'Community',
                          style: TextStyle(
                            color: _selectedIndex == 1
                                ? Colors.white
                                : Colors.white,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 2;
                          });
                          _tabController.animateTo(2);
                        },
                        style: ButtonStyle(
                          backgroundColor: _selectedIndex == 2
                              ? MaterialStateProperty.all(
                                  Color.fromARGB(255, 226, 161, 8))
                              : MaterialStateProperty.all(
                                  Color.fromARGB(255, 102, 106, 104)),
                        ),
                        child: Text(
                          'About',
                          style: TextStyle(
                            color: _selectedIndex == 2
                                ? Colors.white
                                : Colors.white,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedIndex =
                                3; // Change to the index of the "Trips" tab
                          });
                          _tabController.animateTo(3);
                        },
                        style: ButtonStyle(
                          backgroundColor: _selectedIndex == 3
                              ? MaterialStateProperty.all(
                                  Color.fromARGB(255, 226, 161, 8))
                              : MaterialStateProperty.all(
                                  Color.fromARGB(255, 102, 106, 104)),
                        ),
                        child: Text(
                          'Trips',
                          style: TextStyle(
                            color: _selectedIndex == 3
                                ? Colors.white
                                : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        buildPostTab(),
                        Communitypostscreen(
                          uid: userData['uid'],
                        ),
                        buildaboutus(),
                        TripsTab()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget buildPostTab() {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return GridView.builder(
          shrinkWrap: true,
          itemCount: (snapshot.data! as dynamic).docs.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 1.5,
              childAspectRatio: 1),
          itemBuilder: (context, index) {
            DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenImage(url: snap['postUrl']),
                  ),
                );
              },
              child: CachedNetworkImage(
                imageUrl: snap['postUrl'],
                fit: BoxFit.cover,
              ),
            );
          },
        );
      },
    );
  }

  Widget buildaboutus() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 218, 208, 208)
                  .withOpacity(0.5), // Adjust the opacity as needed
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: buildStatColumn(postLen, "posts"),
            ),
          ),

          SizedBox(
              height: 20), // Add spacing between the row and column sections

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  child: Container(
                    height: 150, // Adjust the height as needed
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 222, 217, 217)
                          .withOpacity(0.5), // Adjust the opacity as needed
                    ),
                    child: buildStatColumn(followers, "followers"),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FollowerCount(uid: widget.uid),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8), // Add spacing between follower and following
              Expanded(
                child: GestureDetector(
                  child: Container(
                    height: 150, // Adjust the height as needed
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 210, 205, 205)
                          .withOpacity(0.5), // Adjust the opacity as needed
                    ),
                    child: buildStatColumn(following, "following"),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FollowingCount(uid: widget.uid),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
              height: 20), // Add spacing between the row and column sections

          Column(
            children: [
              Container(
                height: 30,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 210, 205, 205)
                      .withOpacity(0.5), // Adjust the opacity as needed
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Username: ${userData['username']}',
                      style: const TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 30,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 210, 205, 205)
                      .withOpacity(0.5), // Adjust the opacity as needed
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Bio: ${userData['bio']}',
                      style: const TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 30,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 210, 205, 205)
                      .withOpacity(0.5), // Adjust the opacity as needed
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Score: $score',
                      style: const TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void addtrips() {}

  void _showBottomDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Container(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.monetization_on), // Changed the icon
                  title: Text('Expense Tracker'),
                  onTap: () {
                    Navigator.pop(context); // Close the bottom drawer
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Expenses()), // Navigate to Expenses screen
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.admin_panel_settings),
                  title: Text('Edit Profile'),
                  onTap: () {
                    // Navigate to Settings screen
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditProfileScreen(uid: widget.uid),
                        ));
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    // Navigate to Settings screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsScreen()),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('About Us'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutUsScreen()),
                    );
                    // Navigate to About Us screen
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Sign out'),
                  onTap: () async {
                    await AuthMethods().signOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BackgroundVideo()));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showBottomDrawerUser(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Container(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.share), // Changed the icon
                  title: Text('Share this profile'),
                  onTap: () {
                    Navigator.pop(context); // Close the bottom drawer
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           Expenses()), // Navigate to Expenses screen
                    // );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.block),
                  title: Text('Block User'),
                  onTap: () {
                    // Navigate to Settings screen
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) =>
                    //           EditProfileScreen(uid: widget.uid),
                    //     ));
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.report),
                  title: Text('Report User'),
                  onTap: () {
                    // Navigate to Settings screen
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => SettingsScreen()),
                    // );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Column buildStatColumn(int num, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(num.toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
      Container(
        margin: const EdgeInsets.only(top: 3),
        child: Text(label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            )),
      ),
    ],
  );
}

Row buildStateRow(
  Icon icon,
  int num,
) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(num.toString(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          )),
      icon
    ],
  );
}

// Your existing methods

class FullScreenImage extends StatelessWidget {
  final String url;

  const FullScreenImage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.withOpacity(0.2),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: url,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class Communitypostscreen extends ConsumerStatefulWidget {
  final String uid;

  const Communitypostscreen({
    required this.uid,
  });

  @override
  ConsumerState<Communitypostscreen> createState() =>
      _CommunitypostscreenState();
}

class _CommunitypostscreenState extends ConsumerState<Communitypostscreen> {
  late String currentUserUid;
  late List<Community> userCommunities;
  late String? selectedCommunity;

  @override
  void initState() {
    super.initState();
    currentUserUid = widget.uid;
    userCommunities = [];
    selectedCommunity = null;
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(userCommunitiesProvider).when(
          data: (List<Community> communities) {
            userCommunities = communities;
            if (userCommunities.isEmpty) {
              return Center(
                child: Text("You haven't joined any communities."),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Your Communities",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: userCommunities.length,
                    itemBuilder: (BuildContext context, int index) {
                      final community = userCommunities[index];
                      return ListTile(
                        title: Text(community.name),
                        onTap: () {
                          setState(() {
                            selectedCommunity = community.name;
                          });
                        },
                      );
                    },
                  ),
                ),
                if (selectedCommunity != null)
                  Expanded(
                    child: ref
                        .watch(getUserPostsInCommunityProvider(
                          Tuple2(currentUserUid, selectedCommunity!),
                        ))
                        .when(
                          data: (List<Post> posts) {
                            // Filter posts to show only those posted by the current user
                            final userPosts = posts
                                .where((post) => post.uid == currentUserUid)
                                .toList();
                            if (userPosts.isEmpty) {
                              return const Center(
                                child: Text(
                                  "You haven't posted anything in this community.",
                                ),
                              );
                            }
                            return ListView.builder(
                              itemCount: userPosts.length,
                              itemBuilder: (context, index) {
                                return CPostCard(post: userPosts[index]);
                              },
                            );
                          },
                          loading: () =>
                              Center(child: CircularProgressIndicator()),
                          error: (error, _) {
                            print(error.toString());
                            return Center(
                              child: Text(
                                "Error: ${error.toString()}",
                              ),
                            );
                          },
                        ),
                  ),
              ],
            );
          },
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, _) {
            print(error.toString());
            return Center(
              child: Text(
                "Error: ${error.toString()}",
              ),
            );
          },
        );
  }
}

// class Trip {
//   final String place;
//   final List<String> users;
//   final DateTime timestamp;

//   Trip({
//     required this.place,
//     required this.users,
//     required this.timestamp,
//   });
// }

// class TripsTab extends StatefulWidget {
//   @override
//   _TripsTabState createState() => _TripsTabState();
// }

// class _TripsTabState extends State<TripsTab> {
//   String selectedPlace = '';
//   List<String> selectedUsers = [];

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextField(
//             decoration: InputDecoration(
//               labelText: 'Enter a Place',
//             ),
//             onChanged: (value) {
//               setState(() {
//                 selectedPlace = value;
//               });
//             },
//           ),
//           SizedBox(height: 16.0),
//           Text(
//             'Select Followers and Following Users',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 8.0),
//           // You can manually add followers and following users here
//           // For simplicity, let's assume you have a list of user IDs
//           ListView(
//             shrinkWrap: true,
//             children: [
//               // Replace these ListTile widgets with your actual user selection widgets
//               ListTile(
//                 title: Text('Follower 1'),
//                 onTap: () {
//                   setState(() {
//                     selectedUsers.add('follower_1_id');
//                   });
//                 },
//               ),
//               ListTile(
//                 title: Text('Follower 2'),
//                 onTap: () {
//                   setState(() {
//                     selectedUsers.add('follower_2_id');
//                   });
//                 },
//               ),
//               // Add more ListTile widgets for additional users as needed
//             ],
//           ),
//           SizedBox(height: 16.0),
//           ElevatedButton(
//             onPressed: () async {
//               // Save trip data to Firebase Firestore
//               await FirebaseFirestore.instance.collection('trips').add({
//                 'place': selectedPlace,
//                 'users': selectedUsers,
//                 'timestamp': DateTime.now(),
//               });

//               // Reset selected place and users
//               setState(() {
//                 selectedPlace = '';
//                 selectedUsers.clear();
//               });

//               // Show a snackbar or toast message to indicate that the trip is saved
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('Trip Saved Successfully!'),
//                 ),
//               );
//             },
//             child: Text('Save Trip'),
//           ),
//           SizedBox(height: 16.0),
//           Text(
//             'Trips',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 8.0),
//           StreamBuilder<QuerySnapshot>(
//             stream: FirebaseFirestore.instance.collection('trips').snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 final trips = snapshot.data!.docs
//                     .map((doc) => Trip(
//                           place: doc['place'],
//                           users: List<String>.from(doc['users']),
//                           timestamp: (doc['timestamp'] as Timestamp).toDate(),
//                         ))
//                     .toList();

//                 return ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: trips.length,
//                   itemBuilder: (context, index) {
//                     final trip = trips[index];
//                     return ListTile(
//                       title: Text(trip.place),
//                       subtitle: Text('Users: ${trip.users.join(', ')}'),
//                       trailing: Text('Date: ${trip.timestamp.toString()}'),
//                     );
//                   },
//                 );
//               } else if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else {
//                 return CircularProgressIndicator(); // Show a loading indicator while fetching data
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Trip {
//   final String place;
//   final List<String> users;
//   final DateTime timestamp;

//   Trip({
//     required this.place,
//     required this.users,
//     required this.timestamp,
//   });
// }

// class TripsTab extends StatefulWidget {
//   @override
//   _TripsTabState createState() => _TripsTabState();
// }

// class _TripsTabState extends State<TripsTab> {
//   String selectedPlace = '';
//   List<String> selectedUsers = [];
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   late final User currentUser;

//   @override
//   void initState() {
//     super.initState();
//     currentUser = _auth.currentUser!;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       // Wrap SingleChildScrollView with SizedBox
//       width: MediaQuery.of(context).size.width, // Specify width
//       height: MediaQuery.of(context).size.height, // Specify height
//       child: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Enter a Place',
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   selectedPlace = value;
//                 });
//               },
//             ),
//             SizedBox(height: 16.0),
//             Text(
//               'Select Followers and Following Users',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8.0),
//             // Display followers
//             FollowerCount(uid: currentUser.uid),
//             SizedBox(height: 16.0),
//             // Display following users
//             FollowingCount(uid: currentUser.uid),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () async {
//                 // Save trip data to Firebase Firestore
//                 await FirebaseFirestore.instance.collection('trips').add({
//                   'place': selectedPlace,
//                   'users': selectedUsers,
//                   'timestamp': DateTime.now(),
//                 });

//                 // Reset selected place and users
//                 setState(() {
//                   selectedPlace = '';
//                   selectedUsers.clear();
//                 });

//                 // Show a snackbar or toast message to indicate that the trip is saved
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('Trip Saved Successfully!'),
//                   ),
//                 );
//               },
//               child: Text('Save Trip'),
//             ),
//             SizedBox(height: 16.0),
//             Text(
//               'Trips',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8.0),
//             StreamBuilder<QuerySnapshot>(
//               stream:
//                   FirebaseFirestore.instance.collection('trips').snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   final trips = snapshot.data!.docs
//                       .map((doc) => Trip(
//                             place: doc['place'],
//                             users: List<String>.from(doc['users']),
//                             timestamp: (doc['timestamp'] as Timestamp).toDate(),
//                           ))
//                       .toList();

//                   return ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: trips.length,
//                     itemBuilder: (context, index) {
//                       final trip = trips[index];
//                       return ListTile(
//                         title: Text(trip.place),
//                         subtitle: Text('Users: ${trip.users.join(', ')}'),
//                         trailing: Text('Date: ${trip.timestamp.toString()}'),
//                       );
//                     },
//                   );
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
//                   return CircularProgressIndicator(); // Show a loading indicator while fetching data
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SelectableUserItem extends StatefulWidget {
//   final String userId;
//   final String userName;
//   final bool isSelected;
//   final ValueChanged<bool> onSelected;

//   const SelectableUserItem({
//     Key? key,
//     required this.userId,
//     required this.userName,
//     required this.isSelected,
//     required this.onSelected,
//   }) : super(key: key);

//   @override
//   _SelectableUserItemState createState() => _SelectableUserItemState();
// }

// class _SelectableUserItemState extends State<SelectableUserItem> {
//   bool _isSelected = false;

//   @override
//   void initState() {
//     super.initState();
//     _isSelected = widget.isSelected;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CheckboxListTile(
//       title: Text(widget.userName),
//       value: _isSelected,
//       onChanged: (value) {
//         setState(() {
//           _isSelected = value!;
//         });
//         widget.onSelected(value!);
//       },
//     );
//   }
// }

// class FollowerList extends StatelessWidget {
//   final List<String> followerIds;
//   final ValueChanged<String> onSelected;

//   const FollowerList({
//     Key? key,
//     required this.followerIds,
//     required this.onSelected,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: followerIds.length,
//       itemBuilder: (context, index) {
//         String userId = followerIds[index];
//         // You can fetch the username corresponding to userId here
//         String userName = 'User $userId'; // Replace with actual username
//         return SelectableUserItem(
//           userId: userId,
//           userName: userName,
//           isSelected: false,
//           onSelected: (isSelected) {
//             if (isSelected) {
//               onSelected(userId);
//             }
//           },
//         );
//       },
//     );
//   }
// }

// class FollowingList extends StatelessWidget {
//   final List<String> followingIds;
//   final ValueChanged<String> onSelected;

//   const FollowingList({
//     Key? key,
//     required this.followingIds,
//     required this.onSelected,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: followingIds.length,
//       itemBuilder: (context, index) {
//         String userId = followingIds[index];
//         // You can fetch the username corresponding to userId here
//         String userName = 'User $userId'; // Replace with actual username
//         return SelectableUserItem(
//           userId: userId,
//           userName: userName,
//           isSelected: false,
//           onSelected: (isSelected) {
//             if (isSelected) {
//               onSelected(userId);
//             }
//           },
//         );
//       },
//     );
//   }
// }

// class TripsTab extends StatelessWidget {
//   final List<String> followingIds = [
//     '1',
//     '2',
//     '3'
//   ]; // Example list of following users
//   final List<String> followerIds = [
//     '4',
//     '5',
//     '6'
//   ]; // Example list of follower users

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Select Followers',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 8.0),
//           Text('Followers count: ${followerIds.length}'),
//           FollowerList(
//             followerIds: followerIds,
//             onSelected: (userId) {
//               print('Selected follower: $userId');
//               // Handle the selected follower here
//             },
//           ),
//           SizedBox(height: 16.0),
//           Text(
//             'Select Following Users',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 8.0),
//           Text('Following count: ${followingIds.length}'),
//           FollowingList(
//             followingIds: followingIds,
//             onSelected: (userId) {
//               print('Selected following user: $userId');
//               // Handle the selected following user here
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TripsTab extends StatefulWidget {
//   @override
//   _TripsTabState createState() => _TripsTabState();
// }

// class _TripsTabState extends State<TripsTab> {
//   String selectedPlace = '';
//   String? selectedInterest; // Change selectedInterest to nullable
//   List<String> interests = [
//     'Select Interest', // Add initial hint item
//     'Scuba diving',
//     'Overland travel',
//     'Jungle tourism',
//     'Extreme travel',
//     'Rock climbing',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextField(
//             decoration: InputDecoration(
//               labelText: 'Enter a Place Visited',
//             ),
//             onChanged: (value) {
//               setState(() {
//                 selectedPlace = value;
//               });
//             },
//           ),
//           SizedBox(height: 16.0),
//           Text(
//             'Select Interests',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 8.0),
//           DropdownButtonFormField<String>(
//             value: selectedInterest,
//             onChanged: (value) {
//               setState(() {
//                 selectedInterest = value;
//               });
//             },
//             items: interests.map((interest) {
//               return DropdownMenuItem<String>(
//                 value: interest,
//                 child: Text(interest),
//               );
//             }).toList(),
//             decoration: InputDecoration(
//               labelText: 'Select Interest',
//               hintText: 'Choose an interest',
//             ),
//           ),
//           SizedBox(height: 16.0),
//           ElevatedButton(
//             onPressed: () async {
//               // Store trip data to Firebase Firestore
//               await FirebaseFirestore.instance.collection('trip').add({
//                 'place': selectedPlace,
//                 'interest': selectedInterest,
//                 'timestamp': DateTime.now(),
//               });

//               // Reset selected place and interest
//               setState(() {
//                 selectedPlace = '';
//                 selectedInterest = null;
//               });

//               // Show a snackbar or toast message to indicate that the trip is saved
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('Trip Saved Successfully!'),
//                 ),
//               );
//             },
//             child: Text('Save Trip'),
//           ),
//         ],
//       ),
//     );
//   }

// class TripsTab extends StatefulWidget {
//   @override
//   _TripsTabState createState() => _TripsTabState();
// }

// class _TripsTabState extends State<TripsTab> {
//   String selectedPlace = '';
//   List<String> selectedInterests = [];
//   List<String> interests = [
//     'Select Interest',
//     'Scuba diving',
//     'Overland travel',
//     'Jungle tourism',
//     'Extreme travel',
//     'Rock climbing',
//   ];

//   FirebaseAuth _auth = FirebaseAuth.instance;
//   late String currentUserUid;

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentUserUid();
//   }

//   Future<void> _getCurrentUserUid() async {
//     User? user = _auth.currentUser;
//     if (user != null) {
//       setState(() {
//         currentUserUid = user.uid;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextField(
//             decoration: InputDecoration(
//               labelText: 'Enter a Place Visited',
//             ),
//             onChanged: (value) {
//               setState(() {
//                 selectedPlace = value;
//               });
//             },
//           ),
//           SizedBox(height: 16.0),
//           Text(
//             'Select Interests',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 8.0),
//           Wrap(
//             children: interests.map((interest) {
//               return CheckboxListTile(
//                 title: Text(interest),
//                 value: selectedInterests.contains(interest),
//                 onChanged: (isChecked) {
//                   setState(() {
//                     if (isChecked!) {
//                       selectedInterests.add(interest);
//                     } else {
//                       selectedInterests.remove(interest);
//                     }
//                   });
//                 },
//               );
//             }).toList(),
//           ),
//           SizedBox(height: 16.0),
//           ElevatedButton(
//             onPressed: () async {
//               // Store trip data to Firebase Firestore
//               await FirebaseFirestore.instance.collection('trips').add({
//                 'uid': currentUserUid,
//                 'place': selectedPlace,
//                 'timestamp': DateTime.now(),
//               });

//               // Reset selected place
//               setState(() {
//                 selectedPlace = '';
//               });

//               // Show a snackbar or toast message to indicate that the trip is saved
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('Trip Saved Successfully!'),
//                 ),
//               );
//             },
//             child: Text('Save Trip'),
//           ),
//           SizedBox(height: 16.0),
//           ElevatedButton(
//             onPressed: () async {
//               // Store selected interests in the database
//               for (String interest in selectedInterests) {
//                 await FirebaseFirestore.instance.collection('interests').add({
//                   'uid': currentUserUid,
//                   'name': interest,
//                 });
//               }

//               // Show a snackbar or toast message to indicate that the interests are added
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('Interests Added Successfully!'),
//                 ),
//               );

//               // Clear selected interests
//               setState(() {
//                 selectedInterests.clear();
//               });
//             },
//             child: Text('Add Interests'),
//           ),
//           SizedBox(height: 32.0),
//           Text(
//             'Interests:',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 8.0),
//           FutureBuilder<QuerySnapshot>(
//             future: FirebaseFirestore.instance
//                 .collection('interests')
//                 .where('uid', isEqualTo: currentUserUid)
//                 .get(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator();
//               }

//               if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               }

//               List<String> interests = [];
//               snapshot.data!.docs.forEach((doc) {
//                 interests.add(doc['name']);
//               });

//               return ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: interests.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(interests[index]),
//                   );
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TripsTab extends StatefulWidget {
//   @override
//   _TripsTabState createState() => _TripsTabState();
// }

// class _TripsTabState extends State<TripsTab> {
//   String selectedPlace = '';
//   List<String> selectedInterests = [];
//   List<String> interests = [
//     'Select Interest',
//     'Scuba diving',
//     'Overland travel',
//     'Jungle tourism',
//     'Extreme travel',
//     'Rock climbing',
//   ];

//   FirebaseAuth _auth = FirebaseAuth.instance;
//   late String currentUserUid;

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentUserUid();
//   }

//   Future<void> _getCurrentUserUid() async {
//     User? user = _auth.currentUser;
//     if (user != null) {
//       setState(() {
//         currentUserUid = user.uid;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextField(
//             decoration: InputDecoration(
//               labelText: 'Enter a Place Visited',
//             ),
//             onChanged: (value) {
//               setState(() {
//                 selectedPlace = value;
//               });
//             },
//           ),
//           SizedBox(height: 16.0),
//           Text(
//             'Select Interests',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 8.0),
//           Wrap(
//             children: interests.map((interest) {
//               return CheckboxListTile(
//                 title: Text(interest),
//                 value: selectedInterests.contains(interest),
//                 onChanged: (isChecked) {
//                   setState(() {
//                     if (isChecked!) {
//                       selectedInterests.add(interest);
//                     } else {
//                       selectedInterests.remove(interest);
//                     }
//                   });
//                 },
//               );
//             }).toList(),
//           ),
//           SizedBox(height: 16.0),
//           ElevatedButton(
//             onPressed: () async {
//               // Store trip data to Firebase Firestore
//               await FirebaseFirestore.instance.collection('trips').add({
//                 'uid': currentUserUid,
//                 'place': selectedPlace,
//                 'timestamp': DateTime.now(),
//               });

//               // Reset selected place
//               setState(() {
//                 selectedPlace = '';
//               });

//               // Show a snackbar or toast message to indicate that the trip is saved
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('Trip Saved Successfully!'),
//                 ),
//               );
//             },
//             child: Text('Save Trip'),
//           ),

//           SizedBox(height: 16.0),
//           ElevatedButton(
//             onPressed: () async {
//               // Store selected interests in the database
//               for (String interest in selectedInterests) {
//                 await FirebaseFirestore.instance.collection('interests').add({
//                   'uid': currentUserUid,
//                   'name': interest,
//                 });
//               }

//               // Show a snackbar or toast message to indicate that the interests are added
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('Interests Added Successfully!'),
//                 ),
//               );

//               // Clear selected interests
//               setState(() {
//                 selectedInterests.clear();
//               });
//             },
//             child: Text('Add Interests'),
//           ),
//           SizedBox(height: 32.0),
//           Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Trips:',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 8.0),
//                     FutureBuilder<QuerySnapshot>(
//                       future: FirebaseFirestore.instance
//                           .collection('trips')
//                           .where('uid', isEqualTo: currentUserUid)
//                           .get(),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return CircularProgressIndicator();
//                         }

//                         if (snapshot.hasError) {
//                           return Text('Error: ${snapshot.error}');
//                         }

//                         List<String> trips = [];
//                         snapshot.data!.docs.forEach((doc) {
//                           trips.add(doc['place']);
//                         });

//                         return ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: trips.length,
//                           itemBuilder: (context, index) {
//                             return ListTile(
//                               title: Text(trips[index]),
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(width: 16.0),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Interests:',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 8.0),
//                     FutureBuilder<QuerySnapshot>(
//                       future: FirebaseFirestore.instance
//                           .collection('interests')
//                           .where('uid', isEqualTo: currentUserUid)
//                           .get(),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return CircularProgressIndicator();
//                         }

//                         if (snapshot.hasError) {
//                           return Text('Error: ${snapshot.error}');
//                         }

//                         List<String> interests = [];
//                         snapshot.data!.docs.forEach((doc) {
//                           interests.add(doc['name']);
//                         });

//                         return ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: interests.length,
//                           itemBuilder: (context, index) {
//                             return ListTile(
//                               title: Text(interests[index]),
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TripsTab extends StatefulWidget {
//   @override
//   _TripsTabState createState() => _TripsTabState();
// }

// class _TripsTabState extends State<TripsTab> {
//   String selectedPlace = '';
//   List<String> selectedInterests = [];
//   List<String> interests = [
//     'Select Interest',
//     'Scuba diving',
//     'Overland travel',
//     'Jungle tourism',
//     'Extreme travel',
//     'Rock climbing',
//   ];

//   FirebaseAuth _auth = FirebaseAuth.instance;
//   String? currentUserUid;

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentUserUid();
//   }

//   Future<void> _getCurrentUserUid() async {
//     User? user = _auth.currentUser;
//     if (user != null) {
//       setState(() {
//         currentUserUid = user.uid;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(16.0),
//       child:  Column(

//           children: [

//           FirebaseAuth.instance.currentUser!.uid == currentUserUid? (
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextField(
//             decoration: InputDecoration(
//               labelText: 'Enter a Place Visited',
//             ),
//             onChanged: (value) {
//               setState(() {
//                 selectedPlace = value;
//               });
//             },
//           ),
//           SizedBox(height: 16.0),
//           Text(
//             'Select Interests',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 8.0),
//           Wrap(
//             children: interests.map((interest) {
//               return CheckboxListTile(
//                 title: Text(interest),
//                 value: selectedInterests.contains(interest),
//                 onChanged: (isChecked) {
//                   setState(() {
//                     if (isChecked!) {
//                       selectedInterests.add(interest);
//                     } else {
//                       selectedInterests.remove(interest);
//                     }
//                   });
//                 },
//               );
//             }).toList(),
//           ),
//           SizedBox(height: 16.0),
//           Row(

//             children: [

//                if (currentUserUid != null) ...[
//             ElevatedButton(
//               onPressed: () async {
//                 // Store trip data to Firebase Firestore
//                 await FirebaseFirestore.instance.collection('trips').add({
//                   'uid': currentUserUid,
//                   'place': selectedPlace,
//                   'timestamp': DateTime.now(),
//                 });

//                 // Reset selected place
//                 setState(() {
//                   selectedPlace = '';
//                 });

//                 // Show a snackbar or toast message to indicate that the trip is saved
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('Trip Saved Successfully!'),
//                   ),
//                 );
//               },
//               child: Text('Save Trip'),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () async {
//                 // Store selected interests in the database
//                 for (String interest in selectedInterests) {
//                   await FirebaseFirestore.instance.collection('interests').add({
//                     'uid': currentUserUid,
//                     'name': interest,
//                   });
//                 }

//                 // Show a snackbar or toast message to indicate that the interests are added
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('Interests Added Successfully!'),
//                   ),
//                 );

//                 // Clear selected interests
//                 setState(() {
//                   selectedInterests.clear();
//                 });
//               },
//               child: Text('Add Interests'),
//             ),

//             ],

//           ]

//           ),  ]

//           )

//           ]

//           )

//           :

//           Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Trips:',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 8.0),
//                     FutureBuilder<QuerySnapshot>(
//                       future: FirebaseFirestore.instance
//                           .collection('trips')
//                           .where('uid', isEqualTo: currentUserUid)
//                           .get(),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return CircularProgressIndicator();
//                         }

//                         if (snapshot.hasError) {
//                           return Text('Error: ${snapshot.error}');
//                         }

//                         List<String> trips = [];
//                         snapshot.data!.docs.forEach((doc) {
//                           trips.add(doc['place']);
//                         });

//                         return ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: trips.length,
//                           itemBuilder: (context, index) {
//                             return ListTile(
//                               title: Text(trips[index]),
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(width: 16.0),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Interests:',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 8.0),
//                     FutureBuilder<QuerySnapshot>(
//                       future: FirebaseFirestore.instance
//                           .collection('interests')
//                           .where('uid', isEqualTo: currentUserUid)
//                           .get(),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return CircularProgressIndicator();
//                         }

//                         if (snapshot.hasError) {
//                           return Text('Error: ${snapshot.error}');
//                         }

//                         List<String> interests = [];
//                         snapshot.data!.docs.forEach((doc) {
//                           interests.add(doc['name']);
//                         });

//                         return ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: interests.length,
//                           itemBuilder: (context, index) {
//                             return ListTile(
//                               title: Text(interests[index]),
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),

//       )
//       );

//   }
// }

// class TripsTab extends StatefulWidget {
//   @override
//   _TripsTabState createState() => _TripsTabState();
// }

// class _TripsTabState extends State<TripsTab> {
//   String selectedPlace = '';
//   List<String> selectedInterests = [];
//   List<String> interests = [
//     'Select Interest',
//     'Scuba diving',
//     'Overland travel',
//     'Jungle tourism',
//     'Extreme travel',
//     'Rock climbing',
//   ];

//   FirebaseAuth _auth = FirebaseAuth.instance;
//   User? currentUser;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentUser();
//   }

//   Future<void> _getCurrentUser() async {
//     currentUser = _auth.currentUser;
//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(16.0),
//       child: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               if (currentUser != null) ...[
//                 TextField(
//                   decoration: InputDecoration(
//                     labelText: 'Enter a Place Visited',
//                   ),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedPlace = value;
//                     });
//                   },
//                 ),
//                 SizedBox(height: 16.0),
//                 Text(
//                   'Select Interests',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 8.0),
//                 Wrap(
//                   children: interests.map((interest) {
//                     return CheckboxListTile(
//                       title: Text(interest),
//                       value: selectedInterests.contains(interest),
//                       onChanged: (isChecked) {
//                         setState(() {
//                           if (isChecked!) {
//                             selectedInterests.add(interest);
//                           } else {
//                             selectedInterests.remove(interest);
//                           }
//                         });
//                       },
//                     );
//                   }).toList(),
//                 ),
//                 SizedBox(height: 16.0),
//                 Row(
//                   children: [
//                     ElevatedButton(
//                       onPressed: () async {
//                         // Store trip data to Firebase Firestore
//                         await FirebaseFirestore.instance
//                             .collection('trips')
//                             .add({
//                           'uid': currentUser!.uid,
//                           'place': selectedPlace,
//                           'timestamp': DateTime.now(),
//                         });

//                         // Reset selected place
//                         setState(() {
//                           selectedPlace = '';
//                         });

//                         // Show a snackbar or toast message to indicate that the trip is saved
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text('Trip Saved Successfully!'),
//                           ),
//                         );
//                       },
//                       child: Text('Save Trip'),
//                     ),
//                     SizedBox(height: 16.0),
//                     ElevatedButton(
//                       onPressed: () async {
//                         // Store selected interests in the database
//                         for (String interest in selectedInterests) {
//                           await FirebaseFirestore.instance
//                               .collection('interests')
//                               .add({
//                             'uid': currentUser!.uid,
//                             'name': interest,
//                           });
//                         }

//                         // Show a snackbar or toast message to indicate that the interests are added
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text('Interests Added Successfully!'),
//                           ),
//                         );

//                         // Clear selected interests
//                         setState(() {
//                           selectedInterests.clear();
//                         });
//                       },
//                       child: Text('Add Interests'),
//                     ),
//                   ],
//                 ),
//               ],
//               SizedBox(height: 32.0),
//               Row(
//                 children: [
//                   Column(children: [
//                     Text(
//                       'Trips:',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 8.0),
//                     StreamBuilder<QuerySnapshot>(
//                       stream: FirebaseFirestore.instance
//                           .collection('trips')
//                           .where('uid', isEqualTo: currentUser!.uid)
//                           .snapshots(),
//                       builder: (context, tripSnapshot) {
//                         if (tripSnapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return CircularProgressIndicator();
//                         }

//                         if (tripSnapshot.hasError) {
//                           return Text('Error: ${tripSnapshot.error}');
//                         }

//                         final tripDocs = tripSnapshot.data!.docs;
//                         if (tripDocs.isEmpty) {
//                           return Text('No trips added yet.');
//                         }

//                         final trips =
//                             tripDocs.map((doc) => doc['place']).toList();

//                         return ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: trips.length,
//                           itemBuilder: (context, index) {
//                             return ListTile(
//                               title: Text(trips[index]),
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ]),
//                   Column(
//                     children: [
//                       Text(
//                         'Interests:',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 8.0),
//                       StreamBuilder<QuerySnapshot>(
//                         stream: FirebaseFirestore.instance
//                             .collection('interests')
//                             .where('uid', isEqualTo: currentUser!.uid)
//                             .snapshots(),
//                         builder: (context, interestSnapshot) {
//                           if (interestSnapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return CircularProgressIndicator();
//                           }

//                           if (interestSnapshot.hasError) {
//                             return Text('Error: ${interestSnapshot.error}');
//                           }

//                           final interestDocs = interestSnapshot.data!.docs;
//                           if (interestDocs.isEmpty) {
//                             return Text('No interests added yet.');
//                           }

//                           final interests =
//                               interestDocs.map((doc) => doc['name']).toList();

//                           return ListView.builder(
//                             shrinkWrap: true,
//                             itemCount: interests.length,
//                             itemBuilder: (context, index) {
//                               return ListTile(
//                                 title: Text(interests[index]),
//                               );
//                             },
//                           );
//                         },
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ]),
//     );
//   }
// }

class TripsTab extends StatefulWidget {
  @override
  _TripsTabState createState() => _TripsTabState();
}

class _TripsTabState extends State<TripsTab> {
  String selectedPlace = '';
  List<String> selectedInterests = [];
  List<String> interests = [
    'Select Interest',
    'Scuba diving',
    'Overland travel',
    'Jungle tourism',
    'Extreme travel',
    'Rock climbing',
  ];

  FirebaseAuth _auth = FirebaseAuth.instance;
  User? currentUser;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    currentUser = _auth.currentUser;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trips And Interest'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (currentUser != null) ...[
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Enter a Place Visited',
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedPlace = value;
                        });
                      },
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Select Interests',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Wrap(
                      children: interests.map((interest) {
                        return CheckboxListTile(
                          title: Text(interest),
                          value: selectedInterests.contains(interest),
                          onChanged: (isChecked) {
                            setState(() {
                              if (isChecked!) {
                                selectedInterests.add(interest);
                              } else {
                                selectedInterests.remove(interest);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            // Store trip data to Firebase Firestore
                            await FirebaseFirestore.instance
                                .collection('trips')
                                .add({
                              'uid': currentUser!.uid,
                              'place': selectedPlace,
                              'timestamp': DateTime.now(),
                            });

                            // Reset selected place
                            setState(() {
                              selectedPlace = '';
                            });

                            // Show a snackbar or toast message to indicate that the trip is saved
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Trip Saved Successfully!'),
                              ),
                            );
                          },
                          child: Text('Save Trip'),
                        ),
                        SizedBox(width: 16.0),
                        ElevatedButton(
                          onPressed: () async {
                            // Store selected interests in the database
                            for (String interest in selectedInterests) {
                              await FirebaseFirestore.instance
                                  .collection('interests')
                                  .add({
                                'uid': currentUser!.uid,
                                'name': interest,
                              });
                            }

                            // Show a snackbar or toast message to indicate that the interests are added
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Interests Added Successfully!'),
                              ),
                            );

                            // Clear selected interests
                            setState(() {
                              selectedInterests.clear();
                            });
                          },
                          child: Text('Add Interests'),
                        ),
                      ],
                    ),
                    SizedBox(height: 32.0),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Trips:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8.0),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('trips')
                                    .where('uid', isEqualTo: currentUser!.uid)
                                    .snapshots(),
                                builder: (context, tripSnapshot) {
                                  if (tripSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  }

                                  if (tripSnapshot.hasError) {
                                    return Text('Error: ${tripSnapshot.error}');
                                  }

                                  final tripDocs = tripSnapshot.data!.docs;
                                  if (tripDocs.isEmpty) {
                                    return Text('No trips added yet.');
                                  }

                                  final trips = tripDocs
                                      .map((doc) => doc['place'])
                                      .toList();

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: trips.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(trips[index]),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Interests:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8.0),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('interests')
                                    .where('uid', isEqualTo: currentUser!.uid)
                                    .snapshots(),
                                builder: (context, interestSnapshot) {
                                  if (interestSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  }

                                  if (interestSnapshot.hasError) {
                                    return Text(
                                        'Error: ${interestSnapshot.error}');
                                  }

                                  final interestDocs =
                                      interestSnapshot.data!.docs;
                                  if (interestDocs.isEmpty) {
                                    return Text('No interests added yet.');
                                  }

                                  final interests = interestDocs
                                      .map((doc) => doc['name'])
                                      .toList();

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: interests.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(interests[index]),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}
