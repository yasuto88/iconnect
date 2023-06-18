import 'dart:ui';

import 'package:app/pages/blocklist_setting_page.dart';
import 'package:app/pages/navi_page.dart';
import 'package:app/pages/notification_settings_page.dart';
import 'package:app/pages/other_settings_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  get message => null;

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
                '設定',
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
            child: Column(
          children: [
            blockList(),
            border(),
            notification(),
            border(),
            more(),
            border(),
            TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Navipage()));
                },
                child: Text('サインアウト'))
          ],
        )),
      )),
    );
  }
}

class more extends StatelessWidget {
  const more({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OtherSettingsPage()));
      },
      child: Container(
          height: 80,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  Icon(Icons.more_horiz),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'その他',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(Icons.chevron_right),
              )
            ],
          )),
    );
  }
}

class notification extends StatelessWidget {
  const notification({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NotificationSettingsPage()));
        },
        child: Container(
            height: 80,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    Icon(Icons.notifications),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '通知',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(Icons.chevron_right),
                )
              ],
            )));
  }
}

class blockList extends StatelessWidget {
  const blockList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => BlockListsSettingPage()));
        },
        child: Container(
            height: 80,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    Icon(Icons.block),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'ブロックリスト',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(Icons.chevron_right),
                )
              ],
            )));
  }
}

class border extends StatelessWidget {
  const border({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 0,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 2))),
    );
  }
}
