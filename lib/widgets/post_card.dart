import 'package:flutter/material.dart';
import 'package:gonomad/models/user.dart';
import 'package:gonomad/providers/user_provider.dart';
import 'package:gonomad/resources/firestore_methods.dart';
import 'package:gonomad/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final dynamic snap;

  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 0, // Remove shadow to improve performance
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Rounded corners
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 2.0, 8.0, 8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 21.0,
                    backgroundImage: NetworkImage(widget.snap['profileImage']),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        widget.snap['username'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () => _showOptionsDialog(context),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onDoubleTap: () async {
                await FirestoreMethods().likePost(
                    widget.snap['postId'], user.uid, widget.snap['likes']);
                setState(() {
                  isLikeAnimating = true;
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 400,

                    width: double.infinity, // Adjust the height as needed
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(12.0), // Rounded corners
                      child: CachedNetworkImage(
                        imageUrl: widget.snap['postUrl'],
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: SizedBox(
                            width: 24.0,
                            height: 24.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 4.0,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.black), // iOS style color
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons
                              .signal_wifi_statusbar_connected_no_internet_4_rounded,
                          size: 45,
                        ),
                        cacheManager: DefaultCacheManager(),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isLikeAnimating ? 1 : 0,
                    child: LikeAnimation(
                      isAnimating: isLikeAnimating,
                      duration: const Duration(milliseconds: 400),
                      onEnd: () {
                        setState(() {
                          isLikeAnimating = false;
                        });
                      },
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 120,
                      ),
                    ),
                  )
                ],
              ),
            ),

            //like comment section
            Row(
              children: [
                LikeAnimation(
                  isAnimating: widget.snap['likes'].contains(user.uid),
                  smallLike: true,
                  child: IconButton(
                    onPressed: () async {
                      await FirestoreMethods().likePost(widget.snap['postId'],
                          user.uid, widget.snap['likes']);
                      setState(() {
                        isLikeAnimating = true;
                      });
                    },
                    icon: widget.snap['likes'].contains(user.uid)
                        ? const Icon(
                            Icons.favorite_rounded,
                            color: Colors.red,
                            size: 30,
                          )
                        : const Icon(
                            Icons.favorite_border_rounded,
                            size: 30,
                            //color: Colors.black,
                          ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.comment_outlined,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send_rounded,
                    size: 30,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark_border_rounded,
                    size: 30,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.snap['likes'].length} likes',
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: widget.snap['username'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' ${widget.snap['description']}'),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.5),
                      child: Text(
                        'view all 124 comments',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Text(
                    DateFormat.yMMMMd()
                        .format(widget.snap['datePublished'].toDate()),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Options for the post'),
        // content: const Text(''),
        actions: [
          TextButton(onPressed: () {}, child: const Text('Edit')),
          TextButton(onPressed: () {}, child: const Text('Delete')),
        ],
      ),
    );
  }
}
