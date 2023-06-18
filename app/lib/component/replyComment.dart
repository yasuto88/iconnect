import 'package:app/models/post_models.dart';
import 'package:app/states/posts/replyComments.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:like_button/like_button.dart';
import 'package:pull_down_button/pull_down_button.dart';

import '../models/user_models.dart';
import '../pages/navi_page.dart';
import '../pages/user_profile_page.dart';
import '../states/posts/allPosts.dart';
import '../states/state.dart';
import '../states/userProfile.dart';
import 'icon.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class replyCommentCard extends ConsumerWidget {
  final PostData replyComment;
  final postId;
  replyCommentCard(PostData replyCommentModels, this.postId,
      {required this.replyComment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final uid = user!.uid;

    final userRef = ref.watch(UserProfileNotifierProvider(replyComment.uid));
    UserData myData = userRef.when(data: (d) {
      UserData userModels = d;
      return userModels;
    }, error: (error, stackTrace) {
      return UserData('', '', '', '', '', '', 0, 0, [], '', '');
    }, loading: () {
      return UserData('', '', '', '', '', '', 0, 0, [], '', '');
    });

    return SizedBox(
      child: Padding(
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
                        if (uid == replyComment.uid) {
                          ref.read(indexProvider.notifier).state = 4;
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserProfilePage(
                                      replyComment,
                                      post: replyComment)));
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              children: [
                                IconImg(image: myData.icon),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  myData.username,
                                  style: const TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.0),
                              child: Row(
                                children: [
                                  Text(
                                    '12分前',
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
                          replyComment.desc.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: Container(
                                        child:
                                            Image.network(replyComment.image!)),
                                  ));
                        },
                        child: Container(
                            child: replyComment.image == ''
                                ? SizedBox()
                                : Image.network(replyComment.image!)),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              LikeButton(
                                circleColor: const CircleColor(
                                    start: Colors.pink, end: Colors.pink),
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
                                likeCount: replyComment.likes.length.toInt(),
                                countBuilder:
                                    (count, bool isLiked, String text) {
                                  var color =
                                      isLiked ? Colors.pink : Colors.grey;
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
                              // Text(widget.post.likes,
                              //     style: const TextStyle(color: Colors.grey))
                            ],
                          ),
                        ),
                        BouncingWidget(
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
                            final bottomRight = box.localToGlobal(
                                box.size.bottomRight(Offset.zero));
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
                                                  child: const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 16),
                                                    child: Text('キャンセル',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.blue)),
                                                  ),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                GestureDetector(
                                                  child: const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 16),
                                                    child: Text('消去',
                                                        style: TextStyle(
                                                            color: Colors.red)),
                                                  ),
                                                  onTap: () async {
                                                    FirebaseFirestore.instance
                                                        .collection('comments')
                                                        .doc(
                                                            replyComment.postId)
                                                        .delete();

                                                    FirebaseFirestore.instance
                                                        .collection('posts')
                                                        .doc(postId)
                                                        .update({
                                                      'comments': FieldValue
                                                          .arrayRemove([
                                                        replyComment.postId
                                                      ])
                                                    });
                                                    Navigator.pop(context);
                                                    final allNotifier = ref.read(
                                                        allPostsNotifierProvider
                                                            .notifier);
                                                    allNotifier.updatePosts();
                                                    final userPostNotifier =
                                                        ref.read(
                                                            replyCommentsNotifierProvider(
                                                                    replyComment
                                                                        .postId)
                                                                .notifier);
                                                    userPostNotifier
                                                        .updateReplyComments();

                                                    if (replyComment.image !=
                                                            null &&
                                                        replyComment
                                                                .imagePath !=
                                                            null) {
                                                      firebase_storage.Reference
                                                          storageRef =
                                                          firebase_storage
                                                              .FirebaseStorage
                                                              .instance
                                                              .ref()
                                                              .child(replyComment
                                                                  .imagePath!);
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
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
