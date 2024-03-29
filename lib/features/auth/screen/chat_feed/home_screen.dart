// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:gonomad/apis/apis.dart';
import 'package:gonomad/features/auth/screen/chat_feed/person_list.dart';
import 'package:gonomad/features/auth/screen/home_feed/navbar.dart';
import 'package:gonomad/helper/dialogs.dart';
import 'package:gonomad/models/chat_user.dart';
import 'package:gonomad/widgets/chat_user_card.dart';
import 'profile_screen.dart';
// Import the personal feed screen

// home screen -- where all available contacts are shown
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  //String? get uid => FirebaseAuth.instance.currentUser!.uid;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // for storing all users
  List<ChatUser> _list = [];

  // for storing searched items
  final List<ChatUser> _searchList = [];
  // for storing search status
  bool _isSearching = false;

  // Tab controller
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();

    // Initialize tab controller with 2 tabs
    _tabController = TabController(length: 2, vsync: this);

    // for updating user active status according to lifecycle events
    // resume -- active or online
    // pause  -- inactive or offline
    SystemChannels.lifecycle.setMessageHandler((message) {
      log('Message: $message');

      if (APIs.auth.currentUser != null) {
        if (message.toString().contains('resume')) {
          APIs.updateActiveStatus(true);
        }
        if (message.toString().contains('pause')) {
          APIs.updateActiveStatus(false);
        }
      }

      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context); // MediaQueryData added here

    return GestureDetector(
      // for hiding keyboard when a tap is detected on screen
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        // if search is on & back button is pressed then close search
        // or else simple close current screen on back button click
        onWillPop: () {
          if (_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          // app bar
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(CupertinoIcons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PersonalFeed()),
                );
              },
            ),
            title: _isSearching
                ? TextField(
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: 'Name, Email, ...'),
                    autofocus: true,
                    style: const TextStyle(fontSize: 17, letterSpacing: 0.5),
                    // when search text changes then updated search list
                    onChanged: (val) {
                      // search logic
                      _searchList.clear();

                      for (var i in _list) {
                        if (i.name.toLowerCase().contains(val.toLowerCase()) ||
                            i.email.toLowerCase().contains(val.toLowerCase())) {
                          _searchList.add(i);
                          setState(() {
                            _searchList;
                          });
                        }
                      }
                    },
                  )
                : const Text('We Chat'),
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat), // Icon for Chats tab
                      SizedBox(
                          width: 5), // Adjust the spacing between icon and text
                      Text('Chats'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.group), // Icon for Groups tab
                      SizedBox(
                          width: 5), // Adjust the spacing between icon and text
                      Text('Groups'),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              // search user button
              IconButton(
                onPressed: () {
                  setState(() {
                    _isSearching = !_isSearching;
                  });
                },
                icon: const Icon(Icons.search),
              ),
              // more features button
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProfileScreen(user: APIs.me),
                    ),
                  );
                },
                icon: const Icon(Icons.more_vert),
              )
            ],
          ),

          // floating button to add new user
          // floatingActionButton: Padding(
          //   padding: const EdgeInsets.only(bottom: 10),
          //   child: FloatingActionButton(
          //       onPressed: () {
          //         _addChatUserDialog();
          //       },
          //       child: const Icon(Icons.add_comment_rounded)),
          // ),

          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FloatingActionButton(
              
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const PersonList()));
                },
                child: const Icon(Icons.add_comment_rounded)),
          ),

          // body
          body: TabBarView(
            controller: _tabController,
            children: [
              // Chats tab
              StreamBuilder(
                stream: APIs.getMyUsersId(),

                // get id of only known users
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    // if data is loading
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(child: CircularProgressIndicator());

                    // if some or all data is loaded then show it
                    case ConnectionState.active:
                    case ConnectionState.done:
                      return StreamBuilder(
                        stream: APIs.getAllUsers(
                            snapshot.data?.docs.map((e) => e.id).toList() ??
                                []),

                        // get only those user, who's ids are provided
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            // if data is loading
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                            // return const Center(
                            //     child: CircularProgressIndicator());

                            // if some or all data is loaded then show it
                            case ConnectionState.active:
                            case ConnectionState.done:
                              final data = snapshot.data?.docs;
                              _list = data
                                      ?.map((e) => ChatUser.fromJson(e.data()))
                                      .toList() ??
                                  [];

                              if (_list.isNotEmpty) {
                                return ListView.builder(
                                    itemCount: _isSearching
                                        ? _searchList.length
                                        : _list.length,
                                    padding: EdgeInsets.only(
                                        top: mq.size.height *
                                            .01), // Changed mq.height to mq.size.height
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return ChatUserCard(
                                          user: _isSearching
                                              ? _searchList[index]
                                              : _list[index]);
                                    });
                              } else {
                                return const Center(
                                  child: Text('No Connections Found!',
                                      style: TextStyle(fontSize: 20)),
                                );
                              }
                          }
                        },
                      );
                  }
                },
              ),
              // Groups tab
              ListView(
                children: [
                  ListTile(
                    leading:
                        const Icon(Icons.add), // Icon for Create Group option
                    title: const Text('Create Group'),
                    onTap: () {
                      _createGroup(context);
                    },
                  ),
                  // Add more list items here if needed
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // for adding new chat user
  void _addChatUserDialog() {
    String email = '';

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: const EdgeInsets.only(
                  left: 24, right: 24, top: 20, bottom: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),

              // title
              title: const Row(
                children: [
                  Icon(
                    Icons.person_add,
                    color: Colors.blue,
                    size: 28,
                  ),
                  Text('  Add User')
                ],
              ),

              // content
              content: TextFormField(
                maxLines: null,
                onChanged: (value) => email = value,
                decoration: InputDecoration(
                    hintText: 'Email Id',
                    prefixIcon: const Icon(Icons.email, color: Colors.blue),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),

              // actions
              actions: [
                // cancel button
                MaterialButton(
                    onPressed: () {
                      // hide alert dialog
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel',
                        style: TextStyle(color: Colors.blue, fontSize: 16))),

                // add button
                MaterialButton(
                    onPressed: () async {
                      // hide alert dialog
                      Navigator.pop(context);
                      if (email.isNotEmpty) {
                        await APIs.addChatUser(email).then((value) {
                          if (!value) {
                            Dialogs.showSnackbar(
                                context, 'User does not Exists!');
                          }
                        });
                      }
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ))
              ],
            ));
  }

  void _createGroup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create Group'),
          content: const TextField(
            decoration: InputDecoration(hintText: 'Enter group name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add your logic to create a group here
                // You can use the entered group name from the TextField
                // After creating the group, you can close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }
}
