import 'package:app/models/user_models.dart';
import 'package:app/pages/reply_page.dart';
import 'package:app/states/posts/userPosts.dart';
import 'package:app/states/userProfile.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:like_button/like_button.dart';
import 'package:pull_down_button/pull_down_button.dart';

import '../models/post_models.dart';
import '../pages/navi_page.dart';
import '../pages/user_profile_page.dart';
import '../states/posts/allPosts.dart';
import '../states/state.dart';
import 'icon.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class modelToPost extends ConsumerWidget {
  final PostData post;
  modelToPost(PostData postModel, {required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final uid = user!.uid;

    final userRef = ref.watch(UserProfileNotifierProvider(post.uid));
    UserData myData = userRef.when(data: (d) {
      UserData userModels = d;
      return userModels;
    }, error: (error, stackTrace) {
      return UserData('', '', '', '', '', '', 0, 0, [], '', '');
    }, loading: () {
      return UserData('', '', '', '', '', '', 0, 0, [], '', '');
    });
    //final uid = 'aIoA2lXqCgUEB2ZLih6W2V36hef1';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SizedBox(
        width: 360,
        child: Card(
            color: Colors.white60,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 160),
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (uid == post.uid) {
                        ref.read(indexProvider.notifier).state = 4;
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UserProfilePage(post, post: post)));
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Row(
                            children: [
                              IconImg(image: myData.icon),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                myData.username,
                                style: const TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              children: [
                                Text(
                                  '',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        post.desc,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  post.subject == '' ? SizedBox() : SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        post.subject,
                        style: TextStyle(color: Colors.lightBlue),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  post.image == '' ? SizedBox() : SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Container(
                                      child: Image.network(post.image!)),
                                ));
                      },
                      child: Container(
                          child: post.image == ''
                              ? SizedBox()
                              : Image.network(post.image!)),
                    ),
                  ),
                  post.image == '' ? SizedBox() : SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      likeButton(post: post),
                      SizedBox(
                        child: Row(
                          children: [
                            BouncingWidget(
                              duration: Duration(milliseconds: 100),
                              scaleFactor: 1.5,
                              child: const Icon(
                                Icons.question_answer,
                                color: Colors.grey,
                                //size: buttonSize,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ReplyPage(
                                              post,
                                              post: post,
                                            )));
                              },
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(post.comments.length.toString(),
                                style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      bookmarkButton(
                        post: post,
                      ),
                      moreButton(userModels: myData, post: post),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}

class bookmarkButton extends StatelessWidget {
  const bookmarkButton({
    super.key,
    required this.post,
  });

  final PostData post;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LikeButton(
          circleColor: const CircleColor(start: Colors.blue, end: Colors.blue),
          bubblesColor: const BubblesColor(
            dotPrimaryColor: Colors.blue,
            dotSecondaryColor: Colors.blue,
          ),
          likeBuilder: (bool isLiked) {
            return Icon(
              Icons.bookmark,
              color: isLiked ? Colors.blue : Colors.grey,
            );
          },
          likeCount: post.likes.length.toInt(),
          countBuilder: (count, bool isLiked, String text) {
            var color = isLiked ? Colors.blue : Colors.grey;
            Widget result;
            if (count == 0) {
              result = Text(
                "0",
                style: TextStyle(color: color),
              );
            } else {
              result = Text(
                text,
                style: TextStyle(color: color),
              );
            }
            return result;
          },
        ),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }
}

