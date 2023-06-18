import 'package:app/component/icon.dart';
import 'package:app/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

import '../models/messege_models.dart';

final messageModels = [
  MessageData('yasuto', 'assets/images/noAvatar.png', '13', '1', 'こんにちは'),
  MessageData('tanaka', 'assets/images/noAvatar.png', '13', '0', 'こんにちは'),
  MessageData('sato', 'assets/images/noAvatar.png', '13', '0', 'こんにちは'),
  MessageData('yasuto', 'assets/images/noAvatar.png', '13', '1', 'こんにちは'),
  MessageData('yasuto', 'assets/images/noAvatar.png', '13', '0', 'こんにちは'),
  MessageData('yasuto', 'assets/images/noAvatar.png', '13', '0', 'こんにちは'),
  MessageData('yasuto', 'assets/images/noAvatar.png', '13', '0', 'こんにちは'),
  MessageData('yasuto', 'assets/images/noAvatar.png', '13', '0', 'こんにちは'),
  MessageData('yasuto', 'assets/images/noAvatar.png', '13', '0', 'こんにちは'),
  MessageData('yasuto', 'assets/images/noAvatar.png', '13', '0', 'こんにちは'),
  MessageData('yasuto', 'assets/images/noAvatar.png', '13', '0', 'こんにちは'),
  MessageData('yasuto', 'assets/images/noAvatar.png', '13', '0', 'こんにちは'),
  MessageData('yasuto', 'assets/images/noAvatar.png', '13', '0', 'こんにちは'),
  MessageData('yasuto', 'assets/images/noAvatar.png', '13', '0', 'こんにちは'),
];
final noti = false;

class MessageCard extends StatefulWidget {
  final MessageData message;

  MessageCard(
    MessageData messageModel, {
    super.key,
    required this.message,
  });

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(
                      widget.message,
                      message: widget.message,
                    )));
      },
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey)),
          color: Colors.white,
        ),
        width: double.infinity,
        height: 100,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconImg(image: widget.message.icon),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${widget.message.username}さん',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text(
                    '${widget.message.lastMessage}',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    '${widget.message.messagedTime}分前',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ],
          ),
          badges.Badge(
            //showBadge: false,
            showBadge: notificationFanc(widget.message.notification, noti),
            badgeContent: Text(
              widget.message.notification,
              style: TextStyle(color: Colors.white),
            ),
            child: const Icon(Icons.chevron_right),
          ),
        ]),
      ),
    );
  }
}

bool notificationFanc(notification, noti) {
  if (notification == '0') {
    noti = false;
    return noti;
  } else {
    noti = true;
    return noti;
  }
}

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: messageModels.length,
        itemBuilder: (c, i) => MessageCard(
          messageModels[i],
          message: messageModels[i],
        ),
      ),
    );
  }
}
