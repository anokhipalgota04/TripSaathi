// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gonomad/features/auth/screen/login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import 'package:gonomad/apis/apis.dart';
import 'package:gonomad/helper/dialogs.dart';
import 'package:gonomad/models/chat_user.dart';

//profile screen -- to show signed in user info
class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ProfileScreen({
    super.key,
    required this.user, required String uid,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _image;

  @override
  Widget build(BuildContext context) {
    // Get MediaQuery object
    MediaQueryData mediaQuery = MediaQuery.of(context);

    // Extract screen width and height
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Profile Screen')),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.redAccent,
            onPressed: () async {
              //for showing progress dialog
              Dialogs.showProgressBar(context);

              await APIs.updateActiveStatus(false);

              //sign out from app
              await APIs.auth.signOut().then((value) async {
                await GoogleSignIn().signOut().then((value) {
                  //for hiding progress dialog
                  Navigator.pop(context);

                  //for moving to home screen
                  Navigator.pop(context);

                  APIs.auth = FirebaseAuth.instance;

                  //replacing home screen with login screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                });
              });
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * .05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(width: screenWidth, height: screenHeight * .03),
                  //user profile picture
                  Stack(
                    children: [
                      //profile picture
                      _image != null
                          ? ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(screenHeight * .1),
                              child: Image.file(
                                File(_image!),
                                width: screenHeight * .2,
                                height: screenHeight * .2,
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(screenHeight * .1),
                              child: CachedNetworkImage(
                                width: screenHeight * .2,
                                height: screenHeight * .2,
                                fit: BoxFit.cover,
                                imageUrl: widget.user.image,
                                errorWidget: (context, url, error) =>
                                    const CircleAvatar(
                                        child: Icon(CupertinoIcons.person)),
                              ),
                            ),

                      //edit image button
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: MaterialButton(
                          elevation: 1,
                          onPressed: () {
                            _showBottomSheet();
                          },
                          shape: const CircleBorder(),
                          color: Colors.white,
                          child: const Icon(Icons.edit, color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: screenHeight * .03),
                  // user email label
                  Text(
                    widget.user.email,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: screenHeight * .05),
                  // name input field
                  TextFormField(
                    initialValue: widget.user.name,
                    onSaved: (val) => APIs.me.name = val ?? '',
                    validator: (val) =>
                        val != null && val.isNotEmpty ? null : 'Required Field',
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person, color: Colors.blue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'eg. Happy Singh',
                      labelText: 'Name',
                    ),
                  ),
                  SizedBox(height: screenHeight * .02),
                  // about input field
                  TextFormField(
                    initialValue: widget.user.about,
                    onSaved: (val) => APIs.me.about = val ?? '',
                    validator: (val) =>
                        val != null && val.isNotEmpty ? null : 'Required Field',
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.info_outline, color: Colors.blue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'eg. Feeling Happy',
                      labelText: 'About',
                    ),
                  ),
                  SizedBox(height: screenHeight * .05),
                  // update profile button
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      minimumSize: Size(screenWidth * .5, screenHeight * .06),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        APIs.updateUserInfo().then((value) {
                          Dialogs.showSnackbar(
                              context, 'Profile Updated Successfully!');
                        });
                      }
                    },
                    icon: const Icon(Icons.edit, size: 28),
                    label: const Text(
                      'UPDATE',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * .03,
            bottom: MediaQuery.of(context).size.height * .05,
          ),
          children: [
            const Text(
              'Pick Profile Picture',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * .3,
                      MediaQuery.of(context).size.height * .15,
                    ),
                  ),
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();

                    final XFile? image = await picker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 80,
                    );
                    if (image != null) {
                      log('Image Path: ${image.path}');
                      setState(() {
                        _image = image.path;
                      });

                      APIs.updateProfilePicture(File(_image!));
                      Navigator.pop(context);
                    }
                  },
                  child: Image.asset('images/add_image.png'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * .3,
                      MediaQuery.of(context).size.height * .15,
                    ),
                  ),
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();

                    final XFile? image = await picker.pickImage(
                      source: ImageSource.camera,
                      imageQuality: 80,
                    );
                    if (image != null) {
                      log('Image Path: ${image.path}');
                      setState(() {
                        _image = image.path;
                      });

                      APIs.updateProfilePicture(File(_image!));
                      Navigator.pop(context);
                    }
                  },
                  child: Image.asset('images/camera.png'),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
