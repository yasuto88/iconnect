import 'dart:ui';

import 'package:app/pages/subject_post_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/post_models.dart';

class SubjectPage extends StatefulWidget {
  const SubjectPage({super.key});

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  String subject = '';
  List<String> subjectList = [
    'IoTシステム開発実習',
    'センサ・アクチュエータ',
    'データベース基礎と応用',
    '制御工学基礎',
    '地域共創デザイン実習',
    '確率統計論',
    '線形システム基礎',
    '隣地実務実習',
    '英語コミュニケーション２ a;Ａ・Ｃ・Ｄ',
    '計算科学',
    '電子回路実習'
  ];

  List<String> searchList = [];

  @override
  void initState() {
    searchList = subjectList;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<String> result = [];
    if (enteredKeyword.isEmpty) {
      result = subjectList;
    } else {
      result = subjectList
          .where((user) =>
              user.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      searchList = result;
    });
  }

  Future<List<PostData>> getPosts(subject) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('posts')
        //.orderBy('timestamp', descending: true)
        .where('subject', isEqualTo: '＃$subject')
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AppBar(
              backgroundColor: Colors.white.withOpacity(0.5),
              title: Text(
                '検索',
                style: TextStyle(color: Colors.black),
              ),
              elevation: 0.0,
              centerTitle: true,
            ),
          ),
        ),
        preferredSize: Size(
          double.infinity,
          56.0,
        ),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 36,
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    onChanged: (value) => _runFilter(value),
                    decoration: InputDecoration(
                        labelText: '科目を選択する', suffixIcon: Icon(Icons.search)),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 500,
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: searchList.length,
                      itemBuilder: (context, i) => GestureDetector(
                          onTap: () {
                            subject = searchList[i];
                            getPosts(subject);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SubjectPostPage(
                                          subject: subject,
                                        )));
                          },
                          child: Card(
                            key: ValueKey(searchList[i]),
                            color: Colors.blue,
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                Colors.blue,
                                Colors.lightBlueAccent
                              ])),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  searchList[i],
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white),
                                ),
                              ),
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
