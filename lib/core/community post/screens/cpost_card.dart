// import 'package:any_link_preview/any_link_preview.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gonomad/core/community%20post/controller/add_cpost_controller.dart';
// import 'package:gonomad/core/community/constants/error.dart';
// import 'package:gonomad/core/community/constants/loader.dart';
// import 'package:gonomad/core/community/controllers/community_controller..dart';
// import 'package:gonomad/core/community/screens/community_Profile_screen.dart';
// import 'package:gonomad/features/auth/screen/profile_screen.dart';
// import 'package:gonomad/models/cpost_model.dart';
// import 'package:routemaster/routemaster.dart';

// class CPostCard extends ConsumerWidget {
//   final Post post;
//   const CPostCard({super.key, required this.post});

//   // void deletePost(WidgetRef ref, BuildContext context) async {
//   //   ref.read(postControllerProvider.notifier).deletePost(post, context);
//   // }

//   // void upvotePost(WidgetRef ref) async {
//   //   ref.read(postControllerProvider.notifier).upvote(post);
//   // }

//   // void downvotePost(WidgetRef ref) async {
//   //   ref.read(postControllerProvider.notifier).downvote(post);
//   // }

//   //  void awardPost(WidgetRef ref, String award, BuildContext context) async {
//   //   ref.read(postControllerProvider.notifier).awardPost(post: post, award: award, context: context);
//   //}

//   // void navigateToUser(BuildContext context) {
//   //   Navigator.push(
//   //     context,
//   //     MaterialPageRoute(
//   //         builder: (context) =>ProfileScreen(currentUser.ui),
//   //   );

//   //   // Routemaster.of(context).push('/u/${post.uid}');

//   // }

//   void navigateToCommunity(BuildContext context) {
//     Routemaster.of(context).push('/r/${post.communityName}');
//   }

//   void navigateToComments(BuildContext context) {
//     Routemaster.of(context).push('/post/${post.id}/comments');
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isTypeImage = post.type == 'image';
//     final isTypeText = post.type == 'text';
//     final isTypeLink = post.type == 'link';

//     final FirebaseAuth _auth = FirebaseAuth.instance;
//     final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//     var userData = {};
//     User currentUser = _auth.currentUser!;

//     void get() async {
//       var userSnap = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(currentUser.uid)
//           .get();
//       userData = userSnap.data()!;
//     }

