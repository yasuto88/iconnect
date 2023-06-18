import 'dart:io';

import 'package:app/firebase/sendReplyComment.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/post_models.dart';
import '../pages/user_profile_page.dart';

class Reply extends StatefulWidget {
  final PostData post;
  Reply(PostData postModel, {required this.post});

  @override
  State<Reply> createState() => _ReplyState();
}

class _ReplyState extends State<Reply> {
  final textcontroler = TextEditingController();
  final focusNode = FocusNode();

  File? image;
  final _picker = ImagePicker();

  Future _getImageFromGallery() async {
    final _pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (_pickedFile != null) {
        image = File(_pickedFile.path);
      }
    });
  }

  Widget _displaySelectionImageOrGrayImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: image == null ? const Text('') : _selectionImg(),
        ),
        Center(
          child: TextButton(
            onPressed: () {
              _getImageFromGallery();
            },
            child: Text('画像を選択する'),
          ),
        ),
      ],
    );
  }

  Widget _selectionImg() {
    return Column(
      children: [
        Image.file(image!),
        Center(
          child: TextButton(
            onPressed: () {
              setState(() {
                image = null;
              });
            },
            child: Text(
              '画像を消す',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfilePage(
                                    widget.post,
                                    post: widget.post)));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              children: [
                                //IconImg(image: widget.post.icon),
                                const SizedBox(
                                  width: 8,
                                ),
                                // Text(
                                //   widget.post.username,
                                //   style: const TextStyle(fontSize: 20),
                                // )
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
                          widget.post.desc,
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
                                        child: Image.asset(widget.post.image!)),
                                  ));
                        },
                        child: Container(
                            child: widget.post.image == ''
                                ? SizedBox()
                                : Image.asset(widget.post.image!)),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            width: 240,
                            child: TextFormField(
                              controller: textcontroler,
                              focusNode: focusNode,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: '返信する'),
                            ),
                          ),
                        ),
                        BouncingWidget(
                          duration: Duration(milliseconds: 100),
                          scaleFactor: 1.5,
                          child: const Icon(Icons.send),
                          onPressed: () {
                            sendReplyComment(
                                widget.post.postId, textcontroler.text, image);
                            textcontroler.clear();
                            focusNode.unfocus();
                            setState(() {
                              image = null;
                            });
                          },
                        ),
                        //Icon(Icons.send)
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(top: BorderSide(color: Colors.grey))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: _displaySelectionImageOrGrayImage(),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
