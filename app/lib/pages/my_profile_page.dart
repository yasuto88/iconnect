import 'dart:ui';

import 'package:app/models/user_models.dart';
import 'package:app/pages/edit_profile_page.dart';
import 'package:app/pages/settings_page.dart';
import 'package:app/states/posts/userPosts.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../component/post.dart';
import '../states/state.dart';
import '../states/userProfile.dart';

class MyProfilePage extends ConsumerWidget {
  const MyProfilePage({super.key, String? id, Icon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final uid = user!.uid;
    final userRef = ref.watch(UserProfileNotifierProvider(uid));
    bool hasData = false;

    UserData myData = userRef.when(data: (d) {
      UserData userModels = d;
      hasData = true;
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
        return CircularProgressIndicator();
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
                  'プロフィール',
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
        body: hasData
            ? RefreshIndicator(
                displacement: 120,
                onRefresh: () async {
                  final userNotifier =
                      ref.read(UserProfileNotifierProvider(uid).notifier);
                  userNotifier.updateProfile();
                  final postNotifier = ref
                      .read(UserPostsNotifierProvider(myData.posts).notifier);
                  postNotifier.updateUserPosts();
                },
                child: CustomScrollView(
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
                    )),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 400,
                      ),
                    )
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}

class userInfo extends ConsumerWidget {
  final myData;
  userInfo(
    this.myData, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool hasIcon = false;
    if (myData.icon != '') {
      hasIcon = true;
    }

    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
                profileFollowInfo(myData),
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
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[300],
                        ),
                        child: const Center(
                          child: Text(
                            'プロフィールを編集',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfilePage()));
                        //getMyName();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BouncingWidget(
                        duration: const Duration(milliseconds: 100),
                        scaleFactor: 1.5,
                        child: Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.grey[300],
                          ),
                          child: const Center(child: Icon(Icons.settings)),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingPage()));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            )
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

class profileFollowInfo extends ConsumerWidget {
  final UserData myData;
  profileFollowInfo(
    this.myData, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              myData.followers.toString(),
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
              myData.followings.toString(),
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
