import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

Future sendPost(desc, subject, File? image) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;

  if (desc == '') {
    return;
  }

  final documentRef = FirebaseFirestore.instance.collection('posts').doc();

  final postId = documentRef.id;

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
        .child('images/posts/$postId.$extension');
    await storageRef.putFile(image);
    imagePath = 'images/posts/$postId.$extension';
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
    'subject': subject,
    'image': imageUrl,
    'imagePath': imagePath,
    'likes': [],
    'comments': [],
    'icon': icon,
    'postId': postId,
    'username': username,
    'timestamp': FieldValue.serverTimestamp(),
  });

  FirebaseFirestore.instance.collection('users').doc(uid).update({
    'posts': FieldValue.arrayUnion([postId])
  });
}
