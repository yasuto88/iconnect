import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';

import '../models/chat_models.dart';

List<chatData> chatModels = [
  chatData(
    chat: 'はじめまして！',
    isMe: true,
  ),
  chatData(
    chat: 'ヤストです',
    isMe: true,
  ),
  chatData(
    chat: '初めまして！',
    isMe: false,
  ),
  chatData(
    chat: 'よろしくお願いします！',
    isMe: false,
  ),
  chatData(chat: '食パン', isMe: true),
  chatData(chat: '食パン', isMe: true),
  chatData(chat: '食パン', isMe: true),
  chatData(chat: '食パン', isMe: true),
  chatData(chat: '食パン', isMe: true),
  chatData(chat: '食パン', isMe: true),
  chatData(chat: '食パン', isMe: true),
  chatData(chat: '食パン', isMe: true),
  chatData(chat: '食パン', isMe: true),
  chatData(chat: '食パン', isMe: true),
  chatData(chat: '食パン', isMe: true),
  chatData(chat: '食パン', isMe: true),
  chatData(chat: '食パン', isMe: true),
  chatData(chat: '食パン', isMe: true),
  chatData(chat: '食パン', isMe: true),
  chatData(chat: '食パン', isMe: true),
  chatData(chat: '食パン', isMe: true),
  chatData(chat: '食パン', isMe: true),
  chatData(chat: '食パン', isMe: true),
  chatData(chat: '食パン', isMe: true),
  chatData(chat: 'kkkkkkkkkkkkkk', isMe: true),
];

class chatCard extends StatefulWidget {
  final chatData chat;
  chatCard(chatData chatModels, {required this.chat});

  @override
  State<chatCard> createState() => _chatCardState();
}

class _chatCardState extends State<chatCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BubbleSpecialThree(
        text: widget.chat.chat,
        color: widget.chat.isMe ? Color(0xFF1B97F3) : Color(0xFFE8E8EE),
        tail: true,
        textStyle: TextStyle(
            color: widget.chat.isMe ? Colors.white : Colors.black,
            fontSize: 16),
        isSender: widget.chat.isMe,
      ),
    );
  }
}

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: chatModels.length,
        itemBuilder: (c, i) => chatCard(
          chatModels[i],
          chat: chatModels[i],
        ),
      ),
    );
  }
}
