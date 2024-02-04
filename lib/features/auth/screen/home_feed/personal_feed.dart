import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gonomad/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Personalfeed extends StatefulWidget {
  const Personalfeed({Key? key}) : super(key: key);

  @override
  State<Personalfeed> createState() => _PersonalfeedState();
}

class _PersonalfeedState extends State<Personalfeed> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    addData();

    // Make the system navigation gesture transparent
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  void addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChange(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Text('home'),
          Text('community'),
          Text('add post'),
          Text('maps'),
          Text('profile'),
        ],
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChange,
      ),
      bottomNavigationBar: Container(
        height: 78,
        decoration: BoxDecoration(
          color: Colors.white70.withOpacity(0.3),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: CupertinoTabBar(
            height: 78,
            border: const Border(
              top: BorderSide(
                color: Colors.white,
                width: 0.1,
              ),
            ),
            iconSize: 36,
            backgroundColor: Colors.transparent,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded,
                    color: _page == 0 ? Colors.black : Colors.black54),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group,
                    color: _page == 1 ? Colors.black : Colors.black54),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_box_outlined,
                    color: _page == 2 ? Colors.black : Colors.black54),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map,
                    color: _page == 3 ? Colors.black : Colors.black54),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle,
                    color: _page == 4 ? Colors.black : Colors.black54),
              ),
            ],
            onTap: navigationTapped,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Restore the system navigation gesture color
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: null,
      ),
    );

    pageController.dispose(); // Dispose of the page controller
    super.dispose();
  }
}
