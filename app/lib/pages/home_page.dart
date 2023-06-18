import 'dart:ui';

import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:app/pages/post_page.dart';
import 'package:app/states/posts/allPosts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../component/post.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // if (isLogin == true) {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => LoginPage()));
    // }

    Widget search() {
      return Container(
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {},
          child: Icon(
            Icons.search,
            color: Colors.blue,
          ),
        ),
      );
    }

    Widget post() {
      return Container(
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PostPage()));
          },
          child: Icon(
            Icons.add,
            color: Colors.blue,
          ),
        ),
      );
    }

    Widget bookmark() {
      return Container(
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {},
          child: Icon(
            Icons.bookmark_border,
            color: Colors.blue,
          ),
        ),
      );
    }

    var _scrollController = ScrollController();
    final allPosts = ref.watch(allPostsNotifierProvider);
    List postModels = [];
    bool hasData = false;
    bool _ScrollPhysics = false;

    allPosts.when(
      data: (d) {
        postModels = d;
        hasData = true;
        if (postModels.length > 3) {
          _ScrollPhysics = true;
        } else {
          _ScrollPhysics = false;
        }
      },
      loading: () {
        return CircularProgressIndicator();
      },
      error: (error, stackTrace) {
        return Text('エラーが発生しました: $error');
      },
    );

    // final GlobalKey<AnimatedFloatingActionButtonState> key =
    //     GlobalKey<AnimatedFloatingActionButtonState>();

    return MaterialApp(
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
                extendBodyBehindAppBar: true,
                appBar: PreferredSize(
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: AppBar(
                        backgroundColor: Colors.white.withOpacity(0.5),
                        elevation: 0,
                        centerTitle: true,
                        title: Image.asset(
                          'assets/images/iconnect2.png',
                          height: 60,
                        ),
                        bottom: const TabBar(
                            labelColor: Colors.black,
                            tabs: <Widget>[
                              Tab(
                                text: ('全ての投稿'),
                              ),
                              Tab(
                                text: ('フォロー中の投稿'),
                              ),
                            ]),
                      ),
                    ),
                  ),
                  preferredSize: Size(
                    double.infinity,
                    120.0,
                  ),
                ),
                floatingActionButton: AnimatedFloatingActionButton(
                    fabButtons: <Widget>[post(), search(), bookmark()],
                    key: key,
                    colorStartAnimation: Colors.blue,
                    colorEndAnimation: Colors.red,
                    animatedIconData: AnimatedIcons.menu_close),
                body: Stack(
                  children: [
                    TabBarView(children: <Widget>[
                      SizedBox(
                        height: 2000,
                        child: RefreshIndicator(
                            displacement: 160,
                            onRefresh: () async {
                              final notifier =
                                  ref.read(allPostsNotifierProvider.notifier);
                              notifier.updatePosts();
                            },
                            child: hasData
                                ? ListView.builder(
                                    // reverse: true,
                                    physics: _ScrollPhysics
                                        ? BouncingScrollPhysics()
                                        : AlwaysScrollableScrollPhysics(),
                                    controller: _scrollController,
                                    itemCount: postModels.length,
                                    itemBuilder: (c, i) => modelToPost(
                                      postModels[i],
                                      post: postModels[i],
                                    ),
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  )),
                      ),
                      SizedBox(
                        height: 2000,
                        child: RefreshIndicator(
                          displacement: 160,
                          onRefresh: () async {
                            await Future.delayed(Duration(seconds: 1));
                            CircularProgressIndicator();
                          },
                          child: ListView.builder(
                            physics: _ScrollPhysics
                                ? BouncingScrollPhysics()
                                : AlwaysScrollableScrollPhysics(),
                            controller: _scrollController,
                            itemCount: postModels.length,
                            itemBuilder: (c, i) => modelToPost(
                              postModels[i],
                              post: postModels[i],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ))));
  }
}
