import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/post_models.dart';
import '../state.dart';
part 'followingPosts.g.dart';

@riverpod
class FollowingPostsNotifier extends _$FollowingPostsNotifier {
  @override
  Future<List<PostData>> build() async {
    final user = ref.watch(userProvider);
    final uid = user!.uid;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        //.orderBy('timestamp', descending: true)
        .where('followers', arrayContains: uid)
        .get();

    List<Map<String, dynamic>> allPosts = [];

    querySnapshot.docs.forEach((doc) {
      final postData = doc.data();
      final posts = postData['posts'] as List<dynamic>;
      posts.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));
      allPosts.addAll(allPosts);
    });
    List<PostData> postModels = [];
    return postModels;
  }
}
