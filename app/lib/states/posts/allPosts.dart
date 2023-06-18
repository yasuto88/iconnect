import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/post_models.dart';
part 'allPosts.g.dart';

@riverpod
class AllPostsNotifier extends _$AllPostsNotifier {
  @override
  Future<List<PostData>> build() async {
    
    final querySnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .get();
    List<PostData> postModels =
        querySnapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      String desc = data['desc'] as String;
      List likes = data['likes'] as List;
      List comments = data['comments'] as List;
      String image = data['image'] as String;
      String imagePath = data['imagePath'] as String;
      String subject = data['subject'] as String;
      String uid = data['uid'] as String;
      String postId = data['postId'] as String;

      return PostData(
          desc, likes, comments, image, subject, uid, postId, imagePath);
    }).toList();
    return postModels;
  }

  void updatePosts() async {
    state = const AsyncValue.loading();
    final querySnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .get();
    List<PostData> postModels =
        querySnapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      String desc = data['desc'] as String;
      List likes = data['likes'] as List;
      List comments = data['comments'] as List;
      String image = data['image'] as String;
      String imagePath = data['imagePath'] as String;
      String subject = data['subject'] as String;
      String uid = data['uid'] as String;
      String postId = data['postId'] as String;
      // PostDataオブジェクトの生成など、必要な処理を行う
      return PostData(
          desc, likes, comments, image, subject, uid, postId, imagePath);
    }).toList();
    state = AsyncValue.data(postModels);
  }
}
