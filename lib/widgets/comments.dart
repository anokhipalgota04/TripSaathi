// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:gonomad/widgets/comments_card.dart';

// class CommentsScreen extends StatefulWidget {
//   const CommentsScreen({super.key});

//   @override
//   State<CommentsScreen> createState() => _CommentsScreenState();
// }

// class _CommentsScreenState extends State<CommentsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Comments'),
//       ),
//       body: CommentCard(),
//       bottomNavigationBar: SafeArea(
//         child: Container(
//           height: kToolbarHeight,
//           margin: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//           ),
//           padding: const EdgeInsets.only(left: 16, right: 8),
//           child: Row(children: [
//             CircleAvatar(
//               backgroundImage: CachedNetworkImage(imageUrl: '', ),
//             radius: 18,),

//             // Textfield for adding comments
//             const Expanded(
//               child: Center(
//                 child: Padding(
//                   padding: EdgeInsets.only(left:18.0, right: 8),
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Add a comment...',
                     
                  
//                     ), 
//                   ),
//                 ),
//               ),
//             ),
//             IconButton(onPressed: (){}, icon: const Icon(Icons.send_rounded))
//           ]),
//         ),
//       ),
//     );
//   }
// }
