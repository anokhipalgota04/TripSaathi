// import 'package:flutter/material.dart';





// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   final List<String> _posts = []; 
//   final List<String> _stories = [];

//   ScrollController _scrollController = ScrollController();
//   double _scrollOffset = 0;

//   @override
//   void initState() {
//     super.initState();
//     // Populate posts
//     for (int i = 0; i < 30; i++) {
//       _posts.add('Post $i'); 
//     }

//     // Populate stories
//     for (int i = 0; i < 10; i++) {
//        _stories.add('Story $i');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Instagram"),
//       ),
//       body: NotificationListener<ScrollNotification>(
//         onNotification: (notification) {
//           if (notification is ScrollUpdateNotification) {
//             setState(() {
//               _scrollOffset = _scrollController.offset;
//             });
//           }
//           return false;
//         },
//         child: CustomScrollView(
//           controller: _scrollController,
//           slivers: [
//             SliverToBoxAdapter(
//               child: _storiesSection(),
//             ),
//             SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   return _postItem(_posts[index]);
//                 },
//                 childCount: _posts.length,
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: _bottomNavBar(), 
//     );
//   }

//   Widget _storiesSection() {
//     return Container(
//       height: 110,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: _stories.length, 
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 Container(
//                   width: 60,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.grey[300],
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(_stories[index]),
//               ],
//             ),
//           );
//         }
//       ),
//     );
//   }

//   Widget _postItem(String post) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ListTile(
//             contentPadding: EdgeInsets.all(0),
//             leading: Container(
//               width: 50,
//               height: 50,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.grey[300],
//               ),
//             ),
//             title: Text('Username'),
//             subtitle: Text('Location'),
//             trailing: Icon(Icons.more_vert),
//           ),
//           FadeInImage(
//             placeholder: AssetImage('assets/placeholder.png'),
//             image: NetworkImage('https://picsum.photos/id/${post.hashCode}/500/500'),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.favorite_border), 
//                     onPressed: (){}
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.comment_outlined),
//                     onPressed: (){}
//                   ), 
//                   IconButton(
//                     icon: Icon(Icons.send),
//                     onPressed: (){}
//                   ),
//                 ],
//               ),
//               IconButton(
//                 icon: Icon(Icons.bookmark_border),
//                 onPressed: (){}
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Text('Liked by username and others'),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _bottomNavBar() {
//     return BottomNavigationBar(
//       items: [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.search),
//           label: 'Search',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.add_box),
//           label: 'Post',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.favorite),
//           label: 'Likes',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.account_circle),
//           label: 'Profile',
//         ),
//       ],
//     );
//   }

// }