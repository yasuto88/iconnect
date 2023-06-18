import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

Future sendReplyComment(postId,desc, File? image) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;

  if (desc == '') {
    return;
  }

  final documentRef = FirebaseFirestore.instance.collection('comments').doc();

  final commentId = documentRef.id;

  String imageUrl;
  String imagePath;
  if (image == null) {
    imageUrl = '';
    imagePath = '';
  } else {
    // 画像ファイルの拡張子を取得
    String extension = image.path.split('.').last;

    // Cloud Storageに画像をアップロード
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('images/comments/$commentId.$extension');
    await storageRef.putFile(image);
    imagePath = 'images/comments/$commentId.$extension';
    // アップロードされた画像のURLを取得
    imageUrl = await storageRef.getDownloadURL();
  }

  final querySnapshot =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  final data = querySnapshot.data() as Map<String, dynamic>;
  String username = data['username'] as String;
  String icon = data['icon'] as String;
  await documentRef.set({
    'uid': uid,
    'desc': desc,
    'subject': '',
    'image': imageUrl,
    'imagePath': imagePath,
    'likes': [],
    'comments': [],
    'icon': icon,
    'commentId': commentId,
    'username': username,
    'timestamp': FieldValue.serverTimestamp(),
  });

  FirebaseFirestore.instance.collection('posts').doc(postId).update({
    'comments': FieldValue.arrayUnion([commentId])
  });
}
