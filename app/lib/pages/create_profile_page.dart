// import 'package:app/pages/my_profile_page.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class CreateProfilePage extends StatefulWidget {
//   const CreateProfilePage({super.key});

//   @override
//   State<CreateProfilePage> createState() => _CreateProfilePageState();
// }

// class _CreateProfilePageState extends State<CreateProfilePage> {
//   final _usernameController = TextEditingController();
//   final _studentNumberController = TextEditingController();
//   String? _department;
//   String? _course;
//   String errorText = '';
//   bool exist = true;
//   Future<void> createProfile(BuildContext context) async {
//     //usernameの文字数が足りてるかどうか
//     if (_usernameController.text.length > 5) {
//       //フォームが全て選択されているか
//       if (_department != null && _course != null) {
//         QuerySnapshot getUser = await FirebaseFirestore.instance
//             .collection('users')
//             .where("username", isEqualTo: _usernameController.text)
//             .get();
//         //すでに登録されているusernameではないか
//         if (getUser.docs.isEmpty) {
//           //学籍番号が６桁か
//           if (_studentNumberController.text.length == 6) {
//             if (_studentNumberController.text != '000000') {
//               QuerySnapshot getNumber = await FirebaseFirestore.instance
//                   .collection('users')
//                   .where("studentNumber",
//                       isEqualTo: _studentNumberController.text)
//                   .get();
//               //すでに登録されている学籍番号ではないか
//               if (getNumber.docs.isNotEmpty) {
//                 errorText = 'すでに登録されている学籍番号です';
//               }
//             }
//             errorText = '';
//             final user = await FirebaseAuth.instance.currentUser!;
//             final users =
//                 FirebaseFirestore.instance.collection('users').doc(user.uid);
//             FirebaseFirestore.instance
//                 .collection('users')
//                 .doc(user.uid)
//                 .set({});
//             try {
//               //documentにデータを送信
//               //ユーザー名を登録
//               await users.set({'username': _usernameController.text},
//                   SetOptions(merge: true));
//               //学籍番号を登録
//               await users.set({'studentNumber': _studentNumberController.text},
//                   SetOptions(merge: true));
//               //学科を登録
//               await users
//                   .set({'department': _department}, SetOptions(merge: true));
//               //コースを選択
//               await users.set({'course': _course}, SetOptions(merge: true));
//               final userId = user.uid;
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => MyProfilePage()));
//             } catch (e) {
//               print(e);
//             }
//           } else {
//             errorText = '学籍番号は6桁で入力してください';
//           }
//         } else {
//           errorText = 'すでに登録されているユーザー名です';
//         }
//       } else {
//         errorText = 'フォームを全て選択してください';
//       }
//     } else {
//       errorText = 'usernameの文字数が少ないです（6文字以上）';
//     }

//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.grey[300],
//         body: SafeArea(
//           child: Center(
//               child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/images/iconnect2.png',
//                   height: 120,
//                 ),
//                 SizedBox(
//                   height: 24,
//                 ),
//                 Text(
//                   'Welcome to "iConnect"',
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 Text(
//                   'プロフィールを設定して"iConnect"を始めよう！！',
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 SizedBox(
//                   height: 62,
//                 ),

//                 //username textfiled
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       border: Border.all(color: Colors.white),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                         left: 24,
//                       ),
//                       child: TextField(
//                         controller: _usernameController,
//                         decoration: InputDecoration(
//                             border: InputBorder.none, labelText: 'username'),
//                       ),
//                     ),
//                   ),
//                 ),

//                 SizedBox(
//                   height: 16,
//                 ),

//                 //studentNumber textfiled
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       border: Border.all(color: Colors.white),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                         left: 24,
//                       ),
//                       child: TextField(
//                         inputFormatters: [
//                           FilteringTextInputFormatter.digitsOnly
//                         ],
//                         controller: _studentNumberController,
//                         decoration: InputDecoration(
//                             border: InputBorder.none,
//                             labelText: '学籍番号(講師の方は000000)',
//                             hintText: 'okを除いた半角数字'),
//                       ),
//                     ),
//                   ),
//                 ),

//                 SizedBox(
//                   height: 16,
//                 ),

//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       border: Border.all(color: Colors.white),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                         left: 24,
//                       ),
//                       child: SizedBox(
//                         width: 280,
//                         child: DropdownButtonFormField(
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                           ),
//                           hint: Text(
//                             '学科を選択してください',
//                           ),
//                           items: [
//                             DropdownMenuItem(
//                               child: Text('情報工学科'),
//                               value: '情報工学科',
//                             ),
//                             DropdownMenuItem(
//                               child: Text('デジタルエンターテイメント'),
//                               value: 'デジタルエンターテイメント',
//                             ),
//                           ],
//                           onChanged: (value) {
//                             setState(() {
//                               _department = value as String?;
//                             });
//                           },
//                           value: _department,
//                           //isExpanded: true,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 SizedBox(
//                   height: 16,
//                 ),
//                 //course Dropdown
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       border: Border.all(color: Colors.white),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                         left: 24,
//                       ),
//                       child: SizedBox(
//                         width: 280,
//                         child: DropdownButtonFormField(
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                           ),
//                           hint: Text(
//                             'コースを選択してください',
//                           ),
//                           items: [
//                             DropdownMenuItem(
//                               child: Text('AI戦略コース'),
//                               value: 'AI戦略コース',
//                             ),
//                             DropdownMenuItem(
//                               child: Text('Iotシステムコース'),
//                               value: 'Iotシステムコース',
//                             ),
//                             DropdownMenuItem(
//                               child: Text('ロボット開発コース'),
//                               value: 'ロボット開発コース',
//                             ),
//                             DropdownMenuItem(
//                               child: Text('ゲームプロデュースコース'),
//                               value: 'ゲームプロデュースコース',
//                             ),
//                             DropdownMenuItem(
//                               child: Text('CGアニメーションコース'),
//                               value: 'CGアニメーションコース',
//                             ),
//                             DropdownMenuItem(
//                               child: Text('なし'),
//                               value: 'なし',
//                             ),
//                           ],
//                           onChanged: (value) {
//                             setState(() {
//                               _course = value as String?;
//                             });
//                           },
//                           value: _course,
//                           //isExpanded: true,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 SizedBox(
//                   height: 16,
//                 ),

//                 Text(
//                   errorText,
//                   style: TextStyle(color: Colors.red),
//                 ),

//                 SizedBox(
//                   height: 16,
//                 ),
//                 //登録ボタン
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 80.0),
//                   child: GestureDetector(
//                     onTap: () async {
//                       createProfile(context);

//                       //createProfile();
//                     },
//                     child: Container(
//                       padding: EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                           color: Colors.blue[700],
//                           borderRadius: BorderRadius.circular(24)),
//                       child: Center(
//                           child: Text(
//                         'Create Profile',
//                         style: TextStyle(color: Colors.white, fontSize: 20),
//                       )),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )),
//         ));
//   }
// }
