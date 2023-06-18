import 'dart:ui';
import 'package:app/component/reply.dart';
import 'package:app/states/posts/replyComments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../component/replyComment.dart';
import '../models/post_models.dart';

class ReplyPage extends ConsumerWidget {
  final PostData post;
  ReplyPage(PostData postModel, {required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comments = ref.watch(replyCommentsNotifierProvider(post.postId));
    List commentModels = [];
    bool hasData = false;

    comments.when(
      data: (d) {
        commentModels = d;
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
        //bottomNavigationBar: null,
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
        body: hasData
            ? RefreshIndicator(
                displacement: 120,
                onRefresh: () async {
                  final notifier = ref.read(
                      replyCommentsNotifierProvider(post.postId).notifier);
                  notifier.updateReplyComments();
                },
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                        child: SizedBox(
                      height: 96,
                    )),
                    SliverToBoxAdapter(
                      child: Reply(post, post: post),
                    ),
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return replyCommentCard(
                          commentModels[index],
                          post.postId,
                          replyComment: commentModels[index],
                          
                        );
                      },
                      childCount: commentModels.length,
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
