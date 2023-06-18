import 'dart:ui';

import 'package:app/states/posts/subjectPosts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../component/post.dart';

class SubjectPostPage extends ConsumerWidget {
  final subject;
  const SubjectPostPage({super.key, required this.subject});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectPosts = ref.watch(subjectPostsNotifierProvider(subject));
    List postModels = [];
    bool hasData = false;

    subjectPosts.when(
      data: (d) {
        postModels = d;
        hasData = true;
      },
      loading: () {
        return CircularProgressIndicator();
      },
      error: (error, stackTrace) {
        return Text('エラーが発生しました: $error');
      },
    );
    return Scaffold(
      appBar: PreferredSize(
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white.withOpacity(0.5),
              title: Text(
                subject,
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
      body: SizedBox(
        height: 2000,
        child: RefreshIndicator(
          //displacement: 160,
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 1));
          },
          child: hasData
              ? ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: postModels.length,
                  itemBuilder: (c, i) => modelToPost(
                    postModels[i],
                    post: postModels[i],
                  ),
                )
              : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class riseButton extends StatelessWidget {
  const riseButton({
    super.key,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: FloatingActionButton(
        mini: true,
        onPressed: () {
          _scrollController.animateTo(0,
              duration: Duration(milliseconds: 300), curve: Curves.linear);
        },
        child: Icon(
          Icons.arrow_upward,
          size: 20,
        ),
      ),
    );
  }
}
