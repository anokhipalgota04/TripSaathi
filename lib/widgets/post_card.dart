import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class PostCard extends StatelessWidget {
  final dynamic snap;

  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 21.0,
                    backgroundImage: NetworkImage(snap['profileImage']),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        snap['username'],
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
            SizedBox(
              height: 330, // Adjust the height as needed
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0), // Rounded corners
                child: CachedNetworkImage(
                  imageUrl: snap['postUrl'],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: SizedBox(
                      width: 24.0,
                      height: 24.0,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.black), // iOS style color
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.signal_wifi_statusbar_connected_no_internet_4_rounded,
                    size: 45,
                  ),
                  cacheManager: DefaultCacheManager(),
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border_rounded),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.comment_outlined),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.send_rounded),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmark_border_rounded),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${snap['likes'].length} likes',
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: snap['username'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' ${snap['description']}'),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'view all 124 comments',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Text(
                    DateFormat.yMMMMd().format(snap['datePublished'].toDate()),
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
