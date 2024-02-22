// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

  
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

  
//   @override
  
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
  
//   int _selectedIndex = 0;

//   final List<IconData> _icons = [
//     CupertinoIcons.home,
//     CupertinoIcons.news,
//     CupertinoIcons.add,
//     CupertinoIcons.location,
//     CupertinoIcons.person,
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Center(
//         child: Text(
//           'Page ${_selectedIndex + 1}',
//           style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//         ),
//       ),
//       bottomNavigationBar: _buildBottomNavigationBar(),
//     );
//   }

//   Widget _buildBottomNavigationBar() {
//     return ClipRRect(
//       borderRadius: const BorderRadius.vertical(top: Radius.circular(30),bottom: Radius.circular(30),),
//       child: Container(

//         decoration: BoxDecoration(

//           color: Colors.white.withOpacity(0.2),
//           borderRadius: const BorderRadius.vertical(top: Radius.circular(30), bottom: Radius.circular(30),),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.3),
//               spreadRadius: 1,
//               blurRadius: 10,
//             ),
//           ],
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: _buildNavigationItems(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildNavigationItems() {
//     final List<Widget> items = [];
//     for (int i = 0; i < _icons.length; i++) {
//       items.add(
//         GestureDetector(
//           onTap: () => _onItemTapped(i),
//           child: _buildNavigationItem(_icons[i], i == _selectedIndex),
//         ),
//       );
//     }
//     return items;
//   }

//   Widget _buildNavigationItem(IconData icon, bool isSelected) {
//     return Expanded(
//       child: Container(
//         height: 60,
//         child: Center(
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 300),
//             curve: Curves.easeOutQuad,
//             decoration: isSelected
//                 ? BoxDecoration(
//               gradient: const LinearGradient(
//                 colors: [
//                   Color(0xFF990099), // Deep Purple
//                   Color(0xFFff1493), // Deep Pink
//                   Color(0xFFffa500), // Light Orange
//                 ],
//                 begin: Alignment.centerLeft,
//                 end: Alignment.centerRight,
//               ),
//               borderRadius: BorderRadius.circular(30),
//             )
//                 : null,
//             padding: EdgeInsets.all(isSelected ? 14 : 12),
//             child: Icon(
//               icon,
//               color: isSelected ? Colors.white : Colors.black,
//               size: isSelected ? 24 : 20,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
// }
