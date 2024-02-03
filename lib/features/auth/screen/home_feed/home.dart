import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class InstagramHome extends StatefulWidget {
  @override
  _InstagramHomeState createState() => _InstagramHomeState();
}

class _InstagramHomeState extends State<InstagramHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Connect',textAlign: TextAlign.center,

          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Billabong',
            fontSize: 32.0,
            
            
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            color: Colors.black,
            onPressed: () {
              // Handle action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10, // Number of stories
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 35.0,
                      backgroundColor: Colors.blue,
                      // You can load profile images here
                    ),
                  );
                },
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
            // Populate posts using PostWidget
            PostWidget(),
            PostWidget(),
            // Add more PostWidget as needed
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          leading: CircleAvatar(
            radius: 20.0,
            // You can load user profile images here
          ),
          title: Text('Username'),
          subtitle: Text('Location'),
          trailing: Icon(Icons.more_vert),
        ),
        Container(
          height: 300.0,
          width: double.infinity,
          color: Colors.grey,
          // You can load post images here
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.favorite_border),
                  SizedBox(width: 8.0),
                  Icon(Icons.comment),
                  SizedBox(width: 8.0),
                  Icon(Icons.send),
                ],
              ),
              Icon(Icons.bookmark_border),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Liked by user1, user2, and 100 others',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text(
                'Username',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8.0),
              Text('Caption text'),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'View all 50 comments',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 15.0,
                // You can load user profile images here
              ),
              const SizedBox(width: 8.0),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Add a comment...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  // Handle comment submission
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '2 hours ago',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
