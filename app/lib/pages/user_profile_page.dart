import 'dart:ui';

import 'package:app/states/userProfile.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_down_button/pull_down_button.dart';

import '../component/post.dart';
import '../models/post_models.dart';
import '../models/user_models.dart';
import '../states/posts/userPosts.dart';

class UserProfilePage extends ConsumerWidget {
  final PostData post;
  UserProfilePage(PostData postModel, {required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = post.uid;
    final userRef = ref.watch(UserProfileNotifierProvider(uid));

    UserData myData = userRef.when(data: (d) {
      UserData userModels = d;
      return userModels;
    }, error: (error, stackTrace) {
      return UserData('', '', '', '', '', '', 0, 0, [], '', '');
    }, loading: () {
      return UserData('', '', '', '', '', '', 0, 0, [], '', '');
    });
    final userPosts = ref.watch(UserPostsNotifierProvider(myData.posts));
    //final userPosts = ref.watch(allPostsNotifierProvider);
    List postModels = [];
    userPosts.when(
      data: (d) {
        postModels = d;
      },
      loading: () {
        return Scaffold(body: CircularProgressIndicator());
      },
      error: (error, stackTrace) {
        return Text('エラーが発生しました: $error');
      },
    );
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: AppBar(
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white.withOpacity(0.5),
                title: Text(
                  '戻る',
                  style: TextStyle(color: Colors.black),
                ),
                elevation: 0.0,
              ),
            ),
          ),
          preferredSize: Size(
            double.infinity,
            56.0,
          ),
        ),
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 64,
              ),
            ),
            SliverToBoxAdapter(
              child: userInfo(myData),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (context, i) {
                return modelToPost(
                  postModels[i],
                  post: postModels[i],
                );
              },
              childCount: postModels.length,
            ))
          ],
        ));
  }
}

class userInfo extends ConsumerWidget {
  final UserData myData;
  userInfo(
    this.myData, {
    super.key,
  });

  void navigateToChatPage(context, username) {
    //bool isUserExist = false;
    // int index = postModels.indexOf(postModels.firstWhere(
    //     (element) => element.username == username,
    //     orElse: () =>
    //         PostData(username, 'assets/images/noAvatar.png', '', 0, 0, '')));
    // if (index != -1) {
    //   // 要素が見つかった場合の処理
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => ChatPage(messageModels[index],
    //               message: messageModels[index])));
    // } else {
    //   // 要素が見つからなかった場合の処理
    //   print('---------------');
    // }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool hasIcon = false;
    if (hasIcon != '') {
      hasIcon = true;
    }
    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                height: 120,
                width: 120,
                child: Card(
                  child: hasIcon
                      ? Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(myData.icon))),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      'assets/images/noAvatar.png'))),
                        ),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                    side: BorderSide(
                      color: Color(0xff00ffcc),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                ProfileFollowInfo(myData),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    BouncingWidget(
                      duration: const Duration(milliseconds: 100),
                      scaleFactor: 1.5,
                      child: Container(
                        height: 36,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.blue,
                        ),
                        child: const Center(
                          child: Text(
                            'フォロー',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {},
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    BouncingWidget(
                      duration: const Duration(milliseconds: 100),
                      scaleFactor: 1.5,
                      child: Container(
                        height: 36,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.blue,
                        ),
                        child: const Center(
                          child: Text(
                            'メッセージ',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        navigateToChatPage(context, myData.username);
                      },
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    BouncingWidget(
                        child: Icon(Icons.more_horiz),
                        onPressed: () {
                          final box = context.findRenderObject() as RenderBox;
                          final topLeft = box.localToGlobal(Offset.zero);
                          final bottomRight = box
                              .localToGlobal(box.size.bottomRight(Offset.zero));
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
                                  enabled: false,
                                  onTap: () {},
                                  title: 'Inbox',
                                  icon: CupertinoIcons.tray_arrow_down,
                                ),
                                PullDownMenuItem(
                                  onTap: () {},
                                  title: 'Archive',
                                  icon: CupertinoIcons.archivebox,
                                ),
                                PullDownMenuItem(
                                  onTap: () {},
                                  title: 'Trash',
                                  isDestructive: true,
                                  icon: CupertinoIcons.delete,
                                ),
                              ],
                              position: menuRect);
                        })
                  ],
                )
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          myData.username,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          '${myData.amStudent}: ${myData.department}/${myData.course}',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 36.0),
          child: Text(
            myData.desc,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class ProfileFollowInfo extends StatelessWidget {
  final UserData myData;
  ProfileFollowInfo(
    this.myData, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              myData.posts.length.toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            ),
            Text(
              '投稿',
              style: TextStyle(
                fontSize: 16,
              ),
            )
          ],
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          children: [
            Text(
              myData.followers == 0 ? '0' : myData.followers.toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            ),
            Text(
              'フォロワー',
              style: TextStyle(
                fontSize: 16,
              ),
            )
          ],
        ),
        SizedBox(
          width: 8,
        ),
        Column(
          children: [
            Text(
              myData.followings == 0 ? '0' : myData.followings.toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            ),
            Text(
              'フォロー中',
              style: TextStyle(
                fontSize: 16,
              ),
            )
          ],
        ),
      ],
    );
  }
}
