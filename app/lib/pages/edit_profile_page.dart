import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_models.dart';
import '../states/state.dart';
import '../states/userProfile.dart';

final class EditProfilePage extends ConsumerWidget {
  Widget build(BuildContext context, WidgetRef ref) {
    //   File? image;
    // final _picker = ImagePicker();

    // Future _getImageFromGallery() async {
    //   final _pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    //   setState(() {
    //     if (_pickedFile != null) {
    //       image = File(_pickedFile.path);
    //     }
    //   });
    // }

    // Widget _displaySelectionImageOrGrayImage() {
    //   return image == null
    //       ? Image.asset(
    //           'assets/images/noAvatar.png',
    //           width: 120,
    //           height: 120,
    //           fit: BoxFit.fill,
    //         )
    //       : Image.file(
    //           image!,
    //           width: 120,
    //           height: 120,
    //           fit: BoxFit.fill,
    //         );
    // }

    final user = ref.watch(userProvider);
    final uid = user!.uid;
    final userRef = ref.watch(UserProfileNotifierProvider(uid));
    bool hasIcon = false;
    bool hasData = false;
    UserData myData = userRef.when(data: (d) {
      UserData userModels = d;
      hasData = true;
      hasIcon = true;
      return userModels;
    }, error: (error, stackTrace) {
      return UserData('', '', '', '', '', '', 0, 0, [], '', '');
    }, loading: () {
      hasData = false;
      return UserData('', '', '', '', '', '', 0, 0, [], '', '');
    });

    String newName = '';
    String newDesc = '';

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          56.0,
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AppBar(
              backgroundColor: Colors.white.withOpacity(0.5),
              title: Text(
                'プロフィールを編集',
                style: TextStyle(color: Colors.black),
              ),
              elevation: 0.0,
              centerTitle: true,
              actions: [
                TextButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false, // ダイアログ外のタップで閉じないようにする
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('アップロード中'),
                          content: SizedBox(
                              height: 120,
                              width: 120,
                              child:
                                  Center(child: CircularProgressIndicator())),
                        );
                      },
                    );
                    final notifier =
                        ref.read(UserProfileNotifierProvider(uid).notifier);
                    if (newName.isNotEmpty) {
                      notifier.updateMyName(newName);
                    }
                    if (newDesc.isNotEmpty) {
                      notifier.updateMyDesc(newDesc);
                    }
                    await notifier.updateProfile();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '完了',
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: hasData
              ? Column(children: [
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
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
                  SizedBox(
                    height: 16,
                  ),
                  TextButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          barrierDismissible: false, // ダイアログ外のタップで閉じないようにする
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('ロード中'),
                              content: SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Center(
                                      child: CircularProgressIndicator())),
                            );
                          },
                        );
                        final notifier =
                            ref.read(UserProfileNotifierProvider(uid).notifier);
                        await notifier.updateMyIcon(myData, context);
                        Navigator.pop(context);
                      },
                      child: Text('アイコンを編集')),
                  Container(
                    width: 360,
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey))),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 12, right: 32, left: 12, bottom: 12),
                        child: Container(
                          width: 64,
                          child: Text(
                            '名前',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 260,
                        child: TextField(
                          controller:
                              TextEditingController(text: myData.username),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: 16, right: 32, left: 12, bottom: 12),
                              suffixIcon: Icon(Icons.edit)),
                          onChanged: (value) {
                            newName = value;
                          },
                        ),
                      )
                    ],
                  ),
                  // SizedBox(
                  //   height: 4,
                  // ),
                  // Row(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(
                  //           top: 12, right: 32, left: 12, bottom: 12),
                  //       child: Container(
                  //         width: 64,
                  //         child: Text(
                  //           '学部',
                  //           style: TextStyle(fontSize: 16),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 260,
                  //       child: TextField(
                  //           controller: TextEditingController(text: '情報工学科'),
                  //           decoration: InputDecoration(
                  //               contentPadding: EdgeInsets.only(
                  //                   top: 16, right: 32, left: 12, bottom: 12),
                  //               suffixIcon: Icon(Icons.edit))),
                  //     )
                  //   ],
                  // ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 12, right: 32, left: 12, bottom: 12),
                        child: Container(
                          width: 64,
                          child: Text(
                            '自己紹介',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 260,
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: TextEditingController(text: myData.desc),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: 16, right: 32, left: 12, bottom: 12),
                              suffixIcon: Icon(Icons.edit)),
                          onChanged: (value) {
                            newDesc = value;
                          },
                        ),
                      )
                    ],
                  ),
                ])
              : CircularProgressIndicator(),
        ),
      )),
    );
  }
}
