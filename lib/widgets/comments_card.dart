// import 'package:flutter/material.dart';

// class CommentCard extends StatefulWidget {
//   const CommentCard({super.key});

//   @override
//   State<CommentCard> createState() => _CommentCardState();
// }

// class _CommentCardState extends State<CommentCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundImage: CachedNetworkImage(
//               imageUrl: '',
//             ),
//             radius: 18,
//           ),
//           Padding(
//             padding: EdgeInsets.only(
//               left: 16,
//             ),
//             child: Column(
//               children: [
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: 'usename',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       TextSpan(
//                           text: 'description',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                           )),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                     padding: EdgeInsets.only(top: 4),
//                     child: Text(
//                       '23/2/2024',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     )),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
