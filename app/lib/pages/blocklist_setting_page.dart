import 'dart:ui';

import 'package:app/component/icon.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_down_button/pull_down_button.dart';

class BlockListsSettingPage extends StatefulWidget {
  const BlockListsSettingPage({super.key});

  @override
  State<BlockListsSettingPage> createState() => _BlockListsSettingPageState();
}

class _BlockListsSettingPageState extends State<BlockListsSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white.withOpacity(0.5),
              title: Text(
                'ブロックリスト',
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
      body: SafeArea(
          child: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(children: [
            blockList(),
            blockList(),
            blockList(),
            blockList(),
          ]),
        ),
      )),
    );
  }
}

class blockList extends StatelessWidget {
  const blockList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: IconImg(image: 'assets/images/noAvatar.png'),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                'yasuto',
                style: TextStyle(fontSize: 24),
              )
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(right: 40), child: moreButton())
        ],
      ),
    );
  }
}

class moreButton extends StatelessWidget {
  const moreButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                onTap: () {},
                title: '解除',
                isDestructive: true,
                icon: CupertinoIcons.minus_circle,
              ),
            ],
            position: menuRect);
      },
    );
  }
}
