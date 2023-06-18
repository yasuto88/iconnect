import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/post_models.dart';
part 'replyComments.g.dart';

@riverpod
class ReplyCommentsNotifier extends _$ReplyCommentsNotifier {
  @override
  Future<List<PostData>> build(id) async {
    final document =
        await FirebaseFirestore.instance.collection('posts').doc(id).get();
    List<dynamic> comments = document.data()?['comments'];

    final postModels = await Future.wait(comments
        .map((commentId) async {
          final FirebaseFirestore firestore = FirebaseFirestore.instance;
          final CollectionReference postsCollection =
              firestore.collection('comments');
          final QuerySnapshot post = await postsCollection
              .where('commentId', isEqualTo: commentId)
              .get();
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
              desc, likes, comments, image, subject, uid, commentId, imagePath);
        })
        .toList()
        .reversed);

    return postModels;
  }

  void updateReplyComments() async {
    state = const AsyncValue.loading();
    final document =
        await FirebaseFirestore.instance.collection('posts').doc(id).get();
    List<dynamic> comments = document.data()?['comments'];

    final postModels = await Future.wait(comments
        .map((commentId) async {
          final FirebaseFirestore firestore = FirebaseFirestore.instance;
          final CollectionReference postsCollection =
              firestore.collection('comments');
          final QuerySnapshot post = await postsCollection
              .where('commentId', isEqualTo: commentId)
              .get();
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
              desc, likes, comments, image, subject, uid, commentId, imagePath);
        })
        .toList()
        .reversed);
    state = AsyncValue.data(postModels);
  }
}
