// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gonomad/core/community/constants/error.dart';
import 'package:gonomad/core/community/constants/loader.dart';
import 'package:gonomad/core/community/controllers/community_controller..dart';
import 'package:gonomad/core/community/screens/community_Profile_screen.dart';

class SearchCommunityDelegate extends SearchDelegate {
  final WidgetRef ref;
  SearchCommunityDelegate({
    required this.ref,
  });
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return const SizedBox();
  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  // return ref.watch(searchCommunityProvider(query)).when(
  //       data: (communities) => ListView.builder(
  //             itemCount: communities.length,
  //             itemBuilder: (BuildContext context, int index) {
  //               final community = communities[index];
  //               return ListTile(
  //                 leading: CircleAvatar(
  //                   backgroundImage: NetworkImage(community.avator),
  //                 ),
  //                 title: Text('r/${community.name}'),
  //                 onTap: () => navigateToCommunity(context, community.name),
  //               );
  //             },
  //           ),
  //       error: (error, StackTrace) => ErrorText(error: error.toString()),
  //       loading: () => const Loader());
  // }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ref.watch(searchCommunityProvider(query)).when(
          data: (communities) {
            return ListView.builder(
              itemCount: communities.length,
              itemBuilder: (BuildContext context, int index) {
                final community = communities[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(community.avator),
                  ),
                  title: Text('r/${community.name}'),
                  onTap: () => navigateToCommunity(context, community.name),
                );
              },
            );
          },
          error: (error, StackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }

  void navigateToCommunity(BuildContext context, String communityName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommunityScreen(name: communityName),
      ),
    );
  }
}