class moreButton extends ConsumerWidget {
  const moreButton({
    super.key,
    required this.post,
    required this.userModels,
  });
  final PostData post;
  final UserData userModels;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BouncingWidget(
      duration: Duration(milliseconds: 100),
      scaleFactor: 1.5,
      child: const Icon(
        Icons.more_horiz,
        color: Colors.grey,
      )
      //size: buttonSize,
      ,
      onPressed: () {
        final box = context.findRenderObject() as RenderBox;
        final topLeft = box.localToGlobal(Offset.zero);
        final bottomRight =
            box.localToGlobal(box.size.bottomRight(Offset.zero));
        final menuHeight = 10; // メニューの高さを指定
        final menuRect = Rect.fromLTRB(
          topLeft.dx,
          bottomRight.dy - menuHeight, // 下部に配置
          bottomRight.dx,
          bottomRight.dy,
        );
        showPullDownMenu(
            context: context,
            items: [
              PullDownMenuItem(
                onTap: () async {
                  showDialog<void>(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('投稿を消去します'),
                          content: Text('よろしいですか？'),
                          actions: [
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Text('キャンセル',
                                    style: TextStyle(color: Colors.blue)),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Text('消去',
                                    style: TextStyle(color: Colors.red)),
                              ),
                              onTap: () async {
                                FirebaseFirestore.instance
                                    .collection('posts')
                                    .doc(post.postId)
                                    .delete();

                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(post.uid)
                                    .update({
                                  'posts': FieldValue.arrayRemove([post.postId])
                                });
                                Navigator.pop(context);
                                final allNotifier =
                                    ref.read(allPostsNotifierProvider.notifier);
                                allNotifier.updatePosts();
                                final userPostNotifier = ref.read(
                                    UserPostsNotifierProvider(userModels.posts)
                                        .notifier);
                                userPostNotifier.updateUserPosts();

                                if (post.image != null &&
                                    post.imagePath != null) {
                                  firebase_storage.Reference storageRef =
                                      firebase_storage.FirebaseStorage.instance
                                          .ref()
                                          .child(post.imagePath!);
                                  await storageRef.delete();
                                }
                              },
                            ),
                          ],
                        );
                      });
                },
                title: '消去する',
                isDestructive: true,
                icon: CupertinoIcons.delete,
              ),
            ],
            position: menuRect);
      },
    );
  }
}

class likeButton extends StatelessWidget {
  const likeButton({
    super.key,
    required this.post,
  });

  final PostData post;

  @override
  Widget build(BuildContext context) {
    final _postStream =
        FirebaseFirestore.instance.collection('posts').doc(post.postId).get();

    return Row(
      children: [
        FutureBuilder(
          future: _postStream,
          builder: (context, snapshot) {
            bool isLiked = false;
            if (snapshot.data != null) {
              final postDocument = snapshot.data as DocumentSnapshot;
              final postData = postDocument.data() as Map<String, dynamic>;

              if (postData.containsKey('likes')) {
                final likes = postData['likes'] as List<dynamic>;
                if (likes.contains(post.uid)) {
                  isLiked = true;
                } else {
                  isLiked = false;
                }
              }
            }

            return LikeButton(
              circleColor:
                  const CircleColor(start: Colors.pink, end: Colors.pink),
              bubblesColor: const BubblesColor(
                dotPrimaryColor: Colors.pink,
                dotSecondaryColor: Colors.pink,
              ),
              likeBuilder: (bool isLiked) {
                return Icon(
                  Icons.favorite,
                  color: isLiked ? Colors.pink : Colors.grey,
                );
              },
              isLiked: isLiked,
              likeCount: post.likes.length.toInt(),
              //isLiked: ,
              onTap: (isLiked) async {
                if (isLiked) {
                  FirebaseFirestore.instance
                      .collection('posts')
                      .doc(post.postId)
                      .update({
                    'likes': FieldValue.arrayRemove([post.uid])
                  });
                } else {
                  FirebaseFirestore.instance
                      .collection('posts')
                      .doc(post.postId)
                      .update({
                    'likes': FieldValue.arrayUnion([post.uid])
                  });
                }
                return !isLiked;
              },
              countBuilder: (count, bool isLiked, String text) {
                var color = isLiked ? Colors.pink : Colors.grey;
                Widget result;
                if (count == 0) {
                  result = Text(
                    "0",
                    style: TextStyle(color: color),
                  );
                } else {
                  result = Text(
                    text,
                    style: TextStyle(color: color),
                  );
                }

                return result;
              },
            );
          },
        ),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }
}
