// ignore_for_file: use_build_context_synchronously

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
                    radius: 30.0,
                    backgroundImage: imageProvider,
                  ),
//  placeholder: (context, url) => CircularProgressIndicator(), // Placeholder widget while loading
                  errorWidget: (context, url, error) => const Icon(
                      Icons.error), // Widget to show when loading fails
                ),

                // CircleAvatar(
                //   backgroundImage: NetworkImage(user.photoUrl),
                //   radius: 30,
                // ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.66,
                  child: TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Write your caption...',
                      hintStyle: GoogleFonts.kaushanScript(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      border: InputBorder.none,
                    ),
                    maxLines: 8,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 412,
              width: 380,
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
