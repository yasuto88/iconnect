import 'dart:io';
import 'dart:ui';

import 'package:app/firebase/sendPost.dart';
import 'package:app/pages/home_page.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final textcontroler = TextEditingController();
  final focusNode = FocusNode();

  File? image;
  final _picker = ImagePicker();

  var _isSubjectSelected = false;

  String subject = '';

  List<String> subjectList = [
    'IoTシステム開発実習',
    'センサ・アクチュエータ',
    'データベース基礎と応用',
    '制御工学基礎',
    '地域共創デザイン実習',
    '確率統計論',
    '線形システム基礎',
    '隣地実務実習',
    '英語コミュニケーション２ a;Ａ・Ｃ・Ｄ',
    '計算科学',
    '電子回路実習'
  ];
  List<String> searchList = [];

  @override
  void initState() {
    searchList = subjectList;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<String> result = [];
    if (enteredKeyword.isEmpty) {
      result = subjectList;
    } else {
      result = subjectList
          .where((user) =>
              user.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      searchList = result;
    });
  }

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
                '投稿',
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
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 36,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 0),
                  child: Container(
                    width: 320,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(32)),
                    child: Column(
                      children: [
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
                                      border: InputBorder.none,
                                      hintText: '投稿する'),
                                ),
                              ),
                            ),
                            BouncingWidget(
                              duration: Duration(milliseconds: 100),
                              scaleFactor: 1.5,
                              child: const Icon(Icons.send),
                              onPressed: () {
                                sendPost(textcontroler.text, subject,image,);
                                
                                focusNode.unfocus();
                                if (textcontroler.text != '') {
                                  Navigator.pop(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                }
                                // setState(() {
                                //   image = null;
                                // });
                              },
                            ),
                            //Icon(Icons.send)
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              subject,
                              style: TextStyle(color: Colors.lightBlue),
                            ),
                            _isSubjectSelected
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        subject = '';
                                        _isSubjectSelected = false;
                                      });
                                    },
                                    icon: Icon(Icons.clear))
                                : Text('')
                          ],
                        ),
                        SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                              border:
                                  Border(top: BorderSide(color: Colors.grey))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: _displaySelectionImageOrGrayImage(),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 36,
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    onChanged: (value) => _runFilter(value),
                    decoration: InputDecoration(
                        labelText: '科目を選択する', suffixIcon: Icon(Icons.search)),
                  ),
                ),
                SizedBox(
                  height: 300,
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: searchList.length,
                      itemBuilder: (context, i) => GestureDetector(
                          onTap: () {
                            setState(() {
                              subject = '＃' + searchList[i];
                              _isSubjectSelected = true;
                            });
                          },
                          child: Card(
                            key: ValueKey(searchList[i]),
                            color: Colors.blue,
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                Colors.blue,
                                Colors.lightBlueAccent
                              ])),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  searchList[i],
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white),
                                ),
                              ),
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
