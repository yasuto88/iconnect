import 'package:flutter/material.dart';

import '../models/notification_models.dart';
import 'icon.dart';

final notificationModels = [
  notificationData('yasuto', 'assets/images/noAvatar.png', '13', '投稿しました'),
  notificationData('yasuto', 'assets/images/noAvatar.png', '13', '返信しました'),
  notificationData('yasuto', 'assets/images/noAvatar.png', '13', '投稿にいいねしました'),
  notificationData('yasuto', 'assets/images/noAvatar.png', '13', 'フォローしました'),
  notificationData('yasuto', 'assets/images/noAvatar.png', '13', '投稿しました'),
  notificationData('yasuto', 'assets/images/noAvatar.png', '13', '投稿しました'),
  notificationData('yasuto', 'assets/images/noAvatar.png', '13', '投稿しました'),
  notificationData('yasuto', 'assets/images/noAvatar.png', '13', '投稿しました'),
  notificationData('yasuto', 'assets/images/noAvatar.png', '13', '投稿しました'),
  notificationData('yasuto', 'assets/images/noAvatar.png', '13', '投稿しました'),
  notificationData('yasuto', 'assets/images/noAvatar.png', '13', '投稿しました'),
  notificationData('yasuto', 'assets/images/noAvatar.png', '13', '投稿しました'),
];

Widget NotificationCard(notificationData models) {
  return Container(
    padding: const EdgeInsets.all(1),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      //color: Color.fromARGB(255, 248, 252, 255),
    ),
    width: double.infinity,
    height: 80,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            width: 8,
          ),
          IconImg(image: models.icon),
          SizedBox(
            width: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${models.username}さん',
                style: TextStyle(fontSize: 20),
              ),
              Row(
                children: [
                  Text(
                    models.notificationMessage,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ]),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            '${models.notificationedTime}分前',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: notificationModels.length,
        itemBuilder: (c, i) => NotificationCard(notificationModels[i]),
      ),
    );
  }
}
