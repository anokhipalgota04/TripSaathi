// import 'dart:ui';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:gonomad/features/auth/screen/profile_screen.dart';

// import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
// import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({Key? key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   bool isShowUsers = false;

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: TextFormField(
//           controller: _searchController,
//           decoration: const InputDecoration(
//             labelText: 'Search for a user',
//           ),
//           onFieldSubmitted: (_) {
//             setState(() {
//               isShowUsers = true;
//             });
//           },
//         ),
//         flexibleSpace: ClipRect(
//           child: BackdropFilter(
//             filter: ImageFilter.blur(
//               sigmaX: 9,
//               sigmaY: 9,
//             ),
//             child: Container(
//               color: Colors.white.withOpacity(0.7),
//             ),
//           ),
//         ),
//       ),
//       body: isShowUsers
//           ? FutureBuilder<QuerySnapshot>(
//               future: FirebaseFirestore.instance
//                   .collection('users')
//                   .where('username',
//                       isGreaterThanOrEqualTo: _searchController.text)
//                   .get(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return const Center(child: Text('No users found.'));
//                 }
//                 return ListView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (context, index) {
//                     final userData = snapshot.data!.docs[index].data()
//                         as Map<String, dynamic>;
//                     return InkWell(
//                       onTap: () => Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => ProfileScreen(
//                             uid: userData['uid'],
//                           ),
//                         ),
//                       ),
//                       child: ListTile(
//                         leading:
//                             userData != null && userData['photoUrl'] != null
//                                 ? CircleAvatar(
//                                     radius: 64,
//                                     backgroundImage: CachedNetworkImageProvider(
//                                         userData['photoUrl']),
//                                   )
//                                 : CircleAvatar(
//                                     radius: 64,
//                                     child: Icon(Icons.account_circle,
//                                         size:
//                                             64), // Placeholder icon if photoUrl is null
//                                   ),
//                         title: Text(
//                           userData['username'],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             )
//           : FutureBuilder<QuerySnapshot>(
//               future: FirebaseFirestore.instance.collection('posts').get(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return const Center(child: Text('No posts found.'));
//                 }
//                 return StaggeredGridView.countBuilder(
//                   shrinkWrap: true,
//                   crossAxisCount: 3,
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (context, index) {
//                     final post = snapshot.data!.docs[index].data()
//                         as Map<String, dynamic>;
//                     return CachedNetworkImage(
//                       imageUrl: post['postUrl'],
//                       fit: BoxFit.cover,
//                       placeholder: (context, url) =>
//                           const Center(child: CircularProgressIndicator()),
//                       errorWidget: (context, url, error) =>
//                           const Icon(Icons.error),
//                     );
//                   },
//                   staggeredTileBuilder: (index) => StaggeredTile.count(
//                     index % 7 == 0 ? 2 : 1,
//                     index % 7 == 0 ? 2 : 1,
//                   ),
//                   mainAxisSpacing: 4,
//                   crossAxisSpacing: 4,
//                 );
//               },
//             ),
//     );
//   }
// }

// // ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gonomad/models/user.dart';
import 'package:gonomad/providers/user_provider.dart';
import 'package:gonomad/resources/firestore_methods.dart';
import 'package:gonomad/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  void postImage(
    String uid,
    String username,
    String profileImage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
          _descriptionController.text, _file!, uid, username, profileImage);
      if (res == "success") {
        setState(() {
          _isLoading = false;
          _descriptionController.clear();
        });
        clearImage();
        showSnackBar(
          "Post Uploaded",
          context,
        );
        //  _descriptionController.clear();
        // setState(() {
        //   _file = null;
        // });
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(
          res,
          context,
        );
      }
    } catch (err) {
      showSnackBar(err.toString(), context);
    }
  }

  _selectImage(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          alignment: Alignment.center,
          title: const Text(
            'Create Post',
          ),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              onPressed: () async {
                Navigator.pop(context);
                Uint8List? file =
                    await pickAndCompressImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
              child: const Text('Take a Photo'),
            ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
                Uint8List? file =
                    await pickAndCompressImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
              child: const Text('Choose from Gallery'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Posts'),
        actions: [
          TextButton(
            onPressed: () => postImage(user!.uid, user.username, user.photoUrl),
            child: const Text(
              "Post",
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _isLoading
                ? const LinearProgressIndicator()
                : const Padding(padding: EdgeInsets.only(top: 0)),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),

                CachedNetworkImage(
                  imageUrl: user!.photoUrl,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 32.0,
                    backgroundImage: imageProvider,
                  ),
//  placeholder: (context, url) => CircularProgressIndicator(), // Placeholder widget while loading
                  errorWidget: (context, url, error) => const Icon(
                      Icons.error), // Widget to show when loading fails
                ),

                // CircleAvatar
                //   backgroundImage: NetworkImage(user.photoUrl),
                //   radius: 30,
                // ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.66,
                  child: TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      hintText: "What's on your mind...",
                      hintStyle: GoogleFonts.kaushanScript(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 140,
            ),
            SizedBox(
              height: 350,
              width: 390,
              child: _file != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.memory(
                        _file!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : GestureDetector(
                      onTap: () => _selectImage(context),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                size: 50,
                                Icons.upload_rounded,
                                color: Colors.black,
                              ),
                              Text("Select Image To Post")
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}




  // // Stream<List<Community>> searchCommunity(String query) {
  // //   return _communities
  // //       .where(
  // //         'name',
  // //         isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
  // //         isLessThan: query.isEmpty
  // //             ? null
  // //             : query.substring(0, query.length - 1) +
  // //                 String.fromCharCode(
  // //                   query.codeUnitAt(query.length - 1) + 1,
  // //                 ),
  // //       )
  // //       .snapshots()
  // //       .map((event) {
  // //     List<Community> communities = [];
  // //     for (var community in event.docs) {
  // //       communities
  // //           .add(Community.fromMap(community.data() as Map<String, dynamic>));
  // //     }
  // //     return communities;
  // //   });
  // // }


// Stream<List<Community>> searchCommunityAutoSuggest(String query) {
//   // Check if the query is empty
//   if (query.isEmpty) {
//     // Return an empty stream if the query is empty
//     return Stream.value([]);
//   }

//   // Create a controller to manage the stream
//   final controller = StreamController<List<Community>>();

//   // Perform the Firestore query for auto-suggestions
//   _communities
//       .where('name', isGreaterThanOrEqualTo: query)
//       .where('name', isLessThan: query + 'z') // Add a boundary for suggestions
//       .limit(10) // Limit the number of suggestions to 10
//       .snapshots()
//       .listen((event) {
//     // List to store suggested communities
//     List<Community> suggestions = [];
    
//     // Iterate through the documents returned by the query
//     for (var doc in event.docs) {
//       // Create a community object from the document data
//       var communityData = doc.data() as Map<String, dynamic>;
//       var community = Community.fromMap(communityData);
      
//       // Add the community to suggestions list
//       suggestions.add(community);
//     }

//     // Add the suggestions to the stream
//     controller.add(suggestions);
//   });

//   // Return the stream
//   return controller.stream;
// }