//     // final  currenttheme =ref.watch(themeNotifierProvider);
//     // final user= ref.watch(userProvider)!;
//     //  final isGuest =!user.isAuthenticated;
//     return Column(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             color: Color.fromARGB(255, 0, 0, 0),
//             // color: currenttheme.colorScheme.background,
//           ),
//           padding: EdgeInsets.symmetric(vertical: 10),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                               vertical: 4, horizontal: 16)
//                           .copyWith(right: 0),
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     GestureDetector(
//                                       onTap: () {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 CommunityScreen(
//                                                     name: post.communityName),
//                                           ),
//                                         );
//                                       },
//                                       child: CircleAvatar(
//                                         backgroundImage: NetworkImage(
//                                             post.communityProfilePic),
//                                         radius: 16,
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 8),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             'ts/${post.communityName}',
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.white),
//                                           ),
//                                           GestureDetector(
//                                             onTap: () {
//                                               Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         ProfileScreen(
//                                                           uid: currentUser.uid,
//                                                         )),
//                                               );
//                                             },
//                                             child: Text(
//                                               'u/${post.username}',
//                                               style: TextStyle(
//                                                   fontSize: 12,
//                                                   color: Colors.white),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 if (post.uid == currentUser.uid)
//                                   IconButton(
//                                       onPressed: () {
//                                         //deletePost(ref, context);
//                                       },
//                                       icon: Icon(
//                                         Icons.delete,
//                                         color: Colors.white,
//                                       ))
//                               ],
//                             ),
//                             if (post.awards.isNotEmpty) ...[
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               SizedBox(
//                                 height: 25,
//                                 child: ListView.builder(
//                                     scrollDirection: Axis.horizontal,
//                                     itemCount: post.awards.length,
//                                     itemBuilder:
//                                         (BuildContext context, int index) {
//                                       final award = post.awards[index];
//                                       ////  return Image.asset(
//                                       // Constants.awards[award]!,
//                                       //height: 23,
//                                       //    );
//                                     }),
//                               )
//                             ],
//                             Padding(
//                               padding: const EdgeInsets.only(top: 10.0),
//                               child: Text(
//                                 post.title,
//                                 style: TextStyle(
//                                     fontSize: 19,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                               ),
//                             ),
//                             if (isTypeImage)
//                               SizedBox(
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.30,
//                                 width: double.infinity,
//                                 child: Image.network(post.link!,
//                                     fit: BoxFit.cover),
//                               ),
//                             if (isTypeLink)
//                               SizedBox(
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.15,
//                                   width: double.infinity,
//                                   child: AnyLinkPreview(
//                                     displayDirection:
//                                         UIDirection.uiDirectionHorizontal,
//                                     link: post.link!,
//                                   )),
//                             if (isTypeText)
//                               Container(
//                                 alignment: Alignment.bottomLeft,
//                                 child: Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(horizontal: 5),
//                                   child: Text(
//                                     post.description ?? '',
//                                     style: const TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                               ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     IconButton(
//                                       onPressed: () {},
//                                       icon: Icon(Icons.thumb_up_off_alt_rounded,
//                                           size: 25,
//                                           color: post.upvotes
//                                                   .contains(currentUser.uid)
//                                               ? Color.fromARGB(255, 20, 6, 36)
//                                               : Colors.green),
//                                     ),
//                                     Text(
//                                       '${post.upvotes.length - post.downvotes.length == 0 ? 'Vote' : post.upvotes.length - post.downvotes.length}',
//                                       style: TextStyle(fontSize: 17),
//                                     ),
//                                     IconButton(
//                                       onPressed: () {},
//                                       icon: Icon(Icons.thumb_down,
//                                           size: 25,
//                                           color: post.downvotes
//                                                   .contains(currentUser.uid)
//                                               ? Colors.blue
//                                               : Colors.red),
//                                     )
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     IconButton(
//                                       onPressed: () =>
//                                           navigateToComments(context),
//                                       icon: Icon(Icons.comment,
//                                           color: Colors.white),
//                                     ),
//                                     Text(
//                                       '${post.commentCount == 0 ? 'Comment' : post.commentCount}',
//                                       style: TextStyle(fontSize: 17),
//                                     ),
//                                   ],
//                                 ),
//                                 ref
//                                     .watch(getCommunityByNameProvider(
//                                         post.communityName))
//                                     .when(
//                                         data: (data) {
//                                           if (data.mods
//                                               .contains(currentUser.uid)) {
//                                             return IconButton(
//                                               onPressed: () {},
//                                               //  deletePost(ref, context),
//                                               icon: Icon(
//                                                 Icons.admin_panel_settings,
//                                               ),
//                                             );
//                                           }
//                                           return SizedBox();
//                                         },
//                                         error: ((error, stackTrace) =>
//                                             ErrorText(error: error.toString())),
//                                         loading: () => Loader()),
//                                 IconButton(
//                                   onPressed: () {},
//                                   icon: Icon(
//                                     Icons.card_giftcard_outlined,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ]),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }

import 'package:any_link_preview/any_link_preview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gonomad/core/community%20post/controller/add_cpost_controller.dart';
import 'package:gonomad/core/community%20post/screens/Ccomments_screen.dart';
import 'package:gonomad/core/community/constants/error.dart';
import 'package:gonomad/core/community/constants/loader.dart';
import 'package:gonomad/core/community/controllers/community_controller..dart';
import 'package:gonomad/core/community/screens/community_Profile_screen.dart';
import 'package:gonomad/features/auth/screen/profile_screen.dart';
import 'package:gonomad/models/cpost_model.dart';
import 'package:routemaster/routemaster.dart';

class CPostCard extends ConsumerWidget {
  final Post post;
  const CPostCard({super.key, required this.post});

  void deletePost(WidgetRef ref, BuildContext context) async {
    ref.read(postControllerProvider.notifier).deletePost(post, context);
  }

  void upvotePost(WidgetRef ref) async {
    ref.read(postControllerProvider.notifier).upvote(post);
  }

  void downvotePost(WidgetRef ref) async {
    ref.read(postControllerProvider.notifier).downvote(post);
  }

  void showDeleteConfirmationDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm"),
          content: Text("Are you sure you want to delete this post?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "No",
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                deletePost(ref, context);

                // ref.read(postControllerProvider.notifier).deletePost(post, context);
                Navigator.of(context).pop();
              },
              child: Text(
                "Yes",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTypeImage = post.type == 'image';
    final isTypeText = post.type == 'text';
    final isTypeLink = post.type == 'link';

    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    var userData = {};
    User currentUser = _auth.currentUser!;

    void get() async {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      userData = userSnap.data()!;
    }

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 230, 231, 232),
          ),
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 16)
                          .copyWith(right: 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CommunityScreen(
                                                    name: post.communityName),
                                          ),
                                        );
                                      },
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            post.communityProfilePic),
                                        radius: 16,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'ts/${post.communityName}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 12, 12, 12)),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfileScreen(
                                                          uid: currentUser.uid,
                                                        )),
                                              );
                                            },
                                            child: Text(
                                              'u/${post.username}',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                if (post.uid == currentUser.uid)
                                  IconButton(
                                    onPressed: () {
                                      showDeleteConfirmationDialog(
                                          context, ref);
                                    },
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                              ],
                            ),
                            if (post.awards.isNotEmpty) ...[
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: 25,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: post.awards.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final award = post.awards[index];
                                      ////  return Image.asset(
                                      // Constants.awards[award]!,
                                      //height: 23,
                                      //    );
                                    }),
                              )
                            ],
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                post.title,
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                            if (isTypeImage)
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.30,
                                width: double.infinity,
                                child: Image.network(post.link!,
                                    fit: BoxFit.cover),
                              ),
                            if (isTypeLink)
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  width: double.infinity,
                                  child: AnyLinkPreview(
                                    displayDirection:
                                        UIDirection.uiDirectionHorizontal,
                                    link: post.link!,
                                  )),
                            if (isTypeText)
                              Container(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    post.description ?? '',
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ),
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => upvotePost(ref),
                                      icon: Icon(Icons.thumb_up_off_alt_rounded,
                                          size: 25,
                                          color: post.upvotes
                                                  .contains(currentUser.uid)
                                              ? Color.fromARGB(255, 18, 152, 56)
                                              : Color.fromARGB(
                                                  255, 10, 10, 10)),
                                    ),
                                    Text(
                                      '${post.upvotes.length - post.downvotes.length == 0 ? 'Vote' : post.upvotes.length - post.downvotes.length}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0)),
                                    ),
                                    IconButton(
                                      onPressed: () => downvotePost(ref),
                                      icon: Icon(Icons.thumb_down,
                                          size: 25,
                                          color: post.downvotes
                                                  .contains(currentUser.uid)
                                              ? Color.fromARGB(255, 200, 25, 9)
                                              : Color.fromARGB(255, 0, 0, 0)),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return CCommentsScreen(
                                                postId: post
                                                    .id); // Pass the postId to CCommentsScreen
                                          },
                                        );
                                      },
                                      //  navigateToComments(context),
                                      icon: const Icon(Icons.comment,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                    Text(
                                      '${post.commentCount == 0 ? 'Comment' : post.commentCount}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0)),
                                    ),
                                  ],
                                ),
                                ref
                                    .watch(getCommunityByNameProvider(
                                        post.communityName))
                                    .when(
                                        data: (data) {
                                          if (data.mods
                                              .contains(currentUser.uid)) {
                                            return IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CommunityScreen(
                                                            name: post
                                                                .communityName),
                                                  ),
                                                );
                                              },
                                              //  deletePost(ref, context),
                                              icon: const Icon(
                                                  Icons.admin_panel_settings,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0)),
                                            );
                                          }
                                          return const SizedBox();
                                        },
                                        error: ((error, stackTrace) =>
                                            ErrorText(error: error.toString())),
                                        loading: () => const Loader()),
                                // IconButton(
                                //   onPressed: () {},
                                //   icon: Icon(
                                //     Icons.card_giftcard_outlined,
                                //   ),
                                // ),
                              ],
                            ),
                          ]),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              )
            ],
          ),
        )
      ],
    );
  }
}
