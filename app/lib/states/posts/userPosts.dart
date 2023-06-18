import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/post_models.dart';
part 'userPosts.g.dart';

@riverpod
class UserPostsNotifier extends _$UserPostsNotifier {
  @override
  Future<List<PostData>> build(List posts) async {
    final postModels = await Future.wait(posts
        .map((postId) async {
          final FirebaseFirestore firestore = FirebaseFirestore.instance;
          final CollectionReference postsCollection =
              firestore.collection('posts');
          final QuerySnapshot post =
              await postsCollection.where('postId', isEqualTo: postId).get();
          final DocumentSnapshot document = post.docs.first;
          final data = document.data() as Map<String, dynamic>;

          String desc = data['desc'] as String;
          List likes = data['likes'] as List;
          List comments = data['comments'] as List;
          String image = data['image'] as String;
          String imagePath = data['imagePath'] as String;
          String subject = data['subject'] as String;
          String uid = data['uid'] as String;

          return PostData(
              desc, likes, comments, image, subject, uid, postId, imagePath);
        })
        .toList()
        .reversed);

    return postModels;
  }

  void updateUserPosts() async {
    state = const AsyncValue.loading();
    final postModels = await Future.wait(posts
        .map((postId) async {
          final FirebaseFirestore firestore = FirebaseFirestore.instance;
          final CollectionReference postsCollection =
              firestore.collection('posts');
          final QuerySnapshot post =
              await postsCollection.where('postId', isEqualTo: postId).get();
          final DocumentSnapshot document = post.docs.first;
          final data = document.data() as Map<String, dynamic>;

          String desc = data['desc'] as String;
          List likes = data['likes'] as List;
          List comments = data['comments'] as List;
          String image = data['image'] as String;
          String imagePath = data['imagePath'] as String;
          String subject = data['subject'] as String;
          String uid = data['uid'] as String;

          return PostData(
              desc, likes, comments, image, subject, uid, postId, imagePath);
        })
        .toList()
        .reversed);
    state = AsyncValue.data(postModels);
  }
}
