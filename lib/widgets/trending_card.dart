import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gonomad/models/user.dart';
import 'package:gonomad/providers/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';

class TrendingCard extends StatefulWidget {
  final dynamic snap;

  const TrendingCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<TrendingCard> createState() => _TrendingCardState();
}

class _TrendingCardState extends State<TrendingCard> {
  late Stream<QuerySnapshot> commentsStream;

  @override
  void initState() {
    super.initState();
    commentsStream = FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.snap['postId'])
        .collection('comments')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(_createRoute());
      },
      child: Container(
        height: 150, // Fixed height for the card container
        width: double.infinity, // Set width to fill available space
        child: Card(
          elevation: 4,
          margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10), // Reduced space between cards
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side: Picture
              Hero(
                tag: 'image_${widget.snap['postId']}', // Unique tag for each image
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    bottomLeft: Radius.circular(12.0),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.snap['postUrl'],
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[200],
                      width: 150,
                      height: 150,
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error_outline,
                      size: 45,
                    ),
                    cacheManager: DefaultCacheManager(),
                  ),
                ),
              ),
              SizedBox(width: 12), // Spacer between image and text

              // Right side: Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Add padding to the description text
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Flexible(
                        child: SingleChildScrollView(
                          child: Text(
                            widget.snap['description'],
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(), // Spacer to push the date text to the bottom
                    // Date text aligned to the bottom right
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                      child: Text(
                        DateFormat.yMMMMd().format(
                          widget.snap['datePublished'].toDate(),
                        ),
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return FullImagePage(
          imageUrl: widget.snap['postUrl'],
          postId: widget.snap['postId'],
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}

class FullImagePage extends StatelessWidget {
  final String imageUrl;
  final String postId;

  const FullImagePage({Key? key, required this.imageUrl, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'image_$postId',
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.contain,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
