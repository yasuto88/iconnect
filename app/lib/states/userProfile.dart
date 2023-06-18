import 'dart:io';

import 'package:app/models/user_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'state.dart';
part 'userProfile.g.dart';

@riverpod
class UserProfileNotifier extends _$UserProfileNotifier {
  @override
  Future<UserData> build(uid) async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final data = querySnapshot.data() as Map<String, dynamic>;
    String username = data['username'] as String;
    String desc = data['desc'] as String;
    String department = data['department'] as String;
    String course = data['course'] as String;
    String studentNumber = data['studentNumber'] as String;
    List followers = data['followers'] as List;
    int followerNumber = followers.length;
    List followings = data['followings'] as List;
    int followingNumber = followings.length;
    List posts = data['posts'] as List;
    String amStudent;
    if (studentNumber == '000000') {
      amStudent = '教師';
    } else {
      amStudent = '学生';
    }
    String icon = data['icon'] as String;

    return UserData(uid, username, desc, department, course, studentNumber,
        followerNumber, followingNumber, posts, amStudent, icon);
  }

  void updateMyDesc(newDesc) async {
    state = const AsyncValue.loading();
    final user = ref.watch(userProvider);
    final uid = user!.uid;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final snapshot = firestore.collection('users').doc(uid);
    await snapshot.update({'desc': newDesc});
    state = AsyncValue.data(newDesc);
  }

  void updateMyName(newName) async {
    state = const AsyncValue.loading();
    final user = ref.watch(userProvider);
    final uid = user!.uid;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final snapshot = firestore.collection('users').doc(uid);
    await snapshot.update({'username': newName});
    state = AsyncValue.data(newName);
  }

  Future<void> updateMyIcon(UserData myData, BuildContext context) async {
    File? image;
    final _picker = ImagePicker();
    final _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      image = File(_pickedFile.path);
      try {
        showDialog(
          context: context,
          barrierDismissible: false, // ダイアログ外のタップで閉じないようにする
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('アップロード中'),
              content: SizedBox(
                  height: 120,
                  width: 120,
                  child: Center(child: CircularProgressIndicator())),
            );
          },
        );

        // 画像ファイルの拡張子を取得
        String extension = image.path.split('.').last;

        // Cloud Storageに画像をアップロード
        firebase_storage.Reference storageRef = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('images/icons/$uid.$extension');
        await storageRef.putFile(image);

        // アップロードされた画像のURLを取得
        String imageUrl = await storageRef.getDownloadURL();

        final FirebaseFirestore firestore = FirebaseFirestore.instance;
        final snapshot = firestore.collection('users').doc(uid);
        await snapshot.update({'icon': imageUrl});
        await updateProfile();

        // ダイアログを閉じる
        Navigator.pop(context);
      } catch (e) {
        // エラーが発生した場合の処理
        print('エラー: $e');

        // エラーダイアログを表示
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('エラー'),
              content: Text('エラーが発生しました。'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('閉じる'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future updateProfile() async {
    state = const AsyncValue.loading();
    final querySnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final data = querySnapshot.data() as Map<String, dynamic>;
    String username = data['username'] as String;
    String desc = data['desc'] as String;
    String department = data['department'] as String;
    String course = data['course'] as String;
    String studentNumber = data['studentNumber'] as String;
    List followers = data['followers'] as List;
    int followerNumber = followers.length;
    List followings = data['followings'] as List;
    int followingNumber = followings.length;
    List posts = data['posts'] as List;
    String amStudent;
    if (studentNumber == '000000') {
      amStudent = '教師';
    } else {
      amStudent = '学生';
    }
    String icon = data['icon'] as String;
    final userModels = UserData(uid, username, desc, department, course,
        studentNumber, followerNumber, followingNumber, posts, amStudent, icon);
    state = AsyncValue.data(userModels);
  }
}
