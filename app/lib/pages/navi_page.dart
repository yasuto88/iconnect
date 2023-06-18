import 'package:app/pages/home_page.dart';
import 'package:app/pages/login_page.dart';
import 'package:app/pages/message_page.dart';
import 'package:app/pages/notification_page.dart';
import 'package:app/pages/my_profile_page.dart';
import 'package:app/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../states/state.dart';

final indexProvider = StateProvider((ref) {
  return 0;
});

class Navipage extends ConsumerWidget {
  const Navipage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isLogin = ref.watch(signedInProvider);
    final index = ref.watch(indexProvider);

    const items = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
      BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'メッセージ'),
      BottomNavigationBarItem(
          icon: Icon(Icons.auto_stories_outlined), label: '教科'),
      BottomNavigationBarItem(icon: Icon(Icons.notifications), label: '通知'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'プロフィール'),
    ];
    final bar = BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: items,
      currentIndex: index,
      onTap: (index) {
        ref.read(indexProvider.notifier).state = index;
      },
    );
    final pages = [
      HomePage(),
      MessagePage(),
      SubjectPage(),
      NotificationPage(),
      MyProfilePage(),
    ];
    return Scaffold(
      body: IndexedStack(
          index: isLogin ? index : 0,
          children: isLogin ? pages : [LoginPage()]),
      backgroundColor: Colors.white,
      bottomNavigationBar: bar,
    );
  }
}
