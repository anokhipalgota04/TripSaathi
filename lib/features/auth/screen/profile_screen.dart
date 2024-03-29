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

  @override
  void initState() {
    super.initState();
    getData();
    _tabController = TabController(length: 3, vsync: this);
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
                              color: Colors.amber,
                            ),
                            FirebaseAuth.instance.currentUser!.uid == widget.uid
                                ? Positioned(
                                    top: 10,
                                    right:
                                        12, // Adjust this value to position the icon horizontally
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
                                : SizedBox(),
                            Positioned(
                              top:
                                  150, // Adjust this value to position the avatar
                              left: MediaQuery.of(context).size.width / 2 -
                                  50, // Center the avatar horizontally
                              child: Transform.translate(
                                offset: Offset(0, -50),
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: CachedNetworkImageProvider(
                                    userData['photoUrl'],
                                  ),
                                  radius: 55,
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
                                    height: 60,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      // mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      //  crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.all(12.0),
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
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FirebaseAuth.instance.currentUser!.uid !=
                                              widget.uid
                                          ? isFollowing
                                              ? FollowButton(
                                                  text: 'Connect',
                                                  backgroundColor: Colors.blue,
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
                                                )
                                              : FollowButton(
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
                                          : SizedBox()
                                    ],
                                  ),
                                  // FirebaseAuth.instance.currentUser!.uid ==
                                  //         widget.uid
                                  //     ? Container(
                                  //         padding:
                                  //             const EdgeInsets.only(top: 2),
                                  //         child: TextButton(
                                  //           onPressed: () {
                                  //             // Navigate to the EditProfileScreen when the button is pressed
                                  //             Navigator.push(
                                  //                 context,
                                  //                 MaterialPageRoute(
                                  //                   builder: (context) =>
                                  //                       EditProfileScreen(
                                  //                           uid: widget.uid),
                                  //                 ));
                                  //           },
                                  //           child: Container(
                                  //             decoration: BoxDecoration(
                                  //               color: Colors.blue,
                                  //               border: Border.all(
                                  //                 color: Colors.grey,
                                  //               ),
                                  //               borderRadius:
                                  //                   BorderRadius.circular(5),
                                  //             ),
                                  //             alignment: Alignment.center,
                                  //             width: 250,
                                  //             height: 42,
                                  //             child: Text(
                                  //               'Edit Profile',
                                  //               style: TextStyle(
                                  //                 color: Colors.white,
                                  //                 fontWeight: FontWeight.bold,
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       )
                                  //     : SizedBox(height: 1)
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
                          _tabController.animateTo(0);
                        },
                        child: Text('Post'),
                      ),
                      TextButton(
                        onPressed: () {
                          _tabController.animateTo(1);
                        },
                        child: Text('Community'),
                      ),
                      TextButton(
                        onPressed: () {
                          _tabController.animateTo(2);
                        },
                        child: Text('About'),
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
                        buildaboutus()
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
      child: Row(
        // mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        //  crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                userData['username'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 1.0),
              child: Text(
                userData['bio'],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 1.0),
              child: Text('score = $score'),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: buildStatColumn(postLen, "posts"),
          ),
          GestureDetector(
            child: buildStatColumn(followers, "followers"),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FollowerCount(uid: widget.uid))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: buildStatColumn(following, "following"),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FollowingCount(
                            uid: widget.uid,
                          ))),
            ),
          )
        ],
      ),
    );
  }

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
            fontSize: 10,
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
                              return Center(
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
